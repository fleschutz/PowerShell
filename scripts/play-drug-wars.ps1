#Requires -Version 5.1
param (
    [switch]$SkipConsoleSizeCheck
)

[float]$script:GameVersion = 0.42

########################
#region Class Definitions
##########################
class GameStats {
    [int]$DrugsBought
    [int]$DrugsSold
    [int]$CitiesVisited
    [int]$FlightsTaken
    [int]$GunsBought
    [int]$CopFights
    [int]$EventsExperienced
    [int]$MostCashAtOnce
    hidden [string[]]$TravelPath

    # Constructor to initialize all properties to 0 or empty array
    GameStats() {
        $this.DrugsBought = 0
        $this.DrugsSold = 0
        $this.CitiesVisited = 0
        $this.FlightsTaken = 0
        $this.GunsBought = 0
        $this.CopFights = 0
        $this.EventsExperienced = 0
        $this.MostCashAtOnce = 0
        $this.TravelPath = @()
    }

    # Method to get all numeric properties as an array of strings
    # This method filters the properties of the GameStats object and returns only those with numeric values (int or double).
    # Each property name is formatted to split PascalCase or camelCase names, and the result is returned as an array of strings (in the order they are defined in the class).
    [string[]] GetPropertiesAsStrings() {
        # Get the properties of the GameStats object
        $properties = $this.PSObject.Properties

        # Create an array to hold the property values as strings
        $result = @()

        foreach ($property in $properties) {
            # Check if the property value is numeric
            if ($property.Value -is [int] -or $property.Value -is [double]) {
                # Perform the replacement inline to split PascalCase or camelCase names
                $formattedName = $property.Name -creplace '([a-z])([A-Z])', '$1 $2'
                $result += ('{0}: {1}' -f $formattedName, $property.Value)
            }
        }

        return $result
    }

    # Method to set the MostCashAtOnce property if it's lower than the provided amount
    [void] UpdateMostCashAtOnce([int]$Cash) {
        if ($Cash -gt $this.MostCashAtOnce) {
            $this.MostCashAtOnce = $Cash
        }
    }

    # Method to add a city (name) to the list of visited cities
    [void] AddVisitedCity([City]$City) {
        if ($null -ne $City -and -not [string]::IsNullOrEmpty($City.Name)) {
            $this.TravelPath += $City.Name
            $this.CitiesVisited = ($this.GetVisitedCityNames()).Count
            $this.FlightsTaken = $this.TravelPath.Count - 1
        }
        else {
            throw "City object or its Name property cannot be null or empty."
        }
    }

    # Method to retrieve the full list of visited city names, in the order visited.
    [string[]] GetTravelPath() {
        return $this.TravelPath
    }

    # Method to return the list of (unique) city names visited
    [string[]] GetVisitedCityNames() {
        return $this.TravelPath | Sort-Object -Unique
    }
}

class Drug {
    [string]$Name
    [string]$Code
    [string]$Description
    [int]$BasePrice
    [int[]]$PriceRange
    [float]$PriceMultiplier
    [int]$Quantity

    # Constructor that takes a drug name
    Drug([string]$Name) {
        $this.Name = $Name
        $this.Code = $script:DrugCodes.Keys | Where-Object { $script:DrugCodes[$_] -eq $Name }
        $this.Description = $script:DrugsInfo[$this.Code]['History']
        $this.PriceRange = $script:DrugsInfo[$this.Code]['PriceRange']
        $this.PriceMultiplier = 1.0
        $this.Quantity = 0
        $this.SetRandomBasePrice()
    }

    # Method to set the hidden BasePrice value to a random value from the drugs PriceRange, rounded to the nearest 10 dollars (Bankers' rounding).
    [void]SetRandomBasePrice() {
        $this.BasePrice = [int][math]::Round((Get-Random -Minimum $this.PriceRange[0] -Maximum $this.PriceRange[1]) / 10) * 10
    }

    # Calculate the price based on BasePrice and PriceMultiplier, rounded to the nearest 5 dollars (Bankers' rounding).
    [int]get_Price() {
        $price = [int][math]::Round($this.BasePrice * $this.PriceMultiplier / 5) * 5
        if ($price -lt 5) {
            $price = 5
        }
        return $price
    }
}

class City {
    [string]$Name
    [Drug[]]$Drugs
    [int]$MaxDrugCount
    [string[]]$HomeDrugNames
    [float]$HomeDrugSaleMultiplier
    [Gun[]]$GunsForSale
    [string]$GunShopName

    # Default constructor
    City() {
        # Drugs are assigned upon visiting the city (so they change each visit)
        $this.Drugs = @()

        # Guns are assigned after city is created
        $this.GunsForSale = @()
        # No name until a gun is added
        $this.GunShopName = $null

        # Assign 1 or 2 random 'Home Drugs' to each city
        $homeDrugCount = Get-Random -Minimum 1 -Maximum 3
        $this.HomeDrugNames = $script:DrugCodes.Keys | Get-Random -Count $homeDrugCount

        # Home Drugs are drugs that are always sold at a discount (if in stock). Default is 20% of the base price.
        $this.HomeDrugSaleMultiplier = .20
    }

    # Method to add a gun to the city's GunsForSale collection
    [void]AddGunToShop([Gun]$Gun) {
        $this.GunsForSale += $Gun

        $gunShopNames = @(
            'Aim High Ammunition Alley',
            'Ammo-nation',
            'Angry Hank''s Shot Shack',
            'Barrel of Laughs Gun Depot',
            'Bullet Bonanza Emporium',
            'Glock ''n Roll Firearms',
            'Guns ''n'' Giggles',
            'Laugh ''n'' Load Gunsmiths',
            'Lock, Stock, and Two Smokin'' Barrels',
            'Pistol Puns & Rifled Laughs',
            'Shoots & Ladders Armoury',
            'The Bang Theory Firearms',
            'The Bang-Bang Boutique',
            'The Trigger Happy Gun Shop',
            'Trigger Treats Gun Emporium'
        )

        if (-not $this.GunShopName) {
            $this.GunShopName = Get-Random -InputObject $gunShopNames
        }
    }

    # Method ot return if the city has guns for sale
    [bool]HasGunShop() {
        return $this.GunsForSale.Count -gt 0
    }
}

class Player {
    [string[]]$Clothing
    [City]$City
    [int]$Cash
    [Drug[]]$Drugs
    [int]$GameDay
    hidden [Gun[]]$Guns
    [string]$Initials
    hidden [int]$Pockets

    hidden [string[]]$starterClothes = @(
        'Bell-bottom pants',
        'Flannel shirt (buttoned Cholo-style)',
        '"I''m with Stupid ->" T-shirt',
        'Over-sized athletic jersey',
        'Pink Floyd T-shirt',
        'Smelly socks',
        'Smelly socks with a hole in them',
        'Terry-cloth bath robe',
        'Underwear, hanging out',
        'Velour track suit',
        'Wife-beater'
    )

    # Default constructor
    Player() {
        $this.Drugs = @()
        $this.Guns = @()
        $this.Clothing = $this.starterClothes | Get-Random
        $this.Pockets = 0
        $this.GameDay = 1
    }

    # FreePockets method returns the number of pockets minus the total Quntity of all Drugs
    [int]get_FreePocketCount() {
        $totalQuantity = $this.get_DrugCount()
        return $this.Pockets - $totalQuantity
    }

    # Method to get pocket count
    [int]get_PocketCount() {
        return $this.Pockets
    }

    # Method to set pocket count
    [void]set_PocketCount([int]$Pockets) {
        $this.Pockets = $Pockets
    }

    # Method to get total drug count from inventory
    [int]get_DrugCount() {
        $totalQuantity = 0
        $this.Drugs | ForEach-Object { $totalQuantity += $_.Quantity }
        return $totalQuantity
    }

    # Method to get guns
    [Gun[]]get_Guns() {
        return $this.Guns
    }

    # Method to dump all guns
    [void]DumpGuns() {
        $this.Guns = @()
    }

    [bool]AddGun([Gun]$Gun) {
        return $this.AddGun($Gun, $false)
    }

    # Method to add a gun to inventory
    [bool]AddGun([Gun]$Gun, [bool]$Silent = $false) {
        # Maximum two guns
        if ($this.Guns.Count -ge 2) {
            $tooManyGunsExpressions = @(
                "Whoa, slow down, Rambo! Two strapped guns are your limit, fam.`r`nWe don't want you to take off like a helicopter now.",
                "Hold your horses, cowboy! You're already packing a pair of heat, pal.`r`nAdding more would be like juggling flaming marshmallows - not a good idea, see?",
                "Easy there, gunslinger! Two guns are the magic number, amico.`r`nAdding more would be like trying to salsa dance with three left feet, capisce?",
                "Chill, action hero! You've already got a dynamic duo of guns, homey.`r`nAdding more would be like trying to breakdance on a tightrope, playa.",
                "Steady on, sharpshooter! You've got a couple of guns already, fella.`r`nAdding another one would be like trying to balance a porcupine on your nose, you hear?",
                "Whoa, trigger happy! Two guns are your lucky number, homey.`r`nAdding another one would be like trying to fit a giraffe into a phone booth."
            )
            $parts = (Get-Random -InputObject $tooManyGunsExpressions) -split "`r`n"
            $firstPart += $parts[0]
            $secondPart += $parts[1]
            Write-Centered ($firstPart) -ForegroundColor Red
            Start-Sleep 2
            Write-Host
            Write-Centered ($secondPart) -ForegroundColor DarkGray
            Start-Sleep 2
            Write-Host
            return $false
        }

        if (-not $Silent) {
            $newGunExpressions = @(
                ('You got a {0}! Nice! Just remember, with great firepower comes great responsibility.' -f $Gun.Name),
                ('You got a {0}! Keep it strapped, fam! It''s like having a Swiss Army knife, but, you know, for the streets or some shit.' -f $Gun.Name),
                ('Big man! Packin'' heat with a {0}! Who needs biceps when you''ve got barrels, am I right?' -f $Gun.Name),
                ('Say hello to my little friend! "Hello {0}."' -f $Gun.Name),
                ('Congrats, sharpshooter! You snagged a {0}! The only thing hotter than the barrel is your style.' -f $Gun.Name),
                ('Hasta la vista, budget constraints! You''re now the proud owner of a {0}! Pew-pew dreams do come true.' -f $Gun.Name),
                ('Well, look who''s the proud parent of a bouncing baby {0}! Parenthood, gun-style, fam.' -f $Gun.Name),
                ('You got a {0}! Time to start practicing your action movie one-liners. "Yippee-ki-yay, {0}-lover!"' -f $Gun.Name),
                ('Boom shakalaka! You''ve upgraded to a {0}! Watch out, world - you''re armed and hilarious.' -f $Gun.Name),
                ('Woo-hoo! You got a {0}! It''s like winning the lottery, but with more pew-pew and fewer numbers.' -f $Gun.Name)
            )
            Write-Centered (Get-Random -InputObject $newGunExpressions)
            Start-Sleep 2
        }

        $this.Guns += $Gun
        return $true
    }

    # Method to remove a gun from inventory
    [void]RemoveGun([Gun]$Gun) {
        $this.Guns = $this.Guns | Where-Object { $_.Name -ne $Gun.Name }
    }

    # Method to Buy a gun
    [void]BuyGun([Gun]$Gun) {
        # If the player doesn't have enough cash, print a message and return
        if ($Gun.Price -gt $this.Cash) {
            $gunPurchasePhrases = @(
                "Oops! Your wallet's on a diet - can't afford that fancy {0} right now.`r`nTime to channel your inner magpie, my friend!",
                "Uh-oh! Your cash stash is more elusive than Bigfoot when it comes to buying a {0}, homey.`r`nGet those brainstorming wheels turning, pal!",
                "Houston, we have a cash-flow problem! Buying a {0}, fam, requires some next-level haggling skills.`r`nPrepare for liftoff, friend!",
                "Breaking news: Your wallet just declared bankruptcy in the face of that {0}, pal.`r`nLet's brainstorm ways to turn pocket lint into gold, buddy!",
                "Ay caramba! Your dinero isn't playing nice with the idea of a {0}, amigo.`r`nTime for a financial fiesta, compadre!",
                "Eh, capisce? Your wallet's playing hard to get with that {0}.`r`nLet's hustle, my nonna-lovin' friend - maybe she's got a secret stash!"
            )
            $parts = (Get-Random -InputObject $gunPurchasePhrases) -split "`r`n"
            $firstPart += $parts[0]
            $secondPart += $parts[1]
            Write-Centered ($firstPart -f $Gun.Name) -ForegroundColor Yellow
            Start-Sleep 1
            Write-Centered ($secondPart) -ForegroundColor DarkGray
            Start-Sleep 2
            Write-Host
            return
        }

        # If the player has enough cash, and can add the gun to their inventory, buy the gun.
        if ($this.AddGun($Gun)) {
            # Pay for gun
            $this.Cash -= $Gun.Price

            # Track gun purchase in Game Statistics
            $script:GameStats.GunsBought++

            Write-Host
            Write-Centered ('You bought a {0} for ${1}.' -f $Gun.Name, $Gun.Price) -ForegroundColor Green
            Start-Sleep -Milliseconds 1500
            Write-Host
            # Display the gun's description and history
            Write-Centered $Gun.Description -ForegroundColor White
            Start-Sleep -Milliseconds 1500
            Write-Centered $Gun.History -ForegroundColor DarkGray
        }
        Start-Sleep 3
    }

    # Method to sell a gun
    [void]SellGun([Gun]$Gun) {
        # Find the first gun in the player's inventory that matches the given name
        $gunToSell = $this.Guns | Where-Object { $_.Name -eq $Gun.Name } | Select-Object -First 1

        Write-Host

        # If the gun was found
        if ($gunToSell) {
            # Increase the player's cash by 70% of the gun's price
            $gunSellPrice = $gunToSell.Price * 0.70
            $this.Cash += $gunSellPrice

            # Update MostCashAtOnce stats by comparing player's current cash
            $script:GameStats.UpdateMostCashAtOnce($this.Cash)

            # Remove the sold gun from the player's inventory.
            $this.Guns = $this.Guns | Where-Object { $_.Name -ne $gunToSell.Name } | Select-Object -First 1

            Write-Centered ('You sold your {0} for ${1}.' -f $gunToSell.Name, $gunSellPrice) -ForegroundColor Green
        }
        else {
            Write-Centered ('You don''t have a {0} to sell.' -f $gunToSell.Name) -ForegroundColor Red
        }
        Start-Sleep 3
        Write-Host
    }

    # Method to get total stopping power of all guns
    [int]get_StoppingPower() {
        $stoppingPower = 0
        foreach ($gun in $this.Guns) {
            $stoppingPower += $gun.StoppingPower
        }
        return $stoppingPower
    }

    # Method to adjust pocket count up or down
    [void]AdjustPocketCount([int]$Pockets) {
        if ($Pockets -lt 0) {
            # Remove specified number of pockets (by adding the negative amount provided)
            $this.Pockets += $Pockets

            # Get a count of all drugs in the player's inventory
            $totalQuantity = 0
            $this.Drugs | ForEach-Object { $totalQuantity += $_.Quantity }

            # If the player has more drugs than pockets, remove some excess drugs
            if ($totalQuantity -gt $this.Pockets) {

                Write-Centered 'You don''t have enough pockets to hold all your drugs!' -ForegroundColor Yellow
                Start-Sleep -Seconds 2

                $difference = $totalQuantity - $this.Pockets

                # While the difference is greater than 0, cycle through the drugs in inventory, removing 1 of each until the difference is 0.
                while ($difference -gt 0) {
                    foreach ($drug in $this.Drugs) {
                        $this.RemoveDrugs($drug, 1)
                        Write-Centered ('You had to throw away 1 {0}.' -f $drug.Name) -ForegroundColor DarkRed
                        $difference -= 1
                        if ($difference -le 0) {
                            break
                        }
                    }
                }
            }
        }
        else {
            $this.Pockets += $Pockets
        }
    }

    # Method to add drugs to the player's Drugs collection.
    [void]AddDrugs([Drug]$Drug) {
        # Minimum Add is 1
        if ($Drug.Quantity -lt 1) {
            Write-Host 'You must add at least 1 of a drug.'
            return
        }

        # Check if there's enough free pockets
        if ($this.get_FreePocketCount() -ge $Drug.Quantity) {
            # If the player already has some of the drug, add the quantity to the existing drug, otherwise add the drug to the player's Drugs collection.
            $myMatchingDrug = $this.Drugs | Where-Object { $_.Name -eq $Drug.Name }
            if ($myMatchingDrug) {
                $myMatchingDrug.Quantity += $Drug.Quantity
            }
            else {
                $this.Drugs += $Drug
            }
        }
        else {
            Write-Host "Not enough free pockets to add this drug."
        }
    }

    # Method to remove drugs from the player's Drugs collection.
    [void]RemoveDrugs([Drug]$Drug, [int]$Quantity) {
        # If the player has some of the drug, remove the quantity from the existing drug, otherwise do nothing.
        $myMatchingDrug = $this.Drugs | Where-Object { $_.Name -eq $Drug.Name }
        if ($myMatchingDrug) {
            $myMatchingDrug.Quantity -= $Quantity
            if ($myMatchingDrug.Quantity -le 0) {
                # None left, remove the Drug object from the Drugs collection.
                $this.Drugs = $this.Drugs | Where-Object { $_.Name -ne $Drug.Name }
            }
        }
        else {
            Write-Host 'You don''t have any of that drug.'
        }
    }

    # Method to buy drugs.
    [void]BuyDrugs([Drug]$Drug) {
        # Get the drug from the city's drug list (if it's available)
        $cityDrug = $this.City.Drugs | Where-Object { $_.Name -eq $Drug.Name }

        # Use a switch statement to handle different conditions (run teh first block that's "True")
        switch ($true) {
            # If the drug is not available in the city, print a message and return
            (-not $cityDrug) {
                $wachoo = @('Whutchoo talkin'' about, Willis?', 'Are you high?', 'You''re trippin''!', 'You drunk?')
                Write-Host ('{0} {1} is not available in {2}.' -f (Get-Random -InputObject $wachoo), $Drug.Name, $this.City.Name)
                break
            }
            # If the quantity is less than 1, print a message and return
            ($Drug.Quantity -lt 1) {
                Write-Host ('You really trying to buy {0} drugs...?' -f $Drug.Quantity)
                $whoyou = @('M.C. Escher', 'Salvador Dali', 'David Blaine', 'Doug Henning')
                Write-Host ('Who are you? {0} or some shit?' -f (Get-Random -InputObject $whoyou))
                break
            }
            # If the drug is available and the quantity is valid, proceed to buy
            default {
                # Calculate the total price
                $totalPrice = $Drug.Quantity * $Drug.get_Price()
                # If the player doesn't have enough cash, print a message and return
                if ($totalPrice -gt $this.Cash) {
                    Write-Host ('You don''t have enough cash to buy that much {0}.' -f $Drug.Name)
                    break
                }
                # If the quantity being bought is greater than the number of free pockets, print a message and return
                $freePockets = $this.get_FreePocketCount()
                if ($Drug.Quantity -gt $freePockets) {
                    Write-Host ('You don''t have enough free pockets to hold that much {0}.' -f $Drug.Name)
                    break
                }
                # If the player has enough cash and free pockets, buy the drugs
                $this.Cash -= $totalPrice

                Write-Host ('You bought {0} {1} for ${2}.' -f $Drug.Quantity, $Drug.Name, $totalPrice)
                $this.AddDrugs($Drug)

                # Track drug purchase in Game Statistics
                $script:GameStats.DrugsBought += $Drug.Quantity
            }
        }
        # Pause for 3 seconds before returning
        Start-Sleep 3
    }

    # Method to sell drugs.
    [void]SellDrugs([Drug]$Drug, [int]$Quantity) {

        # Look up the drug by name in the current City's drug list.
        $cityDrug = $this.City.Drugs | Where-Object { $_.Name -eq $Drug.Name }

        # Calculate the total price (using the city's price for the drug)
        $totalPrice = $cityDrug.get_Price() * $Quantity

        # Check if the player has enough quantity of the drug
        $drugToSell = $this.Drugs | Where-Object { $_.Name -eq $Drug.Name }
        if ($drugToSell.Quantity -lt $Quantity) {
            Write-Host ('You don''t have enough {0} to sell.' -f $Drug.Name)
            return
        }

        # If the player has enough quantity of the drug, sell the drugs
        $this.RemoveDrugs($Drug, $Quantity)
        $this.Cash += $totalPrice
        Write-Host ('You sold {0} {1} for ${2}.' -f $Quantity, $Drug.Name, $totalPrice)

        # Track drug sale in Game Statistics
        $script:GameStats.DrugsSold += $Quantity

        # Update MostCashAtOnce stats by comparing player's current cash
        $script:GameStats.UpdateMostCashAtOnce($script:Player.Cash)
    }

    # Method to add items to the player's Clothing collection.
    [bool]AddClothing([string]$Item) {
        # If the player already has the item, return false
        if ($this.Clothing -contains $Item) {
            return $false
        }
        # Otherwise, add the item to the player's Clothing and return true.
        else {
            $this.Clothing += $Item
            return $true
        }
    }

    # Method to change base outfit.
    [string]ChangeOutfit() {
        $currentStarterClothes = $this.starterClothes | Where-Object { $this.Clothing -contains $_ }

        # Remove any clothing that is in the starterClothes list.
        $this.Clothing = $this.Clothing | Where-Object { $this.starterClothes -notcontains $_ }

        # Put on a random new one, that isn't in $currentStarterClothes
        $newClothing = $this.starterClothes | Where-Object { $_ -notin $currentStarterClothes } | Get-Random

        # Add the new clothing to the top of the list
        $otherClothes = $this.Clothing
        $this.Clothing = @($newClothing)

        # Add the other clothing back to the list (unless it's null)
        if ($otherClothes) {
            $this.Clothing += $otherClothes
        }

        # Return the new clothing
        return $newClothing
    }
}

class Gun {
    [string]$Name
    [string]$Type
    [int]$Price
    [int]$StoppingPower
    [string]$Description
    [string]$History

    Gun ($gunInfo) {
        $this.Name = $gunInfo.Name
        $this.Type = $gunInfo.Type
        $this.Price = $gunInfo.Price
        $this.StoppingPower = $gunInfo.StoppingPower
        $this.Description = $gunInfo.Description
        $this.History = $gunInfo.History
    }
}
###########################
#endregion Class Definitions
#############################

##########################################
#region Define Script-Wide Lists and Tables
############################################
# Define drugs names and codes
$script:DrugCodes = @{
    'AD' = 'Angel Dust'
    'CD' = 'Codeine'
    'CN' = 'Cocaine'
    'CK' = 'Crack'
    'DM' = 'DMT'
    'EC' = 'Ecstasy'
    'FT' = 'Fentanyl'
    'HN' = 'Heroin'
    'HS' = 'Hash'
    'KM' = 'Ketamine'
    'LD' = 'LSD'
    'LU' = 'Ludes'
    'MC' = 'Mescaline'
    'MN' = 'Morphine'
    'MT' = 'Meth'
    'OP' = 'Opium'
    'OX' = 'Oxy'
    'PA' = 'Peyote'
    'PO' = 'Poppers'
    'RT' = 'Ritalin'
    'SH' = 'Shrooms'
    'SP' = 'Speed'
    'VI' = 'Vicodin'
    'WD' = 'Weed'
    'XN' = 'Xanax'
}

# Define information about each drug
$script:DrugsInfo = @{
    'AD' = @{
        'Name'        = 'Angel Dust'
        'StreetNames' = @('PCP', 'Sherm', 'Embalming Fluid')
        'History'     = 'Developed as a dissociative anesthetic, Angel Dust gained popularity in the 1960s. Discontinued for medical use due to its unpredictable and severe side effects.'
        'Effects'     = 'Hallucinations, distorted perceptions of reality, increased strength, and a dissociative state.'
        'PriceRange'  = @(500, 2000)
    }
    'CD' = @{
        'Name'        = 'Codeine'
        'StreetNames' = @('Lean', 'Purple Drank', 'Sizzurp')
        'History'     = 'Codeine is an opiate used for pain relief. It has been used recreationally, often mixed with soda and candy, particularly in hip-hop culture.'
        'Effects'     = 'Euphoria, relaxation, and mild sedation.'
        'PriceRange'  = @(20, 150)
    }
    'CN' = @{
        'Name'        = 'Cocaine'
        'StreetNames' = @('Coke', 'Blow', 'Snow')
        'History'     = 'Derived from coca plants, cocaine became popular in the 1970s and 1980s as a recreational stimulant. Its use is associated with a high risk of addiction.'
        'Effects'     = 'Increased energy, alertness, and euphoria.'
        'PriceRange'  = @(100, 500)
    }
    'CK' = @{
        'Name'        = 'Crack'
        'StreetNames' = @('Freebase', 'Rock', 'Base')
        'History'     = 'Crack cocaine is a crystallized form of cocaine. It emerged in the 1980s, contributing to the "crack epidemic" in the United States.'
        'Effects'     = 'Intense, short-lived euphoria, increased heart rate, and heightened alertness.'
        'PriceRange'  = @(50, 300)
    }
    'DM' = @{
        'Name'        = 'DMT'
        'StreetNames' = @('Dimitri', 'Businessman''s Trip')
        'History'     = 'DMT is a naturally occurring psychedelic compound found in certain plants. Its use in shamanic rituals dates back centuries.'
        'Effects'     = 'Intense, short-lasting hallucinations, a sense of entering otherworldly realms.'
        'PriceRange'  = @(100, 1000)
    }
    'EC' = @{
        'Name'        = 'Ecstasy'
        'StreetNames' = @('MDMA', 'Molly', 'E', 'X')
        'History'     = 'Originally used in psychotherapy, ecstasy gained popularity in the 1980s as a recreational drug.'
        'Effects'     = 'Enhanced sensory perception, increased empathy, and heightened emotions.'
        'PriceRange'  = @(5, 50)
    }
    'FT' = @{
        'Name'        = 'Fentanyl'
        'StreetNames' = @('China White', 'Apache', 'Dance Fever')
        'History'     = 'Developed as a potent painkiller, fentanyl has been linked to a surge in opioid-related overdoses due to its high potency.'
        'Effects'     = 'Intense euphoria, drowsiness, and respiratory depression.'
        'PriceRange'  = @(100, 500)
    }
    'HN' = @{
        'Name'        = 'Heroin'
        'StreetNames' = @('Smack', 'Junk', 'H')
        'History'     = 'Derived from morphine, heroin was initially marketed as a non-addictive alternative. Its recreational use rose in the mid-20th century.'
        'Effects'     = 'Euphoria, sedation, pain relief.'
        'PriceRange'  = @(50, 300)
    }
    'HS' = @{
        'Name'        = 'Hash'
        'StreetNames' = @('Hashish', 'Hash Oil', 'Dabs')
        'History'     = 'Hash is a concentrated form of cannabis resin. It has a long history of use in various cultures for spiritual and recreational purposes.'
        'Effects'     = 'Relaxation, euphoria, altered perception of time.'
        'PriceRange'  = @(10, 100)
    }
    'KM' = @{
        'Name'        = 'Ketamine'
        'StreetNames' = @('Special K', 'K', 'Vitamin K')
        'History'     = 'Initially used as an anesthetic, ketamine gained popularity as a recreational drug with dissociative effects.'
        'Effects'     = 'Hallucinations, dissociation, altered perception of time and space.'
        'PriceRange'  = @(50, 500)
    }
    'LD' = @{
        'Name'        = 'LSD'
        'StreetNames' = @('Acid', 'Tabs', 'Blotter')
        'History'     = 'Discovered in the 1930s, LSD became popular in the 1960s counter-culture. It''s known for its profound psychedelic effects.'
        'Effects'     = 'Hallucinations, altered perception of reality, heightened sensory experiences.'
        'PriceRange'  = @(50, 300)
    }
    'LU' = @{
        'Name'        = 'Ludes'
        'StreetNames' = @('Quaaludes', 'Disco Biscuits')
        'History'     = 'Methaqualone, commonly known as Quaaludes, was a sedative-hypnotic drug popular in the 1970s. It was later classified as a controlled substance.'
        'Effects'     = 'Muscle relaxation, sedation, euphoria.'
        'PriceRange'  = @(100, 800)
    }
    'MC' = @{
        'Name'        = 'Mescaline'
        'StreetNames' = @('Peyote', 'Buttons', 'Cactus')
        'History'     = 'Mescaline is a naturally occurring psychedelic found in certain cacti, notably peyote. It has been used in Native American rituals for centuries.'
        'Effects'     = 'Visual hallucinations, altered perception, and enhanced sensory experiences.'
        'PriceRange'  = @(50, 500)
    }
    'MN' = @{
        'Name'        = 'Morphine'
        'StreetNames' = @('Dreamer', 'Mister Blue')
        'History'     = 'Derived from opium, morphine has been used for pain relief since the 19th century. It remains a powerful opioid analgesic.'
        'Effects'     = 'Pain relief, euphoria, sedation.'
        'PriceRange'  = @(50, 300)
    }
    'MT' = @{
        'Name'        = 'Meth'
        'StreetNames' = @('Crystal', 'Ice', 'Glass')
        'History'     = 'Methamphetamine, a potent stimulant, gained popularity for recreational use and as an illicit substance in the mid-20th century.'
        'Effects'     = 'Increased energy, alertness, euphoria.'
        'PriceRange'  = @(50, 500)
    }
    'OP' = @{
        'Name'        = 'Opium'
        'StreetNames' = @('Dopium', 'Chinese Tobacco', 'Midnight Oil')
        'History'     = 'Opium has a long history of use dating back centuries. It was widely used for medicinal and recreational purposes, leading to addiction issues.'
        'Effects'     = 'Pain relief, relaxation, euphoria.'
        'PriceRange'  = @(100, 800)
    }
    'OX' = @{
        'Name'        = 'Oxy'
        'StreetNames' = @('Oxycodone', 'Hillbilly Heroin', 'OxyContin')
        'History'     = 'Oxycodone, commonly known as Oxy, is a prescription opioid. It became widely abused for its pain-relieving and euphoric effects.'
        'Effects'     = 'Pain relief, relaxation, euphoria.'
        'PriceRange'  = @(50, 300)
    }
    'PA' = @{
        'Name'        = 'Peyote'
        'StreetNames' = @('Mescaline', 'Buttons', 'Cactus')
        'History'     = 'Peyote is a small, spineless cactus containing mescaline. It has been used in Native American religious ceremonies for centuries.'
        'Effects'     = 'Visual hallucinations, altered perception, and enhanced sensory experiences.'
        'PriceRange'  = @(100, 800)
    }
    'PO' = @{
        'Name'        = 'Poppers'
        'StreetNames' = @('Rush', 'Locker Room', 'Snappers')
        'History'     = 'Poppers are a type of alkyl nitrite inhalant. They have been used recreationally, especially in club and party scenes, for their brief but intense effects.'
        'Effects'     = 'Head rush, warm sensations, and intensified sensory experiences.'
        'PriceRange'  = @(5, 50)
    }
    'RT' = @{
        'Name'        = 'Ritalin'
        'StreetNames' = @('Rids', 'Vitamin R', 'Skittles')
        'History'     = 'Ritalin, or methylphenidate, was developed in the 1950s as a treatment for attention deficit hyperactivity disorder (ADHD). FDA-approved, it has since been prescribed for ADHD and narcolepsy.'
        'Effects'     = 'Stimulant effects include increased focus, alertness, and energy.'
        'PriceRange'  = @(5, 50)
    }
    'SH' = @{
        'Name'        = 'Shrooms'
        'StreetNames' = @('Magic Mushrooms', 'Psilocybin', 'Caps')
        'History'     = 'Psychedelic mushrooms, or shrooms, have been used in various cultures for their hallucinogenic properties. They gained popularity in the counterculture movements of the 1960s.'
        'Effects'     = 'Altered perception, visual hallucinations, introspective experiences.'
        'PriceRange'  = @(20, 200)
    }
    'SP' = @{
        'Name'        = 'Speed'
        'StreetNames' = @('Amphetamine', 'Uppers', 'Dexies')
        'History'     = 'Amphetamines have a long history of medical use and gained popularity as stimulants in the mid-20th century.'
        'Effects'     = 'Increased energy, alertness, heightened focus.'
        'PriceRange'  = @(50, 500)
    }
    'VI' = @{
        'Name'        = 'Vicodin'
        'StreetNames' = @('Hydro', 'Vikes', 'Watsons')
        'History'     = 'Vicodin is a combination of hydrocodone and acetaminophen used for pain relief. It has been widely prescribed but is associated with the risk of addiction.'
        'Effects'     = 'Pain relief, relaxation, mild euphoria.'
        'PriceRange'  = @(100, 800)
    }
    'WD' = @{
        'Name'        = 'Weed'
        'StreetNames' = @('Marijuana', 'Cannabis', 'Pot')
        'History'     = 'Cannabis has been used for various purposes for thousands of years. It gained popularity for recreational use in the 20th century.'
        'Effects'     = 'Relaxation, euphoria, altered sensory perception.'
        'PriceRange'  = @(10, 100)
    }
    'XN' = @{
        'Name'        = 'Xanax'
        'StreetNames' = @('Bars', 'Benzos', 'Zannies')
        'History'     = 'Xanax, a benzodiazepine, is prescribed for anxiety. Its recreational use has become a concern due to the risk of dependence.'
        'Effects'     = 'Relaxation, sedation, anti-anxiety effects.'
        'PriceRange'  = @(50, 300)
    }
}

# Define available cities
$script:CityNames = @(
    "Acapulco, Mexico",
    "Amsterdam, Netherlands",
    "Bangkok, Thailand",
    "Hong Kong, China",
    "Istanbul, Turkey",
    "Lisbon, Portugal",
    "London, UK",
    "Marseilles, France",
    "Medellin, Colombia",
    "Mexico City, Mexico",
    "Miami, USA",
    "Marrakesh, Morocco",
    "New York City, USA",
    "Panama City, Panama",
    "Phuket, Thailand",
    "San Francisco, USA",
    "Sydney, Australia",
    "Tehran, Iran",
    "Tijuana, Mexico",
    "Toronto, Canada",
    "Vancouver, Canada"
)

# Define random events
$script:RandomEvents = @(
    @{
        "Name"        = "Busted"
        "Description" = 'You were busted by the cops!'
        "Effect"      = {
            Start-Sleep -Seconds 3
            # If player has no drugs on them, the cops leave them alone
            if ($script:Player.Drugs.Count -eq 0) {
                Write-Centered 'You were searched, but you didn''t have any drugs on you!'
                Write-Host

                # If the player has any guns, select a random gun from the player's inventory,
                # remove it, and display a message indicating which gun was taken.
                if ($script:Player.Guns.Count -gt 0) {
                    $randomIndex = Get-Random -Minimum 0 -Maximum $script:Player.Guns.Count
                    $gunTaken = $script:Player.Guns[$randomIndex]
                    $script:Player.RemoveGun($gunTaken)
                    Write-Centered ('The cops let you go with a warning, but they confiscated your {0}!' -f $gunTaken.Name) -ForegroundColor DarkRed
                }
                else {
                    Write-Centered 'The cops let you go with a warning.' -ForegroundColor DarkGreen
                }

                $randomNumber = Get-Random -Minimum 1 -Maximum 101
                if (($randomNumber -le 80) -and ($script:Player.Cash -gt 50)) {
                    Start-Sleep -Seconds 2
                    # Cops let you go, but take 5% of your cash (or $50, whichever is higher)
                    Write-Centered '...and give you a bit of a shake-down.' -ForegroundColor Yellow
                    Start-Sleep -Seconds 3
                    $loss = [math]::Max([int]([math]::Round($script:Player.Cash * 0.05)), 50)
                    $script:Player.Cash = $script:Player.Cash - $loss
                    Write-Host
                    Write-Centered ('They took ${0}!' -f $loss) -ForegroundColor DarkRed
                }

                Start-Sleep -Seconds 3
                return
            }

            # Calculate the bust chance. The base chance is 0%, and it increases by 5% for each $1000 the player has. Capped at 60%.
            [float]$bustChance = 0.0
            if ($script:Player.Cash -gt 0) {
                $bustChance = [Math]::Min($script:Player.Cash / 1000 * 0.05, 0.6)
            }

            # Generate a random decimal number between 0 and 1
            [float]$randomNumber = Get-Random -Minimum 0.0 -Maximum 1.0
            # If the random number is less than or equal to the bust chance, the cops bust the player
            if ($randomNumber -le $bustChance) {
                if ($script:Player.get_Guns().Count -gt 0) {
                    Write-Centered 'You spent the night in jail and lost all your drugs and guns.' -ForegroundColor Red
                }
                else {
                    Write-Centered 'You spent the night in jail and lost all your drugs.' -ForegroundColor Red
                }

                # Remove all drugs from the player's possession
                $script:Player.Drugs = @()
                # Remove all the player's guns.
                $script:Player.DumpGuns()
                # Increment the game day
                AdvanceGameDay -SkipPriceUpdate
            }
            else {
                # Create an array of messages
                $messages = @(
                    'They searched you, but you got away!',
                    'You were searched, but managed to slip away!',
                    'They tried to catch you, but you were too quick!',
                    'You were almost caught, but you escaped!',
                    'They attempted to search you, but you evaded them!',
                    'You narrowly avoided being searched!',
                    'They let you go with a warning!',
                    'You played hide and seek with the search party, and you won!',
                    'You turned the search into a dance-off and moonwalked out of trouble!',
                    'They tried to catch you, but you hit them with your "Invisible Cloak of Inconspicuousness"(tm)!',
                    'You transformed the search into a magic show and disappeared in a puff of glitter!',
                    'You were almost caught, but you executed the perfect ninja smoke bomb escape!',
                    'They attempted to search you, but you pulled out a trombone and started a parade distracting them!',
                    'You narrowly avoided being searched by unleashing your inner contortionist and slipping through their fingers!',
                    'They let you go with a warning, probably because they were impressed by your interpretive dance routine!'
                )

                # Select a random message
                $message = Get-Random -InputObject $messages

                # Display the message
                Write-Host
                Write-Centered $message -ForegroundColor DarkGreen
            }

            Start-Sleep -Seconds 3
        }
    },
    @{
        "Name"        = "Flash Back"
        "Description" = "You trip out and lose a day!"
        "Effect"      = {
            Tripout
            AdvanceGameDay -SkipPriceUpdate
        }
    },
    @{
        "Name"        = "Marrakesh Express"
        "Description" = "The Marrakesh Express has arrived in town!"
        "Effect"      = {
            # Add some random "Hash" Drugs to the player's inventory, if they already have Hash, just add to its quantity.
            $giveAwayQuantity = Get-Random -Minimum 5 -Maximum 26
            Write-Centered ('They''re giving out {0} pockets of free Hash!' -f $giveAwayQuantity)
            Write-Host

            # If they have free pockets to hold the Hash, add as much to their inventory as possible.
            if ($script:Player.get_FreePocketCount() -ge 1) {
                if ($script:Player.get_FreePocketCount() -lt $giveAwayQuantity) {
                    Write-Centered ('You only have room for {0} pockets of free Hash.' -f $script:Player.get_FreePocketCount()) -ForegroundColor Yellow
                    Start-Sleep -Seconds 2
                    Write-Centered 'But that''s still better than a kick in the ass''! :)'
                    $giveAwayQuantity = $script:Player.get_FreePocketCount()
                }

                $freeHash = $script:Player.Drugs | Where-Object { $_.Name -eq 'Hash' }
                if ($freeHash) {
                    $freeHash.Quantity += $giveAwayQuantity
                }
                else {
                    $freeHash = [Drug]::new('Hash')
                    $freeHash.Quantity = $giveAwayQuantity
                    $script:Player.AddDrugs($freeHash)
                }

                Write-Centered ('Filled {0} pockets with free Hash!' -f $giveAwayQuantity) -ForegroundColor DarkGreen
            }
            else {
                Write-Centered 'Bummer! You don''t have any empty pockets to hold the free Hash.'
                Start-Sleep -Seconds 3
                Write-Host
                if ((Write-BlockLetters '** BURN!! **' -ForegroundColor Black -BackgroundColor DarkRed -Align Center -VerticalPadding 1) -eq $false) {
                    Write-Centered ' ' -BackgroundColor DarkRed
                    Write-Centered '** BURN!! **' -ForegroundColor Black -BackgroundColor DarkRed
                    Write-Centered ' ' -BackgroundColor DarkRed
                }
                Start-Sleep -Seconds 2
            }
        }
    },
    @{
        "Name"        = "Bad Batch"
        "Description" = "You got a bad batch of drugs. You lose 10% of your cash trying to get rid of it."
        "Effect"      = {
            # Calculate 10% of the player's cash, rounded to the nearest dollar
            $loss = [int]([math]::Round($script:Player.Cash * 0.10))
            # Subtract the loss from the player's cash.
            $script:Player.Cash -= $loss

            Start-Sleep -Seconds 2
            Write-Host
            Write-Centered ('You lost ${0}.' -f $loss) -ForegroundColor DarkRed
            Start-Sleep -Seconds 2
        }
    },
    @{
        "Name"        = 'The Shadow'
        "Description" = 'A shadowy figure approaches you and whispers, "Psst... I know when the next Home Drug Sale Day is..."'
        "Effect"      = {
            # Figure out when next Home Drug sale day is from $script:HomeDrugSaleDays list
            $nextSaleDay = $script:HomeDrugSaleDays | Sort-Object | Where-Object { $_ -gt $script:Player.GameDay } | Select-Object -First 1
            $daysUntilNextSale = $nextSaleDay - $script:Player.GameDay

            Start-Sleep -Seconds 3
            Write-Host
            if ($nextSaleDay) {
                Write-Centered ('The shadowy figure tells you that the next Home Drug Sale Day is in {0} days, on day {1}.' -f $daysUntilNextSale, $nextSaleDay) -ForegroundColor DarkYellow
            }
            else {
                $noDrugSaleDaysLeftMsg = @(
                    "Ain't no more Home Drug Sale Days, pal. You snooze, you lose, capisce?",
                    "That Home Drug Sale Days ship sailed, buddy. Better luck next time!",
                    "Home Drug Sale Days? Nah, those are long gone, kid. Better ask the boss about 'em.",
                    "Yo, ain't no more Home Drug Sale Days, fool. Guess you missed the party, huh?",
                    "No more Home Drug Sale Days, champ. What, you just crawled outta a rock?",
                    "Those Home Drug Sale Days? Gone quicker than your paycheck, homie.",
                    "Forget about it! No more Home Drug Sale Days, wiseguy. Try again next year!",
                    "Aww, you late for Home Drug Sale Days? Too bad, player, game's over.",
                    "Home Drug Sale Days are history, see? You're gonna have to find your own score now.",
                    "No Home Drug Sale Days left, sucka. Guess you didn't get the memo!",
                    "Whoa, man, the Home Drug Sale Days are, like, totally over. You missed the cosmic wave, dude.",
                    "Home Drug Sale Days? Nah, those are long gone, brother. The universe has spoken.",
                    "Sorry, friend, no more Home Drug Sale Days. Guess the vibes didn't align this time.",
                    "Oh, bummer, dude. Home Drug Sale Days? They're, like, a thing of the past now, ya know?",
                    "Home Drug Sale Days? Yeah, they've floated away with the breeze, man. Better luck next trip!"
                )

                $noSaleDaysLeftMsg = Get-Random -InputObject $noDrugSaleDaysLeftMsg
                Write-Centered $noSaleDaysLeftMsg -ForegroundColor DarkYellow
            }

            Start-Sleep -Seconds 2

            Write-Centered ('He then looks around and...')
            Start-Sleep -Seconds 3
            $chance = Get-Random -Minimum 0 -Maximum 3
            if ($chance -eq 0) {
                $cashToGive = [math]::Round($script:Player.Cash * 0.05)
                $script:Player.Cash += $cashToGive
                Write-Centered ('You got lucky! The shadowy figure gave you ${0}.' -f $cashToGive) -ForegroundColor DarkGreen
            }
            elseif ($chance -eq 1) {
                $cashToTake = [math]::Round($script:Player.Cash * 0.05)
                $script:Player.Cash -= $cashToTake
                Write-Centered ('Oh no! The shadowy figure stuck you up and took ${0}.' -f $cashToTake) -ForegroundColor DarkRed
            }
            else {
                Write-Centered 'Nothing happened. Get back to hustlin''!'
            }

            Start-Sleep -Seconds 2
        }
    },
    @{
        "Name"        = "Someone's Wallet"
        "Description" = "You found a wallet full of cash laying in the gutter!"
        "Effect"      = {
            $gain = Get-Random -Minimum 100 -Maximum 501
            # Round the gain to the nearest 10 (Bankers' rounding).
            $gain = [math]::Round($gain / 10) * 10
            $script:Player.Cash += $gain

            Start-Sleep -Seconds 2
            Write-Host
            Write-Centered ('NICE! You gained ${0}.' -f $gain) -ForegroundColor DarkGreen
            Start-Sleep -Seconds 2
        }
    },
    @{
        "Name"        = "Found Vape Pen"
        "Description" = "You found a vape pen on the ground. Do you want to use it? (Y/N)"
        "Effect"      = {
            # Wait for user to press a valid key
            $choices = @('Y', 'N')
            $choice = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown').Character.ToString().ToUpper()
            while (-not $choices.Contains($choice)) {
                $choice = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown').Character.ToString().ToUpper()
            }
            if ($choice -eq 'Y' ) {
                $experience = Get-Random -Minimum 1 -Maximum 10
                if ($experience -le 3) {
                    Write-Centered 'Uh oh!' -ForegroundColor DarkGreen
                    Start-Sleep -Seconds 2
                    Write-Centered 'What was in that thing?!'
                    Start-Sleep -Seconds 1
                    Tripout
                    Write-Centered 'You tripped out hard and lost a day!'
                    AdvanceGameDay -SkipPriceUpdate
                }
                else {
                    Start-Sleep -Milliseconds 500
                    Write-Centered 'Puff...'
                    Start-Sleep -Milliseconds 500
                    Write-Centered 'Puff...'
                    Start-Sleep -Seconds 2
                    $randomScore = Get-Random -Minimum 1 -Maximum 12
                    switch ($randomScore) {
                        { $_ -le 3 } {
                            Write-Centered ('Dude, bummer! Only {0}/10 - Harsh hit. Not exactly riding the good vibes, you know?' -f $randomScore)
                        }
                        { $_ -gt 3 -and $_ -le 6 } {
                            Write-Centered ('Hey cosmic traveler! {0}/10 - Decent hit. Average buzz, man.' -f $randomScore)
                        }
                        { $_ -gt 6 -and $_ -le 9 } {
                            Write-Centered ('Far out, dude! {0}/10 - Good hit. Nice buzz flowing through your soul.' -f $randomScore)
                        }
                        { $_ -gt 9 } {
                            Write-Centered ('Whoa, enlightenment achieved! {0}/10 - Amazing hit. Best vape ever, man!' -f $randomScore)
                        }
                        { $_ -gt 10 } {
                            Write-Host
                            Write-Centered ('You got so damn high, you actually GAINED A DAY!') -ForegroundColor Yellow
                            $script:GameDays++
                            Start-Sleep -Milliseconds 750
                            Write-Centered ('You now have {0} days to make as much cash as possible.' -f $script:GameDays) -ForegroundColor DarkGreen
                        }
                    }

                }
            }
            else {
                Write-Centered 'You decided not to use the vape pen, and instead sell it to some skid for $5.'
                $script:Player.Cash += 5
            }

            Start-Sleep -Seconds 2
        }
    },
    @{
        "Name"        = "Cargo Pants"
        "Description" = "Groovy, man! You stumbled upon these cosmic cargo pants, packed with pockets for all your trippy treasures!"
        "Effect"      = {
            Start-Sleep -Seconds 2
            Write-Host
            if ($script:Player.AddClothing('Cargo Pants')) {
                $extraPockets = 20
                $script:Player.AdjustPocketCount($extraPockets)
                Write-Centered ('Far out! You''ve now got {0} extra pockets! Carryin'' more of your magic stash just got easier.' -f $extraPockets) -ForegroundColor DarkGreen
            }
            else {
                Write-Centered 'You already have a pair of cosmic cargo pants. You decide to sell these for $20.'
                $script:Player.Cash += 20
            }
            Start-Sleep -Seconds 2
        }
    },
    @{
        "Name"        = "Hemp Backpack"
        "Description" = "Whoa, dude! Check out this Zen hemp backpack! It's like, totally eco-friendly and has space for all your good vibes and herbal remedies."
        "Effect"      = {
            Start-Sleep -Seconds 2
            Write-Host
            if ($script:Player.AddClothing('Hemp Backpack')) {
                $extraPockets = 50
                $script:Player.AdjustPocketCount($extraPockets)
                Write-Centered ('Far out! You''ve now got {0} extra pockets! Carryin'' more of your magic stash just got easier.' -f $extraPockets) -ForegroundColor DarkGreen
            }
            else {
                Write-Centered 'You already have a Zen hemp backpack. You decide to sell this one for $50.'
                $script:Player.Cash += 50
            }
            Start-Sleep -Seconds 2
        }
    },
    @{
        "Name"        = "Tie-dyed Poncho"
        "Description" = "Far-out find, man! You snagged a psychedelic tie-dyed hemp poncho. It's like wearing a kaleidoscope of good vibes!"
        "Effect"      = {
            Start-Sleep -Seconds 2
            Write-Host
            if ($script:Player.AddClothing('Hemp Poncho')) {
                $extraPockets = 10
                $script:Player.AdjustPocketCount($extraPockets)
                Write-Centered ('Trippy, right? This tie-dyed hemp poncho adds {0} extra pockets to your cosmic wardrobe. Carry on, peace traveler.' -f $extraPockets) -ForegroundColor DarkGreen
            }
            else {
                Write-Centered 'You already have a tie-dyed hemp poncho. You decide to sell this one for $10.'
                $script:Player.Cash += 10
            }
            Start-Sleep -Seconds 2
        }
    },
    @{
        "Name"        = "Fanny Pack"
        "Description" = "Radical, dude! You found a totally tubular fanny pack. It's compact, convenient, and has room for all your gnarly gear."
        "Effect"      = {
            Start-Sleep -Seconds 2
            Write-Host
            if ($script:Player.AddClothing('Fanny Pack')) {
                $extraPockets = 15
                $script:Player.AdjustPocketCount($extraPockets)
                Write-Centered ('Awesome! You''ve now got {0} extra pockets! Storing your stuff just got a whole lot easier.' -f $extraPockets) -ForegroundColor DarkGreen
            }
            else {
                Write-Centered 'You already have a fanny pack. You decide to sell this one for $15.'
                $script:Player.Cash += 15
            }
            Start-Sleep -Seconds 2
        }
    },
    @{
        "Name"        = "Fishing Vest"
        "Description" = "Whoa, you've discovered a far-out fishing vest! It's got a whole whack of pockets for all your ""fishing gear""."
        "Effect"      = {
            Start-Sleep -Seconds 2
            Write-Host
            if ($script:Player.AddClothing('Fishing Vest')) {
                $extraPockets = 75
                $script:Player.AdjustPocketCount($extraPockets)
                Write-Centered ('Incredible! You''ve now got {0} extra pockets! You''ll never run out of storage space.' -f $extraPockets) -ForegroundColor DarkGreen
                Write-Centered '(The loons, Norman! The loons!)' -ForegroundColor DarkGray
            }
            else {
                Write-Centered 'You already have a fishing vest. You decide to sell this one for $75.'
                $script:Player.Cash += 75
            }
            Start-Sleep -Seconds 2
        }
    },
    @{
        "Name"        = "Fence Fumble"
        "Description" = "Uh-oh! You tried to impressively hop a fence to escape a shady-looking character, but your acrobatics didn't quite go as planned."
        "Effect"      = {
            Start-Sleep -Seconds 2
            Write-Host
            if ($script:Player.get_PocketCount() -gt 0) {
                $lostPockets = Get-Random -Minimum 1 -Maximum 4
                $script:Player.AdjustPocketCount(-$lostPockets)
                Write-Centered ('Yikes! You lost {0} pockets in the fence fumble fiasco. Perhaps stealth is more your style.' -f $lostPockets) -ForegroundColor DarkRed
            }
            else {
                Write-Centered 'Phew! Luckily, you had no pockets to lose. Maybe next time stick to a less athletic escape plan, dumpy.'
            }
            Start-Sleep -Seconds 2
        }
    },
    @{
        "Name"        = "Lemonade Stand"
        "Description" = "Wandering through the gritty streets of Skid-Row, your eyes catch a peculiar sight - a little girl gleefully running a lemonade stand. But, as you approach, you realize this stand has a mysterious twist!"
        "Effect"      = {
            Start-Sleep -Seconds 3
            Write-Host
            $extraDrug = $script:GameDrugs | Get-Random
            # Pick 5 or 10 at random
            $extraDrug.Quantity = Get-Random -InputObject @(5, 10)

            $randomNumber = Get-Random -Minimum 1 -Maximum 101
            if ($script:Player.Cash -gt 2500 -and $randomNumber -le 20) {
                # 20% chance of getting mugged for 25-50% of your cash
                $muggedAmount = [Math]::Floor((Get-Random -Minimum ($script:Player.Cash * 0.25) -Maximum ($script:Player.Cash * 0.5)) / 10) * 10
                $script:Player.Cash -= $muggedAmount
                Write-Centered ('That''s no MF''ing kid!')
                Write-Centered ('That dwarf hustler at the Skid-Row Lemonade Stand just pulled a blade and mugged yo'' ass for {0} cash!' -f $muggedAmount) -ForegroundColor Red
            }
            else {
                Write-Centered ('Whoa! The enchanting little hustler at the Skid-Row Lemonade Stand just hooked you up with {0} pockets of {1}!' -f $extraDrug.Quantity, $extraDrug.Name) -ForegroundColor DarkGreen
                Write-Centered ('Your spirit is now a little more... unconventional!')
                $script:Player.AddDrugs($extraDrug)
            }
        }
    },
    @{
        "Name"        = "Pocket Portal"
        "Description" = "You stumble upon a mysterious portal while high. Curiosity gets the better of you, and you step through!"
        "Effect"      = {
            Write-Centered 'Whoa, man! This portal takes you to a pocket dimension of infinite possibilities!'
            Start-Sleep -Seconds 3
            Write-Host
            $choice = Get-Random -Minimum 1 -Maximum 5
            $pocketCost = 10
            switch ($choice) {
                1 {
                    $extraPockets = 75
                    $extraPocketsCost = $pocketCost * $extraPockets
                    Write-Centered ('You encounter a cosmic, drugged-out vendor selling magical pockets.')
                    Write-Centered ('Spend ${0} to get {1} extra pockets? (Y/N)' -f $extraPocketsCost, $extraPockets)
                    if ($script:Player.Cash -ge $extraPocketsCost) {
                        # Wait for user to press a valid key
                        $choices = @('Y', 'N')
                        $choice = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown').Character.ToString().ToUpper()
                        while (-not $choices.Contains($choice)) {
                            $choice = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown').Character.ToString().ToUpper()
                        }
                        if ($choice -eq 'Y') {
                            $script:Player.Cash -= $extraPocketsCost
                            $script:Player.AdjustPocketCount($extraPockets)
                            Write-Centered ('You made a wise investment and gained {0} extra pockets!' -f $extraPockets) -ForegroundColor DarkGreen
                        }
                        else {
                            Write-Centered 'You decide not to spend your cash, and the cosmic vendor fades away. No extra pockets for you.'
                        }
                    }
                    else {
                        Write-Centered ('You don''t have enough cash to buy the magical pockets. The cosmic vendor disappears in disappointment. No extra pockets for you.') -ForegroundColor Red
                    }
                }
                2 {
                    Write-Centered 'You meet a luded-out pocket guru who offers to enhance your inner pocket energy.'
                    Write-Centered 'Meditate for a chance to gain 10 extra pockets? (Y/N)'
                    # Wait for user to press a valid key
                    $choices = @('Y', 'N')
                    $choice = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown').Character.ToString().ToUpper()
                    while (-not $choices.Contains($choice)) {
                        $choice = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown').Character.ToString().ToUpper()
                    }
                    if ($choice -eq 'Y') {
                        Write-Centered 'Meditating... ' -NoNewline
                        Start-Sleep -Seconds 2
                        Write-Centered 'Ohhhmmmmmm...'
                        Start-Sleep -Seconds 3
                        Write-Host
                        $success = Get-Random -Minimum 0 -Maximum 2
                        if ($success -eq 1) {
                            $script:Player.AdjustPocketCount(10)
                            Write-Centered 'After a deep meditation session, you feel your inner pocket energy expand. You gained 10 extra pockets!' -ForegroundColor DarkGreen
                        }
                        else {
                            Write-Centered 'Your meditation doesn''t quite hit the mark, and you gain no extra pockets. Bummer, man.'
                        }
                    }
                    else {
                        Write-Centered 'You decide not to meditate, and the pocket guru drifts away into the cosmic unknown. No extra pockets for you.'
                    }
                }
                3 {
                    if ($script:Player.get_PocketCount() -lt 5) {
                        Write-Centered ('You see a DMT-induced alien shaman, but they''re uninterested in playing a game with someone who doesn''t even have 5 pockets. No extra pockets for you.') -ForegroundColor Red
                    }
                    else {
                        Write-Centered 'A mischievous DMT-induced alien shaman challenges you to a game. Win, and you gain 25 extra pockets. Lose, and you lose 5 pockets.'
                        Write-Centered 'Play the game? (Y/N)'
                        # Wait for user to press a valid key
                        $choices = @('Y', 'N')
                        $choice = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown').Character.ToString().ToUpper()
                        while (-not $choices.Contains($choice)) {
                            $choice = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown').Character.ToString().ToUpper()
                        }
                        if ($choice -eq 'Y') {
                            $win = Get-Random -Minimum 0 -Maximum 2
                            if ($win -eq 1) {
                                $cosmicGames = @(
                                    'Hopscotch',
                                    'Duck, Duck, Goose',
                                    'Simon Says',
                                    'Musical Chairs',
                                    'Hide and Seek',
                                    'Tic-Tac-Toe'
                                )

                                $cosmicGame = Get-Random -InputObject $cosmicGames
                                Write-Centered ('You outwit the alien shaman in a cosmic game of {0}.' -f $cosmicGame)
                                Start-Sleep -Seconds 2
                                $script:Player.AdjustPocketCount(25)
                                Write-Host
                                Write-Centered ('You gained 25 extra pockets!') -ForegroundColor DarkGreen
                            }
                            else {
                                Write-Centered 'The alien shaman proves to be a cunning opponent.'
                                Start-Sleep -Seconds 2
                                $script:Player.AdjustPocketCount(-5)
                                Write-Host
                                Write-Centered ('You lose 5 pockets in the game. Better luck next time.') -ForegroundColor Red
                            }
                        }
                        else {
                            Write-Centered 'You decide not to play the game, and the alien shaman disappears in a puff of interdimensional smoke. No extra pockets for you.'
                        }
                    }
                }
                4 {
                    Write-Centered 'You find a field of magical pocket flowers. Smelling one might grant you extra pockets.'
                    Write-Centered 'Smell a flower? (Y/N)'
                    # Wait for user to press a valid key
                    $choices = @('Y', 'N')
                    $choice = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown').Character.ToString().ToUpper()
                    while (-not $choices.Contains($choice)) {
                        $choice = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown').Character.ToString().ToUpper()
                    }
                    if ($choice -eq 'Y') {
                        # Generate a random number between 5 and 26, divide it by 5, round up to the nearest whole number, then multiply by 5 to get the number of pockets to gain
                        $pocketsToGain = [Math]::Ceiling((Get-Random -Minimum 5 -Maximum 26) / 5) * 5
                        Write-Centered 'The magical dank kush aroma of the pocket flower works its wonders.'
                        Start-Sleep -Seconds 2
                        Write-Host
                        $script:Player.AdjustPocketCount($pocketsToGain)
                        Write-Centered ('You gained {0} extra pockets!' -f $pocketsToGain) -ForegroundColor DarkGreen
                    }
                    else {
                        Write-Centered 'You decide not to risk it, and the field of pocket flowers fades away.'
                        Start-Sleep -Seconds 2
                        Write-Host
                        Write-Centered 'No extra pockets for you.' -ForegroundColor Red
                    }
                }
            }
        }
    },
    @{
        "Name"        = "Needle Nook"
        "Description" = 'You find yourself in a dimly lit alley, known to locals as the Needle Nook.'
        "Effect"      = {
            Write-Host
            Start-Sleep -Seconds 2
            $choice = Get-Random -Minimum 1 -Maximum 6

            switch ($choice) {
                1 {
                    Write-Centered 'A shady dealer offers you a mysterious drug cocktail. Want to try it? (Y/N)'
                    # Wait for user to press a valid key
                    $choices = @('Y', 'N')
                    $choice = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown').Character.ToString().ToUpper()
                    while (-not $choices.Contains($choice)) {
                        $choice = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown').Character.ToString().ToUpper()
                    }

                    Write-Host
                    Write-Centered 'Chug! Chug! Chug!'
                    Start-Sleep 2
                    Write-Host

                    if ($choice -eq 'Y') {
                        $randomDrugs = ($script:GameDrugs | Get-Random -Count 4).Name -join ', '
                        # replace the last ',' with "and"
                        $randomDrugs = $randomDrugs -replace ', ([^,]+)$', ' and $1'
                        $tripOutcome = Get-Random -Minimum 1 -Maximum 11
                        if ($tripOutcome -le 5) {
                            Write-Centered ('The cocktail of {0} hits you hard, and you trip out in a neon-lit dreamscape.' -f $randomDrugs)
                            Tripout
                            Write-Centered 'You lose a day as you navigate the surreal landscapes of your mind.' -ForegroundColor Red
                            AdvanceGameDay -SkipPriceUpdate
                        }
                        else {
                            Write-Centered ('The cocktail of {0} gives you an otherworldly experience.' -f $randomDrugs)
                            Start-Sleep -Seconds 2
                            $cashToAdd = Get-Random -Minimum 20 -Maximum 501
                            Write-Centered ('You find some extra cash in your pocket (after you barf and come down)... ${0}!' -f $cashToAdd) -ForegroundColor DarkGreen
                            $script:Player.Cash += $cashToAdd
                        }
                    }
                    else {
                        Write-Centered 'You decide to pass on the shady dealer''s offer, and they disappear into the shadows. No risk, no reward.'
                    }
                }
                2 {
                    Write-Centered 'A grizzled junkie challenges you to a game of street smarts.'
                    Write-Centered 'Accept the challenge? (Y/N)'
                    # Wait for user to press a valid key
                    $choices = @('Y', 'N')
                    $choice = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown').Character.ToString().ToUpper()
                    while (-not $choices.Contains($choice)) {
                        $choice = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown').Character.ToString().ToUpper()
                    }

                    Write-Host

                    if ($choice -eq 'Y') {
                        Write-Centered 'You and the junkie face off in a battle of wits.'
                        Start-Sleep 2
                        Write-Host
                        $triviaQuestionsAnswers = @(
                            @{
                                "Question" = "What's the global party favour that's greener than the Hulk and chills everyone out?"
                                "Answer"   = "Cannabis (marijuana)"
                            },
                            @{
                                "Question" = "Which drug gets you zooming like The Flash and is known as the life of the party?"
                                "Answer"   = "Amphetamines"
                            },
                            @{
                                "Question" = "What's the name for the mood-killer that turns the party into a snoozefest, slowing everyone down?"
                                "Answer"   = "Barbiturates"
                            },
                            @{
                                "Question" = "What's the heavy hitter responsible for more dropouts than algebra class?"
                                "Answer"   = "Fentanyl"
                            },
                            @{
                                "Question" = "What do you call catching clouds for a mind-altering high in the vape nation?"
                                "Answer"   = "Inhalant abuse"
                            },
                            @{
                                "Question" = "Which drug, when injected, can turn your night into a speedball symphony when mixed with the right partner?"
                                "Answer"   = "Cocaine"
                            },
                            @{
                                "Question" = "What's the street name for the brain trip derived from a Mexican fungus that'll have you talking to cacti?"
                                "Answer"   = "Psilocybin or 'magic mushrooms'"
                            },
                            @{
                                "Question" = "What's the fancy term for playing chemical roulette with multiple substances, cranking up the risk for epic fails?"
                                "Answer"   = "Polydrug use or poly-substance use"
                            },
                            @{
                                "Question" = "Snort it, shoot it, and ride the rollercoaster from ecstasy to epic fail. What's the name of this wild ride?"
                                "Answer"   = "Cocaine"
                            },
                            @{
                                "Question" = "What's the street slang for the psychedelic joyride fuelled by morning glory seeds that'll have you liberating your mind?"
                                "Answer"   = "LSA or 'liberation'"
                            },
                            @{
                                "Question" = "What's the official term for using drugs as a therapist to kick stress, anxiety, and mental drama to the curb?"
                                "Answer"   = "Substance use disorder or addiction"
                            },
                            @{
                                "Question" = "What's the name of the stimulant straight outta Hollywood that'll have you buzzing like a hummingbird?"
                                "Answer"   = "Khat"
                            },
                            @{
                                "Question" = "What's the street lingo for the trippy journey with the yew tree bark that'll make you see colors even Tim Burton hasn't dreamt of?"
                                "Answer"   = "Amanita muscaria"
                            },
                            @{
                                "Question" = "What do you call the backstage pass to superhuman abilities, laser focus, and alertness?"
                                "Answer"   = "Performance-enhancing drugs"
                            },
                            @{
                                "Question" = "What's the white powder powerhouse derived from the coca plant that'll turn your night into a blockbuster?"
                                "Answer"   = "Cocaine"
                            },
                            @{
                                "Question" = "What's the remedy for a sleepless night that'll have you counting sheep like you're on a psychedelic farm?"
                                "Answer"   = "Sleeping pills"
                            },
                            @{
                                "Question" = "What's the street term for the cactus-powered psychedelic voyage that'll make you feel one with the desert?"
                                "Answer"   = "Peyote"
                            }
                        )

                        # Display 5 random questions and answers, with a 3 second pause between each.
                        $triviaQuestionsAnswers | Get-Random -Count 5 | ForEach-Object {
                            Write-Centered $_.Question -ForegroundColor DarkCyan
                            Start-Sleep -Milliseconds (Get-Random -Minimum 1000 -Maximum 3001)
                            if ((Get-Random -Minimum 0 -Maximum 2) -eq 1) {
                                Write-Centered $_.Answer -ForegroundColor DarkMagenta
                                Start-Sleep -Milliseconds 750
                                Write-Centered 'Right!' -ForegroundColor DarkGreen
                            }
                            else {
                                $randomAnswers = @(
                                    'Noodle.',
                                    'Dinosaur.',
                                    'Yo'' momma!',
                                    'The answer is 42.',
                                    'Cows go moo.'
                                )
                                Write-Centered ($randomAnswers | Get-Random) -ForegroundColor DarkYellow
                                Start-Sleep -Milliseconds 750
                                $youWrongStatements = @(
                                    'Wrong!',
                                    'Nope!',
                                    'Not even close!',
                                    'Dummy!',
                                    'Are you high?',
                                    'Incorrect, schmuck!',
                                    'Lay off the smack, Jack.'
                                )
                                Write-Centered ($youWrongStatements | Get-Random) -ForegroundColor DarkRed
                            }
                            Start-Sleep -Seconds 2
                            Write-Host
                        }

                        $win = Get-Random -Minimum 0 -Maximum 2
                        $amount = Get-Random -Minimum 10 -Maximum 301
                        if ($win -eq 1) {
                            Write-Centered ('You outwit the junkie in a quick game of street trivia. He rewards you with ${0} cash.' -f $amount) -ForegroundColor DarkGreen
                            $script:Player.Cash += $amount
                        }
                        else {
                            Write-Centered ('The junkie proves to be a street-smart master, and you lose ${0} cash trying to impress him.' -f $amount) -ForegroundColor Red
                            $script:Player.Cash -= $amount
                        }
                    }
                    else {
                        Write-Centered 'You decide not to engage in a street smarts competition, and the junkie nods understandingly, returning to his own world.'
                    }
                }
                3 {
                    Write-Centered 'You come across a hidden stash of drugs. Do you want to take them? (Y/N)'
                    # Wait for user to press a valid key
                    $choices = @('Y', 'N')
                    $choice = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown').Character.ToString().ToUpper()
                    while (-not $choices.Contains($choice)) {
                        $choice = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown').Character.ToString().ToUpper()
                    }

                    Write-Host
                    Write-Centered 'Yoink!'
                    Start-Sleep 2
                    Write-Host

                    if ($choice -eq 'Y') {
                        $randomDrug = $script:GameDrugs | Get-Random
                        $randomDrug.Quantity = Get-Random -Minimum 5 -Maximum 16
                        $mobBeatChance = Get-Random -Minimum 1 -Maximum 101
                        if ($mobBeatChance -le 30) {
                            Write-Centered ('You find a stash of {0}, but before you can celebrate {1} jumps you!' -f $randomDrug.Name, (Get-Random -InputObject $script:MobBossNames))
                            Start-Sleep 2
                            Write-Centered ('They beat you up, take back their drugs, and you spend a day recovering in the hospital.') -ForegroundColor Red
                            AdvanceGameDay -SkipPriceUpdate
                        }
                        else {
                            $script:Player.AddDrugs($randomDrug)
                            Write-Centered ('You find a {0}-pocket stash of {1}, adding it to your inventory. The alley holds its secrets.' -f $randomDrug.Quantity, $randomDrug.Name) -ForegroundColor DarkGreen
                        }
                    }
                    else {
                        Write-Centered 'You decide not to take the drugs, leaving the hidden stash undisturbed.'
                    }
                }
                4 {
                    Write-Centered 'A graffiti-covered door catches your eye. Do you want to enter? (Y/N)'
                    # Wait for user to press a valid key
                    $choices = @('Y', 'N')
                    $choice = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown').Character.ToString().ToUpper()
                    while (-not $choices.Contains($choice)) {
                        $choice = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown').Character.ToString().ToUpper()
                    }

                    Start-Sleep 2
                    Write-Host

                    if ($choice -eq 'Y') {
                        Write-Centered 'You cautiously enter the door and discover a hidden underground club. The beats are pumping, and the atmosphere is wild.'
                        Start-Sleep -Seconds 2
                        $randomCash = [math]::Round((Get-Random -Minimum 30 -Maximum 201) / 10) * 10
                        $script:Player.Cash += $randomCash
                        Write-Centered ('You spend the night dancing and end up finding ${0} cash on the dance floor.' -f $randomCash) -ForegroundColor DarkGreen
                    }
                    else {
                        Write-Centered 'You decide not to enter the mysterious door ''cause you''ve got shit to get done.'
                    }
                }
                5 {
                    Write-Centered 'A disheveled artist offers to sketch your portrait in exchange for some cash. Interested? (Y/N)'
                    # Wait for user to press a valid key
                    $choices = @('Y', 'N')
                    $choice = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown').Character.ToString().ToUpper()
                    while (-not $choices.Contains($choice)) {
                        $choice = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown').Character.ToString().ToUpper()
                    }

                    Start-Sleep 2
                    Write-Host

                    if ($choice -eq 'Y') {
                        $portraitCost = [math]::Round((Get-Random -Minimum 5 -Maximum 16) / 5) * 5
                        $script:Player.Cash -= $portraitCost
                        Write-Centered ('The artist captures your essence in a gritty portrait. You pay him ${0} for his unique creation.' -f $portraitCost)

                        $hashQuantity = Get-Random -Minimum 1 -Maximum 6
                        if ($script:Player.get_FreePocketCount() -ge $hashQuantity) {
                            Write-Host
                            Write-Centered ('As a bonus, the artist hands you {0} pockets of Hash.' -f $hashQuantity) -ForegroundColor DarkGreen
                            $freeHash = [Drug]::new('Hash')
                            $freeHash.Quantity = $hashQuantity
                            $script:Player.AddDrugs($freeHash)
                        }
                        else {
                            Write-Centered 'The artist wanted to give you some Hash, but you don''t have enough free pockets. What a bummer!'
                        }
                    }
                    else {
                        Write-Centered 'You decline the artist''s offer, leaving him to his creative endeavors in the alley.'
                    }
                }
            }
        }
    },
    @{
        "Name"        = "Cocaine Conundrum"
        "Description" = "Oh dear, you find yourself cornered by a self-proclaimed cocaine connoisseur. This enthusiastic individual insists on sharing their 'expertise' and believes they are the absolute BEST at doing cocaine."
        "Effect"      = {
            Start-Sleep -Seconds 2
            Write-Host
            Write-Centered 'You try to escape, but the self-proclaimed cocaine expert has you trapped in a pointless conversation about their "skills."'
            Start-Sleep -Seconds 3

            $awkwardnessLevel = Get-Random -Minimum 1 -Maximum 4

            switch ($awkwardnessLevel) {
                1 {
                    Write-Centered 'The cocaine aficionado insists their nose is the most finely tuned instrument for the job.'
                }
                2 {
                    Write-Centered 'They start demonstrating their "perfect" snorting technique, much to your dismay.'
                }
                3 {
                    Write-Centered 'In an attempt to impress you, they share a bizarre list of "achievements" related to their cocaine adventures.'
                }
                default {
                    Write-Centered 'You can''t help but wonder how you ended up in this peculiar conversation about someone being the BEST at doing cocaine.'
                }
            }

            Start-Sleep -Seconds 2
            Write-Host
            Write-Host 'How would you like to react?'
            Write-Host '1. Politely nod and pretend to be impressed.'
            Write-Host '2. Burst into laughter and call their bluff.'
            Write-Host '3. Attempt to challenge them with your own made-up cocaine "skills."'

            $playerChoice = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown').Character

            Write-Host
            switch ($playerChoice) {
                1 {
                    Write-Centered 'You decide to play along, nodding as if genuinely impressed. The cocaine fiend beams with pride, convinced they''ve found an admirer.'
                }
                2 {
                    Write-Centered 'Unable to contain yourself, you burst into laughter. The cocaine expert looks offended, muttering something about "non-believers" before storming off.'
                }
                3 {
                    Write-Centered 'In a bold move, you attempt to challenge their skills with your own absurd and entirely made-up cocaine "techniques"...'
                    Start-Sleep -Seconds 2
                    $cokeTechniques = @(
                        'You decided to try the latest trend and indulged in a refreshing Cocaine Snow Cone.  That''s some GOOD SLUSHIE!',
                        'In a desperate attempt to boost your energy levels, you resorted to the unconventional Cocaine Coffee Enema, which left you feeling both invigorated and mortified.',
                        'Three words... Cocaine Chocolate Fondue.',
                        'You draw a steaming bubble bath and, with a wicked grin, added a generous dose of Cocaine Infused Bubble Bath, you hop in an scrub until your LIT!',
                        'You shove copious amounts of cocaine where the sun don''t shine, and start dancing around while singing "White Lines" by Grandmaster Flash and Melle Mel.'
                    )

                    $cokeTechnique = Get-Random -InputObject $cokeTechniques
                    Write-Host
                    Write-Centered $cokeTechnique

                    Start-Sleep -Seconds 2
                    Write-Host
                    Write-Centered 'The fiend is left bewildered, questioning your sanity, but now we all know'
                    Write-Centered 'YOU''RE THE BEST AT DOING COCAINE!'
                }
                default {
                    Write-Centered 'You stand there, paralyzed by the absurdity of the situation. The cocaine fiend continues their monologue, oblivious to your internal crisis.'
                }
            }

            Start-Sleep -Seconds 3
            Write-Host
            Write-Centered 'You finally manage to escape the cocaine connoisseur, but not before losing a day to their ramblings.' -ForegroundColor Red
            $cocaine = [Drug]::new('Cocaine')
            $cocaine.Quantity = Get-Random -Minimum 2 -Maximum 6

            # If the user has enough free pockets, add the cocaine to their inventory
            if ($script:Player.get_FreePocketCount() -ge $cocaine.Quantity) {
                Write-Host
                Write-Centered 'But at least they gave you some cocaine to make up for it!'
                $script:Player.AddDrugs($cocaine)
                Write-Centered ('You gained {0} pockets of Cocaine.' -f $cocaine.Quantity) -ForegroundColor DarkGreen
            }

            Write-Host
            AdvanceGameDay -SkipPriceUpdate
        }
    },
    @{
        "Name"        = "Stanky Slingshot"
        "Description" = "Eww! In the grimy depths under the sink of a public washroom, you stumble upon a slingshot taped to the bottom. It's covered in gunk, but it might come in handy."
        "Effect"      = {
            Start-Sleep -Seconds 2
            Write-Host

            # Gather slingshot info
            $slingshotInfo = $script:GunInfo | Where-Object { $_.Name -eq 'Slingshot' }

            # Check if player already has a slingshot
            $hasSlingshot = $script:Player.get_Guns() | Where-Object { $_.Name -eq 'Slingshot' }

            if (!$hasSlingshot) {
                Write-Centered 'You bravely retrieve the slingshot, wiping off the filth as best as you can. It is now added to your inventory.' -ForegroundColor Green
                $script:Player.AddGun($slingshotInfo) | Out-Null
            }
            else {
                $sellPrice = [math]::Round($slingshotInfo.Price / 2)
                Write-Centered ('You already have a slingshot. You decide to sell it to a hopped-up junkie for ${0}, making a quick profit.' -f $sellPrice) -ForegroundColor Yellow
                $script:Player.Cash += $sellPrice
            }
            Start-Sleep -Seconds 2
        }
    }
)

# Define game guns
$script:GunInfo = @(
    @{
        Name          = "Slingshot"
        Type          = "Projectile weapon"
        StoppingPower = 1
        Price         = 200
        Description   = "A projectile weapon with minimal stopping power, often used for hunting small game or as a recreational activity."
        History       = "Slingshots have been used for thousands of years, with evidence of their use dating back to ancient civilizations such as the Egyptians, Greeks, and Romans."
        Onomatopoeia  = "Thwack!"
    },
    @{
        Name          = "Single-shot shotgun"
        Type          = "Shotgun"
        StoppingPower = 2
        Price         = 600
        Description   = "A traditional shotgun with only one barrel, which has limited stopping power compared to a pump or semi-automatic shotgun."
        History       = "The shotgun has its origins in the early 18th century, with the invention of the smoothbore, flintlock firearm. Over time, it has evolved into the modern shotguns we know today."
        Onomatopoeia  = "Boom!"
    },
    @{
        Name          = ".22 caliber rimfire pistol"
        Type          = "Pistol"
        StoppingPower = 3
        Price         = 1000
        Description   = "A small-caliber pistol with limited stopping power, often used for target practice and plinking."
        History       = "The .22 caliber rimfire cartridge was introduced in 1857 by the British firm, Royal Small Arms Factory. It has since become the most popular caliber for firearms worldwide."
        Onomatopoeia  = "Pew!"
    },
    @{
        Name          = "Derringer"
        Type          = "Pistol"
        StoppingPower = 4
        Price         = 1400
        Description   = "A small, pocket-sized pistol with minimal stopping power, typically chambered in .410 gauge or .22 caliber rimfire."
        History       = "The Derringer was invented by Henry Derringer in the early 19th century and gained popularity as a concealable weapon for personal protection."
        Onomatopoeia  = "Bang!"
    },
    @{
        Name          = "Glock 17"
        Type          = "Pistol"
        StoppingPower = 5
        Price         = 1800
        Description   = "A semi-automatic pistol with moderate stopping power."
        History       = "The Glock 17 was introduced in 1982 by Austrian gunmaker Gaston Glock. It has since become one of the most popular handguns worldwide, known for its reliability and ease of use."
        Onomatopoeia  = "Bam!"
    },
    @{
        Name          = "Desert Eagle"
        Type          = "Pistol"
        StoppingPower = 6
        Price         = 2200
        Description   = "A large-frame semi-automatic pistol with significant stopping power."
        History       = "The Desert Eagle was designed by Magnum Research in the late 1970s and early 1980s. It is known for its powerful .50 AE caliber and unique appearance."
        Onomatopoeia  = "Boom!"
    },
    @{
        Name          = "M1911"
        Type          = "Pistol"
        StoppingPower = 7
        Price         = 2600
        Description   = "A semi-automatic pistol with moderate to high stopping power."
        History       = "The M1911, also known as the Model 1911 or Colt 1911, is a single-action, semi-automatic pistol chambered in .45 ACP. It was designed by John Browning and adopted by the United States Armed Forces in 1911."
        Onomatopoeia  = "Bang!"
    },
    @{
        Name          = "Uzi"
        Type          = "Submachine gun"
        StoppingPower = 8
        Price         = 3000
        Description   = "A submachine gun with moderate stopping power."
        History       = "The Uzi was designed by Major Uziel Gal of the Israel Defense Forces in the 1940s and 1950s. It became widely known for its use by Israeli military and police forces, as well as various other militaries and law enforcement agencies around the world."
        Onomatopoeia  = "Rat-a-tat-tat!"
    },
    @{
        Name          = "MAC-10"
        Type          = "Submachine gun"
        StoppingPower = 9
        Price         = 3400
        Description   = "A submachine gun with moderate stopping power."
        History       = "The MAC-10, or Machine Pistol, was designed by George Kolay in the 1960s as a compact and concealable firearm. It gained notoriety in the 1970s and 1980s for its use in criminal activities, earning it the nickname `"Crime-tech`"."
        Onomatopoeia  = "Rat-a-tat-tat!"
    },
    @{
        Name          = "Colt Python"
        Type          = "Revolver"
        StoppingPower = 7
        Price         = 2700
        Description   = "A revolver with high stopping power."
        History       = "The Colt Python is a large-frame, double-action revolver produced by the Colt's Manufacturing Company. It was introduced in 1955 and is known for its power, accuracy, and reliability."
        Onomatopoeia  = "Bang!"
    },
    @{
        Name          = "Tommy Gun"
        Type          = "Submachine gun"
        StoppingPower = 10
        Price         = 4200
        Description   = "A classic submachine gun with moderate to high stopping power, known for its high rate of fire and ease of use."
        History       = "The Thompson submachine gun, or Tommy Gun, was designed by John T. Thompson in 1918. It was widely used by law enforcement and military forces in the 1920s and 1930s, and has since become an iconic symbol of the Prohibition era and the gangster culture of that time."
        Onomatopoeia  = "Rat-a-tat-tat!"
    },
    @{
        Name          = "Barrett M82"
        Type          = "Sniper rifle"
        StoppingPower = 10
        Price         = 4600
        Description   = "A powerful .50 caliber sniper rifle, used by drug lords for its long-range accuracy and destructive power."
        History       = "The Barrett M82, also known as the M82A1, is a .50 caliber anti-materiel rifle developed by the American company Barrett Firearms. It was introduced in the 1980s and has since become one of the most recognized sniper rifles in the world."
        Onomatopoeia  = "Crack!"
    },
    @{
        Name          = "AK-47"
        Type          = "Assault rifle"
        StoppingPower = 10
        Price         = 5000
        Description   = "An assault rifle with high stopping power."
        History       = "The AK-47, also known as the Kalashnikov or Avtomat Kalashnikova, is a gas-operated, 7.62×39mm assault rifle developed in the Soviet Union by Mikhail Kalashnikov. It was introduced in 1947 and has since become one of the most widely used and recognizable firearms in the world."
        Onomatopoeia  = "Blam! Blam! Blam! Blam! Blam! Blam..... BLAM!"
    },
    @{
        Name          = "AR-15"
        Type          = "Semi-automatic rifle"
        StoppingPower = 10
        Price         = 5000
        Description   = "A semi-automatic rifle with moderate to high stopping power."
        History       = "The AR-15, developed by American firearms designer Eugene Stoner, was first produced in the early 1960s. It was originally designed as a lightweight, adaptable rifle for various purposes, including sport shooting, hunting, and military use. Over time, it has become one of the most popular semi-automatic rifles in the United States."
        Onomatopoeia  = "Bang! Bang! Bang! Bang! Bang! Bang! Bang! Bang! Bang!"
    },
    @{
        Name          = "FN FAL"
        Type          = "Battle rifle"
        StoppingPower = 10
        Price         = 5000
        Description   = "A battle rifle with high stopping power."
        History       = "The FN FAL, or Fabrique Nationale Fusil Automatique Leger, is a battle rifle developed by the Belgian firearms manufacturer Fabrique Nationale de Herstal. It was introduced in the late 1940s and was widely used by various militaries around the world during the Cold War era."
        Onomatopoeia  = "Ka-chunk! Bang!"
    }
)

# Define Mob Boss Names
$script:MobBossNames = @(
    'Angela "Angel Dust" Amato',
    'Benny "LSD Baron" Barzini',
    'Frankie "Crystal Clear" Corleone',
    'Janny "Two-Titz"',
    'Jimmy "Hash Hustler" Capone',
    'Louie "Molly Maestro" Lombardi',
    'Maria "The Mixer" Martino',
    'Mikey "Blow Boss" Moretti',
    'Nick "Narcotics Napper" Napoli',
    'Rocco "Coke Cowboy" Colombo',
    'Sal "Opium Queenpin" Santoro',
    'Tony "White Lines" Bianchi',
    'Vinny "The Chemist" Marino'
)
#############################################
#endregion Define Script-Wide Lists and Tables
###############################################

###########################
#region Function Definitions
#############################
# Function that will Exit if console size is not at least 80x25.
function CheckConsoleSize {
    if ($Host.UI.RawUI.WindowSize.Width -lt 120 -or $Host.UI.RawUI.WindowSize.Height -lt 30) {
        Write-Host 'Please resize your console window to at least 120 x 30 and run the script again.' -ForegroundColor Red
        Write-Host ('Current size: {0}x{1}' -f $Host.UI.RawUI.WindowSize.Width, $Host.UI.RawUI.WindowSize.Height) -ForegroundColor Red
        Exit 666
    }
}

# Function to move up N lines to overwrite, optionally clearing them.
function OverWriteLastLines {
    param (
        [Parameter(Position = 1)]
        [int32]$Count = 1,
        [switch]$WithClear
    )

    $CurrentLine = $Host.UI.RawUI.CursorPosition.Y
    $ConsoleWidth = $Host.UI.RawUI.BufferSize.Width

    if ($WithClear) {
        for ($i = 1; $i -le $Count; $i++) {
            [Console]::SetCursorPosition(0, ($CurrentLine - $i))
            [Console]::Write("{0,-$ConsoleWidth}" -f ' ')
        }

    }

    [Console]::SetCursorPosition(0, ($CurrentLine - $Count))
}

# Displays provided text in center of console.
function Write-Centered {
    param (
        [Parameter(Mandatory)]
        [string]$Text,
        [switch]$NoNewline,
        [AllowNull()]
        $BackgroundColor = $null,
        [AllowNull()]
        $ForegroundColor = $null
    )

    # Create hashtable of parameters, so we can splat them to Write-Host.
    $params = @{
        NoNewline       = $NoNewline
        BackgroundColor = $BackgroundColor
        ForegroundColor = $ForegroundColor
    }

    # Create a new hashtable excluding entries with null values.
    $filteredParams = @{}
    foreach ($key in $params.Keys) {
        $value = $params[$key]
        if ($null -ne $value) {
            $filteredParams[$key] = $value
        }
    }

    # Get console width
    $consoleWidth = $Host.UI.RawUI.WindowSize.Width

    # If the text is longer than the console width -2, split the Text into an array of multiple lines...
    # Create a new list to store the lines of text
    $textList = New-Object System.Collections.Generic.List[string]

    # Check if the length of the text is greater than the console width minus 2
    if ($Text.Length -gt ($consoleWidth - 2)) {
        # Store the length of the text and the maximum line length
        $textLength = $Text.Length
        $lineLength = $consoleWidth - 2

        # Loop while there is still text left
        while ($textLength -gt 0) {
            # Calculate the end index for the substring
            $endIndex = [math]::Min($lineLength, $textLength)
            # Extract the substring from the text
            $stringToAdd = $Text.Substring(0, $endIndex)

            # Check if the string contains a space and if the text length is not equal to the end index
            $shouldTruncate = $stringToAdd.Contains(' ') -and ($textLength -ne $endIndex)
            if ($shouldTruncate) {
                # Find the last space in the string
                $lastSpace = $stringToAdd.LastIndexOf(' ')
                # Truncate the string at the last space
                $stringToAdd = $stringToAdd.Substring(0, $lastSpace + 1)
            }

            # Add the string to the list and trim it
            $textList.Add($stringToAdd.Trim())
            # Remove the string from the text and trim it
            $Text = $Text.Substring($stringToAdd.Length).Trim()
            # Update the text length
            $textLength = $Text.Length
        }
    }
    else {
        # If the text is not longer than the console width minus 2, add it to the list as is
        $textList.Add($Text)
    }

    # Iterate through each line in the array
    foreach ($line in $textList) {
        # Calculate padding to center text
        $padding = [math]::Max(0, [math]::Floor((($consoleWidth - $line.Length) / 2)))

        # Calculate right padding
        $rightPadding = $consoleWidth - $line.Length - $padding

        # If right padding is negative, set it to zero
        if ($rightPadding -lt 0) {
            $rightPadding = 0
        }

        # Write text to console with padding, using the filtered parameters.
        Write-Host ((' ' * $padding) + $line + (' ' * $rightPadding)) @filteredParams
    }
}

# Function to write large block letters to the console, based on provided text.
function Write-BlockLetters {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Text,
        [ValidateSet("Left", "Center", "Right")]
        [string]$Align = "Left",
        [ConsoleColor]$ForegroundColor = $Host.UI.RawUI.ForegroundColor,
        [ConsoleColor]$BackgroundColor = $Host.UI.RawUI.BackgroundColor,
        [int]$VerticalPadding = 0
    )

    # Define the mapping of characters to their block letter representations
    $blockLetters = @{
        'A'  = @(
            "  #  ",
            " # # ",
            "#####",
            "#   #",
            "#   #"
        )
        'B'  = @(
            "#### ",
            "#   #",
            "#### ",
            "#   #",
            "#### "
        )
        'C'  = @(
            " ### ",
            "#   #",
            "#    ",
            "#   #",
            " ### "
        )
        'D'  = @(
            "#### ",
            "#   #",
            "#   #",
            "#   #",
            "#### "
        )
        'E'  = @(
            "#####",
            "#    ",
            "#### ",
            "#    ",
            "#####"
        )
        'F'  = @(
            "#####",
            "#    ",
            "#### ",
            "#    ",
            "#    "
        )
        'G'  = @(
            " ### ",
            "#    ",
            "#  ##",
            "#   #",
            " ### "
        )
        'H'  = @(
            "#   #",
            "#   #",
            "#####",
            "#   #",
            "#   #"
        )
        'I'  = @(
            "#####",
            "  #  ",
            "  #  ",
            "  #  ",
            "#####"
        )
        'J'  = @(
            "#####",
            "   # ",
            "   # ",
            "#  # ",
            " ##  "
        )
        'K'  = @(
            "#   #",
            "#  # ",
            "###  ",
            "#  # ",
            "#   #"
        )
        'L'  = @(
            "#    ",
            "#    ",
            "#    ",
            "#    ",
            "#####"
        )
        'M'  = @(
            "#   #",
            "## ##",
            "# # #",
            "#   #",
            "#   #"
        )
        'N'  = @(
            "#   #",
            "##  #",
            "# # #",
            "#  ##",
            "#   #"
        )
        'O'  = @(
            " ### ",
            "#   #",
            "#   #",
            "#   #",
            " ### "
        )
        'P'  = @(
            "#### ",
            "#   #",
            "#### ",
            "#    ",
            "#    "
        )
        'Q'  = @(
            " ### ",
            "#   #",
            "# # #",
            "#  # ",
            " ## #"
        )
        'R'  = @(
            "#### ",
            "#   #",
            "#### ",
            "# #  ",
            "#  ##"
        )
        'S'  = @(
            " ####",
            "#    ",
            " ### ",
            "    #",
            "#### "
        )
        'T'  = @(
            "#####",
            "  #  ",
            "  #  ",
            "  #  ",
            "  #  "
        )
        'U'  = @(
            "#   #",
            "#   #",
            "#   #",
            "#   #",
            " ### "
        )
        'V'  = @(
            "#   #",
            "#   #",
            "#   #",
            " # # ",
            "  #  "
        )
        'W'  = @(
            "#   #",
            "#   #",
            "# # #",
            "## ##",
            "#   #"
        )
        'X'  = @(
            "#   #",
            " # # ",
            "  #  ",
            " # # ",
            "#   #"
        )
        'Y'  = @(
            "#   #",
            " # # ",
            "  #  ",
            "  #  ",
            "  #  "
        )
        'Z'  = @(
            "#####",
            "   # ",
            "  #  ",
            " #   ",
            "#####"
        )
        '0'  = @(
            " ### ",
            "#   #",
            "# # #",
            "#   #",
            " ### "
        )
        '1'  = @(
            " # ",
            "## ",
            " # ",
            " # ",
            "###"
        )
        '2'  = @(
            " ### ",
            "#   #",
            "  ## ",
            " #   ",
            "#####"
        )
        '3'  = @(
            " ### ",
            "#   #",
            "  ## ",
            "#   #",
            " ### "
        )
        '4'  = @(
            "#  # ",
            "#  # ",
            "#####",
            "   # ",
            "   # "
        )
        '5'  = @(
            "#####",
            "#    ",
            "#### ",
            "    #",
            "#### "
        )
        '6'  = @(
            " ### ",
            "#    ",
            "#### ",
            "#   #",
            " ### "
        )
        '7'  = @(
            "#####",
            "   # ",
            "  #  ",
            " #   ",
            "#    "
        )
        '8'  = @(
            " ### ",
            "#   #",
            " ### ",
            "#   #",
            " ### "
        )
        '9'  = @(
            " ### ",
            "#   #",
            " ####",
            "    #",
            " ### "
        )
        '.'  = @(
            "   ",
            "   ",
            "   ",
            "   ",
            " # "
        )
        '?'  = @(
            " ### ",
            "#   #",
            "   # ",
            "     ",
            "  #  "
        )
        '!'  = @(
            "##",
            "##",
            "##",
            "  ",
            "##"
        )
        '$'  = @(
            " ### ",
            "# #  ",
            " ### ",
            "  # #",
            " ### "
        )
        '-'  = @(
            "    ",
            "    ",
            "####",
            "    ",
            "    "
        )
        '+'  = @(
            "   ",
            " # ",
            "###",
            " # ",
            "   "
        )
        '='  = @(
            "    ",
            "####",
            "    ",
            "####",
            "    "
        )
        '_'  = @(
            "    ",
            "    ",
            "    ",
            "    ",
            "####"
        )
        ' '  = @(
            "  ",
            "  ",
            "  ",
            "  ",
            "  "
        )
        '<'  = @(
            "  #",
            " # ",
            "#  ",
            " # ",
            "  #"
        )
        '>'  = @(
            "#  ",
            " # ",
            "  #",
            " # ",
            "#  "
        )
        '@'  = @(
            " ### ",
            "#   #",
            "# ###",
            "# # #",
            "# ###"
        )
        '#'  = @(
            " # # ",
            "#####",
            " # # ",
            "#####",
            " # # "
        )
        '%'  = @(
            "#   #",
            "   # ",
            "  #  ",
            " #   ",
            "#   #"
        )
        '^'  = @(
            " # ",
            "# #",
            "   ",
            "   ",
            "   "
        )
        '&'  = @(
            " ##  ",
            "#  # ",
            " ##  ",
            "#  # ",
            " ## #"
        )
        '*'  = @(
            "  #  ",
            "# # #",
            " ### ",
            "# # #",
            "  #  "
        )
        '('  = @(
            " #",
            "# ",
            "# ",
            "# ",
            " #"
        )
        ')'  = @(
            "# ",
            " #",
            " #",
            " #",
            "# "
        )
        ':'  = @(
            " ",
            "#",
            " ",
            "#",
            " "
        )
        ';'  = @(
            "  ",
            " #",
            "  ",
            " #",
            "# "
        )
        ','  = @(
            "  ",
            "  ",
            "  ",
            " #",
            "# "
        )
        '''' = @(
            " #",
            "# ",
            "  ",
            "  ",
            "  "
        )
        '"'  = @(
            " # # ",
            " # # ",
            "     ",
            "     ",
            "     "
        )
    }

    # Convert the input text to block letters and create an array of lines containing the block letters
    $TextUpper = $Text.ToUpper()
    $lines = for ($i = 0; $i -lt 5; $i++) {
        $line = foreach ($char in [char[]]$TextUpper) {
            $char = $char.ToString()
            if ($blockLetters.ContainsKey($char)) {
                $blockLetters[$char][$i] + " "
            }
            else {
                $blockLetters['?'][$i] + " "
            }
        }
        # Join the line array into a string and trim the last character
        $joinedLine = $line -join ""
        $joinedLine.Substring(0, $joinedLine.Length - 1)
    }

    # Get width of the longest line (as integer)
    $longestLine = ($lines | Measure-Object -Property Length -Maximum).Maximum

    # Add blank vertical padding lines to the top and bottom $lines array that are as wide as the longest line.
    for ($i = 0; $i -lt $VerticalPadding; $i++) {
        $lines = @(" " * $longestLine) + $lines + @(" " * $longestLine)
    }

    # Get the console width
    $consoleWidth = $Host.UI.RawUI.WindowSize.Width

    # Calculate the padding based on the chosen alignment and console width
    switch ($Align) {
        "Left" {
            $leftPadding = 0
        }
        "Center" {
            $leftPadding = [Math]::Floor(($consoleWidth - $longestLine) / 2)
            if ($leftPadding -lt 0) {
                $leftPadding = 0
            }
            $rightPadding = $consoleWidth - $longestLine - $leftPadding
            if ($rightPadding -lt 0) {
                $rightPadding = 0
            }
        }
        "Right" {
            $leftPadding = $consoleWidth - $longestLine
        }
    }

    if ($consoleWidth -lt ($longestLine + 2)) {
        # If the console width is less than the longest line plus 2, return false
        return $false
    }
    else {
        # Write the text to the console as block characters, line by line.
        $lines | ForEach-Object {
            $line = $_

            if ($Align -eq "Center") {
                # Right padding is added so we can fill it with spaces/background colour when using centered alignment.
                $line = (" " * $leftPadding) + $line + (" " * $rightPadding)
            }
            else {
                $line = (" " * $leftPadding) + $line
            }

            # If $line is empty (i.e. all spaces), write the line as a whole
            if ($line.Trim().Length -eq 0) {
                Write-Host $line -NoNewline -BackgroundColor $BackgroundColor
            }
            else {
                # Write the line to the console, character by character
                for ($i = 0; $i -lt $line.Length; $i++) {
                    $char = $line[$i]

                    # If the character is a space, write a space with the background color, otherwise write a space with the foreground color (to represent a lit pixel in the character).
                    if ($char -eq " ") {
                        Write-Host " " -NoNewline -BackgroundColor $BackgroundColor
                    }
                    else {
                        Write-Host " " -NoNewline -BackgroundColor $ForegroundColor
                    }
                }
            }

            # Add New Line to end.
            Write-Host
        }
    }
}

# Generates a list of distinct sale days, ensuring each is a certain number of days apart.
function GenerateSaleDays {
    param (
        [Parameter(Mandatory = $true)]
        [int]$SaleDaysCount,
        [Parameter(Mandatory = $true)]
        [int]$DaysApart
    )

    $saleDays = @()

    while ($saleDays.Count -lt $SaleDaysCount) {
        $randomDay = Get-Random -Minimum 1 -Maximum $script:GameDays
        if ($saleDays.Count -eq 0) {
            $saleDays += $randomDay
        }
        else {
            $validDay = $true
            foreach ($day in $saleDays) {
                if ([math]::Abs($day - $randomDay) -lt $DaysApart) {
                    $validDay = $false
                    break
                }
            }
            if ($validDay) {
                $saleDays += $randomDay
            }
        }
    }

    return $saleDays
}

function IsHomeDrugSaleDay {
    param (
        [int]$Day = $script:Player.GameDay
    )

    return [bool]($script:HomeDrugSaleDays -contains $Day)
}

# Initialize game state
function InitGame {
    # Game settings
    $startingCash = 2000
    $startingPockets = 100
    $cityCount = 8
    $gameDrugCount = 10
    $cityDrugCount = 6

    $script:GameDays = 30
    $script:GameOver = $false
    $script:RandomEventChance_Start = 10 # Percentage
    $script:RandomEventChance_Current = $script:RandomEventChance_Start

    # Creat object to hold Game Statistics
    $script:GameStats = [GameStats]::new()

    # Setup Home Drug sale days
    $script:HomeDrugSaleDays = GenerateSaleDays -SaleDaysCount 4 -DaysApart 5

    # Create and populate the drugs available for this game session.
    [Drug[]]$script:GameDrugs = InitGameDrugs -DrugCount $gameDrugCount

    # Create and populate the cities available for this game session.
    [City[]]$script:GameCities = InitGameCities -CityCount $cityCount -MaxDrugCount $cityDrugCount

    # Create player object, and populate with game-starting values.
    [Player]$script:Player = [Player]::new()
    $script:Player.Cash = $startingCash
    $script:Player.City = $script:GameCities | Get-Random
    $script:Player.set_PocketCount($startingPockets)

    # Fill starting City with random drugs.
    $script:Player.City.Drugs = $script:GameDrugs | Get-Random -Count $script:Player.City.MaxDrugCount

    # Update travel statistics
    $script:GameStats.AddVisitedCity($script:Player.City)
}

# Populates an array of City objects, using randomly chosen, unique names from the CityNames array.
function InitGameCities {
    param (
        [int]$CityCount = 8,
        [int]$MaxDrugCount = 6,
        [int]$GunShops = 2 # Number of cities to add guns to.
    )

    $cities = @()

    $gameCityNames = $script:CityNames | Get-Random -Count $CityCount | Sort-Object -Unique
    $gameCityNames | ForEach-Object {
        $city = [City]::new()
        $city.Name = $_
        $city.Drugs = @()
        $city.MaxDrugCount = $MaxDrugCount
        $city.HomeDrugNames = @()
        $city.HomeDrugSaleMultiplier = .20

        # Assign 1 or 2 random 'Home Drugs' to each city. These will stay the same for the entire game.
        # Home Drugs are drugs that are always sold at a discount (if in stock).
        $homeDrugCount = Get-Random -Minimum 1 -Maximum 3
        $script:GameDrugs | Get-Random -Count $homeDrugCount | ForEach-Object {
            $city.HomeDrugNames += $_.Name
        }

        $cities += $city
    }

    # Pick random cities to add guns to
    $gunShopCities = $cities | Get-Random -Count $GunShops
    foreach ($city in $gunShopCities) {
        # Add 6 random guns to this city
        $script:GunInfo | Get-Random -Count 6 | ForEach-Object {
            $city.AddGunToShop($_)
        }
    }

    return $cities
}

# Populates an array of Drug objects, using randomly chosen, unique names from the DrugNames array.
function InitGameDrugs {
    param (
        [int]$DrugCount = 10
    )

    $drugs = @()

    $drugCodes = $script:DrugCodes.Keys | Get-Random -Count $DrugCount | Sort-Object -Unique
    $drugCodes | ForEach-Object {
        $drug = [Drug]::new($script:DrugsInfo[$_]['Name'])
        $drug.Code = $_
        $drug.PriceRange = $script:DrugsInfo[$_]['PriceRange']
        $drug.PriceMultiplier = 1.0
        $drug.Quantity = 0

        $drugs += $drug
    }

    return $drugs
}

# Function to display list of provided cities in two alphabetized columns to the console.
function DisplayCities {
    param (
        [Parameter(Mandatory)]
        [City[]]$Cities
    )

    $sortedCities = $Cities.Name | Sort-Object
    $halfCount = [math]::Ceiling($sortedCities.Count / 2)

    $boxWidth = 96
    $leftColumnWidth = 45
    $rightColumnWidth = 45
    $gutterWidth = 1

    # Top border
    Write-Centered ('┌' + ('─' * ($boxWidth - 1)) + '┐')

    for ($i = 0; $i -lt $halfCount; $i++) {
        $leftCity = "$($i + 1). $($sortedCities[$i])"
        $rightCity = "$($i + $halfCount + 1). $($sortedCities[$i + $halfCount])"

        $leftCity = $leftCity.PadRight($leftColumnWidth)
        $rightCity = $rightCity.PadRight($rightColumnWidth)

        # Left gutter
        Write-Centered ('│' + (' ' * $gutterWidth) + $leftCity + (' ' * $gutterWidth) + '│' + (' ' * $gutterWidth) + $rightCity + (' ' * $gutterWidth) + '│')

        # Middle border
        if ($i -eq $halfCount - 1) {
            Write-Centered ('└' + ('─' * ($leftColumnWidth + $gutterWidth * 2)) + ('┴' + ('─' * ($rightColumnWidth + $gutterWidth * 2))) + '┘')
        }
        else {
            Write-Centered ('│' + (' ' * $gutterWidth) + ('─' * $leftColumnWidth) + (' ' * $gutterWidth) + '│' + (' ' * $gutterWidth) + ('─' * $rightColumnWidth) + (' ' * $gutterWidth) + '│')
        }
    }
}

# This function generates a string of drug names, separated by commas, based on the indices provided in the 'HomeDrugNames' array.
function GetHomeDrugString {
    param (
        [Parameter(Mandatory)]
        [string[]]$HomeDrugNames
    )

    $homeDrugString = ''
    for ($i = 0; $i -lt $HomeDrugNames.Count; $i++) {
        $homeDrugString += $HomeDrugNames[$i]
        if ($i -lt ($HomeDrugNames.Count - 1)) {
            $homeDrugString += ', '
        }
    }
    return $homeDrugString
}

# This function displays a menu header with the player's current cash, city, and home drug information in a formatted string.
function ShowHeader {
    $homeDrugString = GetHomeDrugString -HomeDrugNames $script:Player.City.HomeDrugNames

    Write-Host ('·' + ('═' * ($Host.UI.RawUI.WindowSize.Width - 2)) + '·') -ForegroundColor DarkGray
    Write-Centered ('Drug Wars :: Day {3} :: {1} ({2})' -f $script:Player.Cash, $script:Player.City.Name, $homeDrugString, $script:Player.GameDay)
    Write-centered ('Cash: ${0} :: Free Pockets: {1}/{2}' -f $script:Player.Cash, $script:Player.get_FreePocketCount(), $script:Player.Pockets)
    Write-Host ('·' + ('═' * ($Host.UI.RawUI.WindowSize.Width - 2)) + '·') -ForegroundColor DarkGray
}

# This function displays a psychedelic animation to the console.
function Tripout {
    param (
        [int]$LoopTime = 8
    )

    # Loop for X seconds (default 8)
    $startTime = Get-Date
    while ((Get-Date) -lt ($startTime.AddSeconds($LoopTime))) {
        # Get the current cursor position and buffer size
        $cursor = $Host.UI.RawUI.CursorPosition
        $buffer = $Host.UI.RawUI.BufferSize

        # Create a rectangle that covers the screen buffer from the top left corner to the cursor position
        $rect = New-Object System.Management.Automation.Host.Rectangle 0, 0, ($buffer.Width - 1), $cursor.Y

        # Get the buffer contents as an array of BufferCell objects
        $cells = $Host.UI.RawUI.GetBufferContents($rect)

        # Set the cursor position to the top left corner
        $Host.UI.RawUI.CursorPosition = New-Object System.Management.Automation.Host.Coordinates 0, 0

        # Loop through the array and write each character with its original background color
        foreach ($cell in $cells) {
            # Convert the character to a string
            $charString = [string]$cell.Character

            # Randomly choose to convert the character to uppercase or lowercase
            $char = if ((Get-Random -Minimum 0 -Maximum 2) -eq 0) {
                $charString.ToUpper()
            }
            else {
                $charString.ToLower()
            }

            Write-Host $char -NoNewline -ForegroundColor $(Get-Random -Minimum 1 -Maximum 16) -BackgroundColor $cell.BackgroundColor
        }

        Start-Sleep -Milliseconds $(Get-Random -Minimum 1 -Maximum 180)
    }
}

# This function displays the "Drug-o-peida".
function ShowDrugopedia {
    Clear-Host
    ShowHeader
    Write-Host
    Write-Centered '--------------'
    Write-Centered 'Drug-o-pedia'
    Write-Centered '--------------'
    Write-Host
    Write-Centered 'Information about the drugs currently active in this game session.'
    Write-Host
    $script:GameDrugs | ForEach-Object -Process {
        # This block is executed for each element in the array
        Write-Host ('· {0} ({1})' -f $_.Name, $_.Code)
        Write-Host ('· Base Price Range: ${0}-${1}' -f $_.PriceRange[0], $_.PriceRange[1])
        Write-Host ('· History: {0}' -f $script:DrugsInfo[$_.Code].History)
        Write-Host ('· Effects: {0}' -f $script:DrugsInfo[$_.Code].Effects)
        $streetNames = $script:DrugsInfo[$_.Code].StreetNames -join ', '
        Write-Host ('· Other Street Names: {0}' -f $streetNames)
        Write-Host

        # Check if the cursor position is near the bottom of the console window
        if ($host.UI.RawUI.CursorPosition.Y -ge ($host.UI.RawUI.WindowSize.Height - 6)) {
            PressEnterPrompt
            Clear-Host
        }
    } -End {
        # This block is executed once after processing all elements
        Write-Host 'End of list.'
        PressEnterPrompt
    }
}

# This function displays the main menu of the game.
function ShowMainMenu {
    Clear-Host
    ShowHeader

    Write-Host

    #region Display Inventory
    # Define the column width
    $columnWidth = 40

    if ($script:Player.get_Guns().Count -gt 0) {
        # Combine Clothing and Guns into OtherInventory for display.
        [string[]]$gunEntries = $script:Player.get_Guns() | ForEach-Object {
            '{0} (Power: {1})' -f $_.Name, $_.StoppingPower
        }
    }
    else {
        $gunEntries = @()
    }

    $otherInventory = $script:Player.Clothing + $gunEntries

    # Print the headers
    Write-Centered ("{0,-$columnWidth} {1,-$columnWidth}" -f "Your drugs:", "Other Inventory:")

    # Get the maximum count between the three collections
    $maxCount = [Math]::Max($script:Player.Drugs.Count, $otherInventory.Count)

    # Loop that many times
    for ($i = 0; $i -lt $maxCount; $i++) {
        # Get the drug, clothing, and gun at the current index, or null if the index is out of range
        $dispDrug = if ($i -lt $script:Player.Drugs.Count) {
            '· {0} {1}' -f $script:Player.Drugs[$i].Quantity, $script:Player.Drugs[$i].Name
        }
        elseif ($i -eq 0) {
            '· You have 0 marijuanas.'
        }

        $dispOtherInventory = if ($i -lt $otherInventory.Count) {
            '· {0}' -f $otherInventory[$i]
        }
        elseif ($i -eq 0) {
            '· You are naked.'
        }

        Write-Centered ("{0,-$columnWidth} {1,-$columnWidth}" -f $dispDrug, $dispOtherInventory)
    }
    #endregion Display Inventory

    #region Display menu options
    Write-Host
    Write-Host '[B]uy drugs'
    Write-Host '[S]ell drugs'
    Write-Host '[F]lush drugs'
    Write-Host
    Write-Host '[J]et to another city'
    # If this city has a Gun Shop show the Gun shop menu item
    if ($script:Player.City.HasGunShop()) {
        Write-Host '[G]un shop'
    }
    Write-Host
    Write-Host '[D]rug-o-pedia'
    Write-Host 's[T]atistics'
    Write-Host
    Write-Host '[Q]uit'
    Write-Host '[?]Help'
    Write-Host
    Write-Host 'What now, boss? ' -NoNewline
    #endregion Display menu options

    # Wait for user to press a valid key
    $choices = @('B', 'S', 'F', 'J', 'D', 'Q', 'T', '?', '!')
    # If there is gunshop include 'G' in choices
    if ($script:Player.City.HasGunShop()) {
        $choices += 'G'
    }
    $choice = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown').Character.ToString().ToUpper()
    while (-not $choices.Contains($choice)) {
        $choice = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown').Character.ToString().ToUpper()
    }

    # Return the Character of the key that was pressed (upper case)
    return $choice
}

# Function to display guns available in a city in a two column display
function ShowCityGuns {
    param (
        [Parameter(Mandatory)]
        [City]$City
    )

    $gunCount = $City.GunsForSale.Count
    $halfCount = [math]::Ceiling($gunCount / 2)
    $boxWidth = 96
    $leftColumnWidth = 45
    $rightColumnWidth = 45
    $gutterWidth = 1

    # Top border
    Write-Centered ('┌' + ('─' * ($boxWidth - 1)) + '┐')

    for ($i = 0; $i -lt $halfCount; $i++) {

        $leftGunName = '{0}' -f $City.GunsForSale[$i].Name
        $rightGunName = '{0}' -f $City.GunsForSale[$i + $halfCount].Name

        $leftGun = ('{0}. {1} ({2}) - ${3}' -f ($i + 1), $leftGunName, $City.GunsForSale[$i].StoppingPower, $City.GunsForSale[$i].get_Price())
        $rightGun = ('{0}. {1} ({2}) - ${3}' -f ($i + $halfCount + 1), $rightGunName, $City.GunsForSale[$i + $halfCount].StoppingPower, $City.GunsForSale[$i + $halfCount].get_Price())

        $leftGun = $leftGun.PadRight($leftColumnWidth)
        $rightGun = $rightGun.PadRight($rightColumnWidth)

        # Left gutter
        Write-Centered ('│' + (' ' * $gutterWidth) + $leftGun + (' ' * $gutterWidth) + '│' + (' ' * $gutterWidth) + $rightGun + (' ' * $gutterWidth) + '│')

        # Middle border
        if ($i -eq $halfCount - 1) {
            Write-Centered ('└' + ('─' * ($leftColumnWidth + $gutterWidth * 2)) + ('┴' + ('─' * ($rightColumnWidth + $gutterWidth * 2))) + '┘')
        }
        else {
            Write-Centered ('│' + (' ' * $gutterWidth) + ('─' * $leftColumnWidth) + (' ' * $gutterWidth) + '│' + (' ' * $gutterWidth) + ('─' * $rightColumnWidth) + (' ' * $gutterWidth) + '│')
        }
    }
}

# This function displays the gun shop menu.
function ShowGunshopMenu {

    function ShopSellsGun {
        param (
            [Parameter(Mandatory)]
            [int]$GunNumber
        )

        # Create clone of gun object for transaction.
        $cityGun = $script:Player.City.GunsForSale[$GunNumber - 1]
        $gunToBuy = [Gun]::new($cityGun)

        # Confirm the user wants to buy it.
        Write-Host
        Write-Host
        Write-Centered ('Are you sure you want to buy a {0} for ${1}? (Y/N)' -f $gunToBuy.Name, $gunToBuy.Price) -NoNewline

        do {
            $key = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown').Character.ToString().ToUpper()
        } until ($key -in @('Y', 'N'))

        if ($key -eq 'N') {
            $gunToBuy = $null
            return
        }

        # Buy the gun.
        Write-Host
        Write-Host
        $script:Player.BuyGun($gunToBuy)
        Write-Host
        PressEnterPrompt
    }

    function ShopBuysGun {
        $playerGunCount = $script:Player.get_Guns().Count

        Write-Host
        # If the player has no guns, return.
        if ($playerGunCount -eq 0) {
            Write-Host
            Write-Centered 'Hey, high-boy! You have no guns to sell.' -ForegroundColor Red
            Start-Sleep -Seconds 2
            Write-Host
            $getLostMessages = @(
                'Take a hike.',
                'Hit the road.',
                'Go away.',
                'Get lost.',
                'Scram.'
            )
            Write-Centered (Get-Random -InputObject $getLostMessages)
            Start-Sleep -Seconds 2
            Write-Host
            PressEnterPrompt
            return
        }

        # Display the player's guns.
        Write-Host
        for ($i = 0; $i -lt $playerGunCount; $i++) {
            $gun = $script:Player.get_Guns()[$i]
            Write-Centered ('{0}. {1} ({2})' -f ($i + 1), $gun.Name, $gun.StoppingPower)
        }

        # Prompt the player to choose a gun to sell.
        Write-Host
        Write-Centered ('Enter the number of the gun you want to sell (1-{0}), or "Q" to return to the gun shop menu' -f $playerGunCount) -NoNewline

        do {
            $key = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown').Character.ToString()
        } until ($key -in '1'.."$playerGunCount" -or $key -in @('q', 'Q'))

        if ($key -in '1'.."$playerGunCount") {
            $gunNumber = [int]$key
            $gunToSell = $script:Player.get_Guns()[$gunNumber - 1]
        }
        elseif ($key -in 'q', 'Q') {
            return
        }

        # Sell the gun.
        $script:Player.SellGun($gunToSell)
        Write-Host
        PressEnterPrompt
    }

    $gunSlang = @(
        'piece',
        'burner',
        'gat',
        'iron',
        'blaster',
        'gun',
        'heater',
        'strap'
    )

    do {
        Clear-Host
        ShowHeader
        Write-Host
        Write-Centered ('Welcome to {0}!' -f $script:Player.City.GunShopName)
        Write-Host
        Write-Centered 'We have the following heat for sale:' -ForegroundColor DarkGray
        Write-Host
        ShowCityGuns $script:Player.City
        Write-Host
        $gunCount = $script:Player.City.GunsForSale.Count
        Write-Centered ('Enter the number of the {0} you want to buy (1-{1}), "S" to sell, or "Q" to return to the main menu' -f (Get-Random -InputObject $gunSlang) , $gunCount) -NoNewline

        do {
            $key = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown').Character.ToString()
        } until ($key -in '1'.."$gunCount" -or $key -in @('s', 'S', 'q', 'Q'))

        switch ($key) {
            { $_ -in '1'.."$gunCount" } {
                # Convert $key string to an integer
                $gunNumber = [int]$key
                ShopSellsGun -GunNumber $gunNumber;
                break
            }
            { $_ -in 's', 'S' } {
                ShopBuysGun;
                break
            }
            { $_ -in 'q', 'Q' } {
                break
            }
        }
    } until ($key -in 'q', 'Q')
}

# Function to display drugs available in a city in a two column display
function ShowCityDrugs {
    param (
        [Parameter(Mandatory)]
        [City]$City
    )

    function GetFormattedDrugName {
        param (
            [Parameter(Mandatory)]
            [string]$DrugName,
            [Parameter(Mandatory)]
            [string[]]$HomeDrugNames,
            [Parameter(Mandatory)]
            [bool]$IsHomeDrugSaleDay
        )

        if (($DrugName -in $HomeDrugNames) -and $IsHomeDrugSaleDay) {
            $DrugName += " (Sale!)"
        }
        return $DrugName
    }

    $drugCount = $City.Drugs.Count
    $halfCount = [math]::Ceiling($drugCount / 2)
    $boxWidth = 96
    $leftColumnWidth = 45
    $rightColumnWidth = 45
    $gutterWidth = 1

    # Top border
    Write-Centered ('┌' + ('─' * ($boxWidth - 1)) + '┐')

    for ($i = 0; $i -lt $halfCount; $i++) {
        $isSaleDay = IsHomeDrugSaleDay

        $leftDrugName = GetFormattedDrugName `
            -DrugName $City.Drugs[$i].Name `
            -HomeDrugNames $City.HomeDrugNames `
            -IsHomeDrugSaleDay $isSaleDay

        $rightDrugName = GetFormattedDrugName `
            -DrugName $City.Drugs[$i + $halfCount].Name `
            -HomeDrugNames $City.HomeDrugNames `
            -IsHomeDrugSaleDay $isSaleDay

        $leftDrug = ('{0}. {1} - ${2}' -f ($i + 1), $leftDrugName, $City.Drugs[$i].get_Price())
        $rightDrug = ('{0}. {1} - ${2}' -f ($i + $halfCount + 1), $rightDrugName, $City.Drugs[$i + $halfCount].get_Price())

        $leftDrug = $leftDrug.PadRight($leftColumnWidth)
        $rightDrug = $rightDrug.PadRight($rightColumnWidth)

        # Left gutter
        Write-Centered ('│' + (' ' * $gutterWidth) + $leftDrug + (' ' * $gutterWidth) + '│' + (' ' * $gutterWidth) + $rightDrug + (' ' * $gutterWidth) + '│')

        # Middle border
        if ($i -eq $halfCount - 1) {
            Write-Centered ('└' + ('─' * ($leftColumnWidth + $gutterWidth * 2)) + ('┴' + ('─' * ($rightColumnWidth + $gutterWidth * 2))) + '┘')
        }
        else {
            Write-Centered ('│' + (' ' * $gutterWidth) + ('─' * $leftColumnWidth) + (' ' * $gutterWidth) + '│' + (' ' * $gutterWidth) + ('─' * $rightColumnWidth) + (' ' * $gutterWidth) + '│')
        }
    }
}

# This function displays the drug buying menu.
function ShowBuyDrugsMenu {
    Clear-Host
    ShowHeader
    Write-Host
    Write-Centered "Buy Drugs"
    Write-Host
    ShowCityDrugs $script:Player.City
    Write-Host
    $drugCount = $script:Player.City.Drugs.Count
    Write-Centered "Enter the number of the drug you want to buy (1-$drugCount, or 'Q' to return to the main menu) " -NoNewline
    $drugNumber = $null
    while (-not $drugNumber) {
        $key = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown').Character.ToString()
        switch ($key) {
            { $_ -in '1'.."$drugCount" } { $drugNumber = [int]$key; break }
            { $_ -in 'q', 'Q' } { return }
        }
    }

    Write-Host
    # Create clone of drug object for transaction.
    $cityDrug = $script:Player.City.Drugs[$drugNumber - 1]
    $drugToBuy = [Drug]::new($cityDrug.Name)
    $drugToBuy.BasePrice = $cityDrug.BasePrice
    $drugToBuy.PriceMultiplier = $cityDrug.PriceMultiplier

    $maxQuantity = [math]::Floor($script:Player.Cash / $drugToBuy.get_Price())

    # Ask how many they want to buy.
    $quantity = Read-Host "Enter the quantity you want to buy (max $maxQuantity)"
    $quantityInt = 0
    if (-not [int]::TryParse($quantity, [ref]$quantityInt) -or $quantityInt -lt 1) {
        Write-Centered "Invalid quantity."
        PressEnterPrompt
        return
    }

    # Buy the drugs.
    $drugToBuy.Quantity = $quantityInt
    $script:Player.BuyDrugs($drugToBuy)

    PressEnterPrompt
}

# This function displays the drug selling menu.
function ShowSellDrugsMenu {
    Clear-Host
    ShowHeader
    Write-Host
    Write-Centered "Sell Drugs"
    Write-Host
    ShowCityDrugs $script:Player.City
    Write-Host
    $drugCount = $script:Player.City.Drugs.Count

    # Ask which drug they want to sell.
    Write-Centered "Enter the number of the drug you want to sell (1-$drugCount, or 'Q' to return to the main menu) " -NoNewline
    $drugNumber = $null
    while (-not $drugNumber) {
        $key = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown').Character.ToString()
        switch ($key) {
            { $_ -in '1'.."$drugCount" } { $drugNumber = [int]$key; break }
            { $_ -in 'q', 'Q' } { return }
        }
    }

    Write-Host
    $nameOfDrugToSell = $script:Player.City.Drugs[$drugNumber - 1].Name
    $drugToSell = $script:Player.Drugs | Where-Object { $_.Name -eq $nameOfDrugToSell }


    if (!$drugToSell) {
        Write-Centered ('You don''t have any {0} to sell!' -f $nameOfDrugToSell)
        PressEnterPrompt
        return
    }

    $maxQuantity = $drugToSell.Quantity

    # Ask how many they want to sell.
    $quantity = Read-Host ('Enter the quantity you want to sell (max {0})' -f $maxQuantity)
    $quantityInt = 0
    if (-not [int]::TryParse($quantity, [ref]$quantityInt) -or $quantityInt -lt 1) {
        Write-Centered "Invalid quantity."
        PressEnterPrompt
        return
    }

    # Sell the drugs.
    $script:Player.SellDrugs($drugToSell, $quantityInt)

    PressEnterPrompt
}

# This function displays the drug flushing menu.
function ShowFlushDrugsMenu {
    Clear-Host
    ShowHeader
    Write-Host

    # If the user has no drugs, display a message and exit the function.
    if ($script:Player.Drugs.Count -eq 0) {

        $phrases = @(
            'Are you on cloud nine?',
            'Ever notice that...',
            'Hey, guess what?',
            'How high are you?',
            'I guess you missed it on the main screen...?',
            'In case you didn''t notice...',
            'Just a heads up...',
            'On a scale from 1 to 10, how lifted are you?',
            'Pssst...',
            'You high?',
            'You must be so broke, you can''t even pay attention!',
            'You seem spaced out.'
        )

        $insults = @(
            'amigo',
            'bud',
            'chump',
            'homey',
            'mate',
            'pal',
            'punk',
            'tea-head',
            'wiseguy'
        )

        Write-Centered (Get-Random -InputObject $phrases)
        Start-Sleep 1
        Write-Host
        Write-BlockLetters 'You have' -Align Center -ForegroundColor White -BackgroundColor DarkRed -VerticalPadding 1
        Write-BlockLetters '0 marijuanas!' -Align Center -ForegroundColor White -BackgroundColor DarkRed -VerticalPadding 1
        Start-Sleep 1
        Write-Host
        Write-Centered ('What are you gonna flush, {0}?' -f (Get-Random -InputObject $insults))
        Start-Sleep 2
        Write-Centered 'Nothing, that''s what!' -ForegroundColor DarkMagenta
        Write-Host
        Start-Sleep 1
        PressEnterPrompt
        return
    }

    #region Display Drug Inventory
    Write-Centered "Your drugs:"
    Write-Host

    # Create an empty array to store the drug menu
    $drugMenu = @()
    $drugNumber = 1

    # Iterate through each drug in the player's inventory
    foreach ($drug in $script:Player.Drugs) {
        # Create a custom object to store drug information
        $drugInfo = [PSCustomObject]@{
            Number   = $drugNumber
            Name     = $drug.Name
            Quantity = [int]$drug.Quantity
        }
        # Add the drug information to the drug menu array
        $drugMenu += $drugInfo
        $drugNumber++
    }

    # Get the length of the longest line
    $longestLength = 0
    foreach ($drugInfo in $drugMenu) {
        $currentLength = ('{0}. {1} ({2})' -f $drugInfo.Number, $drugInfo.Name, $drugInfo.Quantity).Length
        if ($currentLength -gt $longestLength) {
            $longestLength = $currentLength
        }
    }

    # Display the drug list
    foreach ($drugInfo in $drugMenu) {
        $dispDrug = '{0}. {1} ({2})' -f $drugInfo.Number, $drugInfo.Name, $drugInfo.Quantity
        $paddedDispDrug = $dispDrug.PadRight($longestLength)
        $centeredDispDrug = $paddedDispDrug.PadLeft(($paddedDispDrug.Length + $longestLength) / 2)
        Write-Centered $centeredDispDrug
    }
    #endregion Display Drug Inventory

    Write-Host

    # Ask which drug they want to flush.
    $drugCount = $drugMenu.Count
    Write-Centered ('Enter the number of the drug you want to flush (1-{0}, or ''Q'' to return to the main menu)' -f $drugCount) -NoNewline
    $drugNumber = $null
    while (-not $drugNumber) {
        $key = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown').Character.ToString()
        switch ($key) {
            { $_ -in '1'.."$drugCount" } { $drugNumber = [int]$key; break }
            { $_ -in 'q', 'Q' } { return }
        }
    }

    # Get quantity to flush.
    [int]$maxQuantity = $drugMenu[$drugNumber - 1].Quantity
    $quantityToFlush = Read-Host -Prompt ('Enter the quantity you want to flush (max {0})' -f $maxQuantity)
    [int]$parsedResult = $null
    while ((-not [int]::TryParse($quantityToFlush, [ref]$parsedResult)) -or ($parsedResult -gt $maxQuantity) -or ($parsedResult -lt 0)) {
        # Move up a line and back to the start.
        $y = $host.UI.RawUI.CursorPosition.Y - 1
        $host.UI.RawUI.CursorPosition = New-Object System.Management.Automation.Host.Coordinates 0, $y

        # Clear the line
        Write-Host (' ' * $host.UI.RawUI.BufferSize.Width) -NoNewline
        $host.UI.RawUI.CursorPosition = New-Object System.Management.Automation.Host.Coordinates 0, $host.UI.RawUI.CursorPosition.Y

        # Re-display the prompt
        $quantityToFlush = Read-Host -Prompt ('Enter the quantity you want to flush (max {0})' -f $maxQuantity)
    }
    $quantityToFlush = $parsedResult

    # If the quality to flush is 0, exit the function.
    if ($quantityToFlush -eq 0) {
        Write-Host
        Write-Centered 'You decide not to flush the stuff.'
        Start-Sleep 2
        Write-Host
        PressEnterPrompt
        return
    }

    Write-Host
    # Create clone of drug object for flushing action.
    $nameOfDrugToFlush = $drugMenu[$drugNumber - 1].Name
    $drugToFlush = $script:Player.Drugs | Where-Object { $_.Name -eq $nameOfDrugToFlush }

    # There's a 1 in 3 chance it'll offer you to take the drugs instead of flushing them
    if ((Get-Random -Minimum 1 -Maximum 4) -eq 1) {

        $drugCompliments = @(
            'tempting',
            'tasty',
            'yummy',
            'inviting',
            'finger-lickin''',
            'scrum-dilly-umptious'
        )

        # Determine if the drug name ends in an 's' or not, and use the appropriate words in the sentence.
        $wordsToUse = if ($nameOfDrugToFlush.EndsWith('s')) {
            @('Those', 'are')
        }
        else {
            @('That', 'is')
        }

        Write-Host

        Write-Centered ('{0} {1} {2} looking pretty {3}!' -f $wordsToUse[0], $nameOfDrugToFlush, $wordsToUse[1], (Get-Random -InputObject $drugCompliments)) -ForegroundColor Yellow
        Start-Sleep 2
        Write-Centered 'You want to take them instead of flushing them (Y/N)?'
        $choice = $null
        while (-not $choice) {
            $key = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown').Character.ToString()
            switch ($key) {
                { $_ -in 'y', 'Y' } { $choice = 'take'; break }
                { $_ -in 'n', 'N' } { $choice = 'flush'; break }
            }
        }

        if ($choice -eq 'take') {
            # Ingest the drugs.
            $script:Player.RemoveDrugs($drugToFlush, $quantityToFlush)
            Write-Host

            # Generate a random number between 1 and 10.
            $randomNumber = Get-Random -Minimum 1 -Maximum 11

            # There's a 20% chance (2 out of 10) for a bad trip.
            if ($randomNumber -le 2) {
                Write-Centered 'Uh oh...'
                Start-Sleep 2
                Write-BlockLetters 'Bad Trip!' -Align Center -ForegroundColor DarkMagenta -VerticalPadding 1
                Write-Host
                Tripout
                Write-Centered 'You lose a day exploring the insides of your mind.' -ForegroundColor Red
                Start-Sleep 3
                $script:GameDays--
                Write-Centered ('Days left: {0}' -f ($script:GameDays - $script:Player.GameDay))
            }
            # There's a 20% chance (2 out of 10) for feeling euphoric.
            elseif ($randomNumber -le 4) {
                Write-Centered 'You feel euphoric.' -ForegroundColor Cyan
                Start-Sleep 2
                # There's a 50% chance at this point (1 out of 2) for gaining a game day.
                if ((Get-Random -Minimum 1 -Maximum 3) -eq 1) {
                    Write-Centered 'You feel like you could do anything!'
                    Start-Sleep 2
                    Write-BlockLetters 'Gained a day!' -ForegroundColor Green -VerticalPadding 1 -Align Center

                    # Add a day to the game
                    $script:GameDays++
                    Write-Centered ('Days left: {0}' -f ($script:GameDays - $script:Player.GameDay))
                }
            }
            # There's a 60% chance (6 out of 10) for feeling a little buzzed.
            else {
                Write-Centered 'You feel a little buzzed.' -ForegroundColor Yellow
            }

            Write-Host
            PressEnterPrompt
            return
        }
    }

    # Flush the drugs.
    Clear-Host
    ShowHeader
    Write-Host

    $script:Player.RemoveDrugs($drugToFlush, $quantityToFlush)
    Write-BlockLetters ('Flushed' -f $quantityToFlush, $nameOfDrugToFlush) -Align Center -ForegroundColor White -BackgroundColor DarkGreen -VerticalPadding 1
    Write-BlockLetters ('{0} {1}!' -f $quantityToFlush, $nameOfDrugToFlush) -Align Center -ForegroundColor White -BackgroundColor DarkGreen -VerticalPadding 1

    Start-Sleep 2
    Write-Host
    PressEnterPrompt
}

# This function displays a list of cities to the console, and prompts the user to select a city to travel to.
function Jet {
    Clear-Host
    ShowHeader
    Write-Host
    Write-Centered "Jet to Another City"
    Write-Host
    DisplayCities -Cities $script:GameCities
    Write-Host
    $cityCount = $script:GameCities.Count

    $ticketPrice = 100
    # If the player can't pay the ticket price, tell them and then exit the function.
    if ($script:Player.Cash -lt $ticketPrice) {
        Write-Centered ('You don''t have enough cash to buy a ticket, Chum...p!') -ForegroundColor Red
        Start-Sleep 3
        PressEnterPrompt
        return
    }

    $newCity = $null
    Write-Centered "Enter the city you want to jet to (1-$cityCount, or 'Q' to return to the main menu) " -NoNewline
    while (-not $newCity) {
        $key = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown').Character.ToString()
        switch ($key) {
            { $_ -in '1'.."$cityCount" } { $newCity = [int]$key; break }
            { $_ -in 'q', 'Q' } { return }
        }
    }
    Write-Host

    # Alphabetize the cities by name, then assign the selected city.
    [City[]]$alphabetizedCities = $script:GameCities | Sort-Object -Property Name
    $destinationCity = $alphabetizedCities[$newCity - 1]

    # If the new city is different from the player's current city, then travel to the new city.
    if ($script:Player.City -ne $destinationCity) {
        Write-Host
        Write-Centered ('You hit the airport and catch a flight to {0}.' -f $destinationCity.Name)
        Start-Sleep -Milliseconds 500

        if ($script:Player.GameDay -eq $script:GameDays) {
            # Last flight of the game is free.
            Write-Centered 'You are whisked through to your flight as a VIP, and the ticket is free!' -ForegroundColor Green
        }
        else {
            Write-Centered ('The ticket costs you ${0}, and the trip will take a day.' -f $ticketPrice) -ForegroundColor Yellow

            # Subtract ticket price from player's cash.
            $script:Player.Cash -= $ticketPrice

            # If the player has a gun, they migth get busted by air marshals.
            if ($script:Player.get_Guns().Count -gt 0) {
                Start-Sleep 1
                Write-Host
                Write-Centered 'You head on through the metal-detector, and...'
                Start-Sleep 2

                # Retrieve the player's stopping power
                $stoppingPower = $script:Player.get_StoppingPower()

                # Calculate the percentage chance of getting busted based on the player's stopping power.
                # The chance is a quarter of the player's stopping power, with a minimum of 1% and a maximum of 5%.
                $percentageChanceOfGettingBusted = [math]::Max(1, [math]::Min($stoppingPower * 0.25, 5))

                # Generate a random number between 1 and 100 (inclusive) for use in determining if the player gets busted.
                $randomNumber = Get-Random -Minimum 1 -Maximum 101
                if ($randomNumber -le $percentageChanceOfGettingBusted) {
                    Write-Host
                    $colors = @('DarkRed', 'Blue')
                    for ($i = 0; $i -lt 3; $i++) {
                        foreach ($color in $colors) {
                            Write-Centered "Beep!`a" -ForegroundColor $color -NoNewline
                            Write-Host "`r" -NoNewline
                            Start-Sleep -Milliseconds 750
                        }
                    }
                    Write-Centered "Beeeeeeeeeeep!`a`a`a" -ForegroundColor Red
                    Start-Sleep -Seconds 2
                    Write-Host
                    $weaponSlang = @(
                        'piece',
                        'burner',
                        'gat',
                        'blaster',
                        'gun',
                        'heater',
                        'strap',
                        'weapon'
                    )

                    Write-Centered ('The air marshals discover your {0}!' -f (Get-Random -InputObject $weaponSlang)) -ForegroundColor Yellow
                    Start-Sleep 3
                    Write-Host
                    PressEnterPrompt
                    StartRandomEvent -EventName 'Busted'
                    # If the player is busted, return (back to main menu)
                    return
                }
                else {
                    $nothinHappensPhrases = @(
                        'straight up, nothing pops off.  You good, homey.',
                        'ain''t nobody doin'' nothin''.',
                        'nothin'', capisce?',
                        'nada, man.  All good.',
                        'nothing happens.',
                        'they don''t find shit.',
                        'the inspectors are apparently blind.',
                        'your connections have helped again. You got waved through.',
                        'you breeze through security without a hitch.',
                        'the air marshals are too busy chatting to notice anything.',
                        'the metal-detector malfunctions and you walk right through.',
                        'the air marshals mistake you for a celebrity and let you pass.'
                    )

                    Write-Centered ('...{0}' -f (Get-Random -InputObject $nothinHappensPhrases)) -ForegroundColor DarkGray
                }
            }
        }
        Start-Sleep 3
        Write-Host

        # Travel takes a day, change clothes
        AdvanceGameDay -ChangeOutfit

        # Set player's new location.
        $script:Player.City = $destinationCity

        # Update travel statistics.
        $script:GameStats.AddVisitedCity($destinationCity)

        # Fill landing City with random drugs.
        $script:Player.City.Drugs = $script:GameDrugs | Get-Random -Count $script:Player.City.MaxDrugCount

        # If it's sale day, adjust multiplier for the new city's home drugs.
        if (IsHomeDrugSaleDay) {
            $params = @{
                DrugNames  = $script:Player.City.HomeDrugNames
                Multiplier = $script:Player.City.HomeDrugSaleMultiplier
            }
            SetDrugPriceMultiplier @params
        }

        $arrivalMessages = @(
            'You arrive in {0} and immidiately hit the streets.',
            'Welcome to beautiful {0}!',
            'You arrive in {0} and get to hustlin''.',
            'As you arrive in {0}, you can''t help but notice the smell of {1} in the air.',
            'Welcome to {0}. What a shit-hole.'
        )

        $arrivalMessage = Get-Random -InputObject $arrivalMessages
        Write-Host
        Write-Centered ($arrivalMessage -f $destinationCity.Name, $destinationCity.HomeDrugNames[0]) -ForegroundColor Green
    }
    else {
        Write-Host
        Write-Centered ('Lay off your stash man!  You''re already in {0}!' -f $script:Player.City.Name) -ForegroundColor Yellow
    }

    Start-Sleep 2
    Write-Host
    PressEnterPrompt
}

# This function handles a random event.
function StartRandomEvent {
    param (
        [string]$EventName
    )

    # Track Event in Game Statistics
    $script:GameStats.EventsExperienced++

    # If no Event Name is specified do a random event (usual usage)
    if (!$EventName) {
        # Set the base chance for a cop fight to 10%
        $baseChance = 10

        # Set the increase in chance per $5000 the player has to 2%
        $increasePer5000 = 2

        # Calculate the increased chance for a cop fight based on the player's cash
        # For every $5000 the player has, the chance for a cop fight increases by $increasePer5000 (max. 60%)
        $increasedChance = [Math]::Min(60, $baseChance + (($script:Player.Cash / 5000) * $increasePer5000))

        # Generate a random number between 1 and 100
        $randomNumber = Get-Random -Minimum 1 -Maximum 101
        if ($randomNumber -le $increasedChance) {
            CopFight
            return
        }
        else {
            $randomEvent = $script:RandomEvents | Get-Random
        }
    }
    else {
        # For debugging purposes...

        # If the event name is 'Cops' or 'CopFight', then call the CopFight function and return.
        if ($EventName -eq 'Cops' -or $EventName -eq 'CopFight') {
            CopFight
            return
        }

        # If the event name is 'Jail', then call the JailForLife function.
        if ($EventName -eq 'Jail') {
            JailForLife
            return
        }

        # If the event name is 'Whale', then add $100000 to the player's cash.
        if ($EventName -eq 'Whale') {
            $script:Player.Cash += 100000
            Write-Host
            Write-Centered 'You found a whale!' -ForegroundColor Green
            Write-Centered 'You get $100,000!' -ForegroundColor Green
            Write-Host
            PressEnterPrompt
            return
        }

        # If the event name is 'TimeTravel', then let player pick the day to transport to (must be more than 0, and less than $script:GameDays)
        if ($EventName -eq 'TimeTravel') {
            $newDay = Read-Host ('Enter the day you want to travel to (1-{0})' -f $script:GameDays)
            $newDayInt = 0
            if (-not [int]::TryParse($newDay, [ref]$newDayInt) -or $newDayInt -lt 1 -or $newDayInt -gt $script:GameDays) {
                Write-Centered "Invalid day."
                PressEnterPrompt
                return
            }

            $script:Player.GameDay = $newDayInt
            Write-Host
            Write-Centered ('Dr. Who music plays...') -ForegroundColor DarkGray
            Write-Centered ('You travel in time to day {0}!' -f $newDayInt) -ForegroundColor Green
            Write-Host
            PressEnterPrompt
            return
        }

        # Otherwise, set the random event to the event with the specified name.
        $randomEvent = $script:RandomEvents | Where-Object { $_.Name -eq $EventName }
    }

    Clear-Host
    ShowHeader
    Write-Host
    $eventName = ('{0}!' -f $randomEvent.Name)
    if ((Write-BlockLetters $eventName -Align Center) -eq $false) {
        Write-Centered $eventName
    }
    Write-Host
    Write-Host
    Write-Centered $randomEvent.Description
    # Execute the effect of the random event
    & $randomEvent.Effect

    # Update MostCashAtOnce stats by comparing player's current cash
    $script:GameStats.UpdateMostCashAtOnce($script:Player.Cash)

    Write-Host
    PressEnterPrompt
}

# This function displays a prompt to the user to press Enter to continue.
function PressEnterPrompt {
    # Clear existing keyboard buffer
    $Host.UI.RawUI.Flushinputbuffer()
    Write-Centered 'Press Enter to continue' -NoNewline
    $choice = $null
    while ($choice.VirtualKeyCode -ne 13) {
        $choice = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
    }
    $Host.UI.RawUI.Flushinputbuffer()
}

# Function to show 'goign to jail for life' screen/end game.
function JailForLife {
    # Function display the Jail graphic.
    function DrawJailGraphic {
        $jailASCII = @(
            '  _________________________',
            '     ||   ||     ||   ||',
            '     ||   ||, , ,||   ||',
            '     ||  (||/|/(\||/  ||',
            '     ||  ||| _''_`|||  ||',
            '     ||   || o o ||   ||',
            '     ||  (||  - `||)  ||',
            '     ||   ||  =  ||   ||',
            '     ||   ||\___/||   ||',
            '     ||___||) , (||___||',
            '    /||---||-\_/-||---||\',
            '   / ||--_||_____||_--|| \',
            '  (_(||)-| P[no]-42 |-(||)_)',
            '|"""""""""""""""""""""""""""|',
            '|  Enjoy the next 25-life,  |',
            '|          [name]           |',
            ' """""""""""""""""""""""""""'
        )

        # Generate a random "prisoner number".
        $pNumberText = (Get-Random -Minimum 100 -Maximum 999).ToString()

        # Array of nicknames for prisoner
        $pNames = @(
            'bro',
            'bruh',
            'chump',
            'dummy',
            'fish',
            'fool',
            'homie',
            'j-cat',
            'lad',
            'playa',
            'sucka',
            'tuffy'
        )

        # Select a random name from the $pNames array and append an exclamation mark to it
        $paddedName = "{0}!" -f ($pNames | Get-Random)

        # Calculate the padding length for the name
        $paddingLength = [Math]::Max(0, (6 - $paddedName.Length) / 2)

        # Pad the name with spaces
        $paddedName = $paddedName.PadLeft($paddingLength + $paddedName.Length).PadRight(6)

        # Determine the longest line in the jail ASCII
        $maxLength = ($jailASCII | Measure-Object -Property Length -Maximum).Maximum

        foreach ($line in $jailASCII) {
            $formattedLine = $line `
                -replace '\[no\]', $pNumberText `
                -replace '\[name\]', $paddedName

            # Pad each line to the length of the longest line
            $formattedLine = $formattedLine.PadRight($maxLength)

            Write-Centered $formattedLine -ForegroundColor White
        }
    }

    $goingToJailPhrases = @(
        'Act dumb, get dumped.',
        'If you poke the bear, expect to get bit.',
        'If you wanna play, you gotta pay.',
        'Play stupid games, win stupid prizes.',
        'Spark negativity, catch a cosmic slap.',
        'Start beef, catch grief.',
        'You mess with the bull, you get the horns.',
        'You play with fire, you get burned.'
    )

    $caughtByPolicePhrases = @(
        'The cops roll up and snatch you!',
        'The cops sieze their chance and grab you!',
        'The pigs nabbed yer ass!',
        'You got clipped by the flatfoots!',
        'You got pinched by the G-men!'
    )

    Clear-Host
    ShowHeader
    Write-Host
    Write-Centered $(Get-Random -InputObject $caughtByPolicePhrases) -ForegroundColor Red
    DrawJailGraphic
    Write-Host
    Write-Centered $(Get-Random -InputObject $goingToJailPhrases) -ForegroundColor DarkGray
    Start-Sleep 2
    Write-Host

    # Remove players Drugs and Guns
    if ($script:Player.Drugs.Count -gt 0) {
        Write-Centered 'Drugs...'
        Start-Sleep 1
        $script:Player.Drugs = @()
        Write-Centered 'Gone!' -ForegroundColor DarkGray
        Write-Host
    }

    if ($script:Player.get_Guns().Count -gt 0) {
        Write-Centered 'Guns...'
        Start-Sleep 1
        $script:Player.DumpGuns()
        Write-Centered 'Gone!' -ForegroundColor DarkGray
        Write-Host
    }

    if ($script:Player.Cash -gt 10) {
        # Calculate the lawyer fees (90% of their cash)
        $lawyerFees = [Math]::Round($script:Player.Cash * 0.9)

        # Deduct the lawyer fees from the player's cash
        $script:Player.Cash -= $lawyerFees

        Write-Centered 'Lawyer fees:'
        Start-Sleep 1
        Write-Centered ('${0} deducted from your cash.' -f $lawyerFees) -ForegroundColor Yellow
        Write-Host
    }

    PressEnterPrompt
    EndGame
}

# This function is called when the player chooses to quit the game.
function QuitGame {
    # Check if they're sure they want to quit.
    Write-Host
    Write-Centered 'Are you sure you want to quit? (Y/N)' -NoNewline
    # Wait for user to press a valid key
    $Host.UI.RawUI.Flushinputbuffer()
    do {
        $choice = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown').Character.ToString().ToUpper()
    } while ('Y', 'N' -notcontains $choice)

    if ($choice -eq 'Y') {
        EndGame
    }
}

# This function is called to end the game.
function EndGame {
    Clear-Host
    Write-Host
    $days = $script:Player.GameDay
    $daysLabel = if ($days -eq 1) { 'day' } else { 'days' }
    Write-Centered ('You survived {0} {1}, and ended up with ${2} in cash.' -f $days, $daysLabel, $script:Player.Cash)
    if ($script:Player.Drugs.Count -gt 0) {
        Write-Host
        Write-Centered 'Drugs left over:'
        $script:Player.Drugs | ForEach-Object {
            Write-Centered ('· {0} {1}' -f $_.Quantity, $_.Name)
        }
    }
    Write-Host
    if ((Write-BlockLetters 'Thanks for playing!' -Align Center -BackgroundColor Blue -VerticalPadding 1) -eq $false) {
        Write-Centered 'Thanks for playing!' -BackgroundColor Blue
    }

    if (IsHighScore -Score $script:Player.Cash) {
        Write-Host
        Write-Centered 'You got a high score!' -ForegroundColor Green
        Write-Host
        Write-Centered 'Enter your initials to save it to the high score list:'
        Write-Host

        # Figure out leftpadding for input of initials
        $leftPadding = [Math]::Floor(($Host.UI.RawUI.WindowSize.Width - 3) / 2)
        Write-Host (' ' * $leftPadding) -NoNewline

        $initials = ""
        $Host.UI.RawUI.Flushinputbuffer()
        while ($true) {
            $key = [System.Console]::ReadKey($true)
            if ($key.Key -eq "Enter") {
                break
            }
            elseif ($key.Key -eq "Backspace") {
                if ($initials.Length -gt 0) {
                    $initials = $initials.Substring(0, $initials.Length - 1)
                    [System.Console]::Write("`b `b") # erase the last character
                }
            }
            elseif ($initials.Length -lt 3) {
                $upperCasedChar = $key.KeyChar.ToString().ToUpper()
                $initials += $upperCasedChar
                [System.Console]::Write($upperCasedChar)
            }
        }
        Write-Host

        # Convert the initials to uppercase, and save them to the player object.
        $script:Player.Initials = $initials.ToUpper()

        # Add the high score to the high score list.
        AddHighScore -Initials $script:Player.Initials -Score $script:Player.Cash
    }

    # Display high scores center justified on screen, with a header
    Write-Host
    Write-Centered '-----------------'
    Write-Centered 'Highest Dealers'
    Write-Centered '-----------------'
    Write-Host
    $highScores = GetHighScores
    $maxScoreLength = ($highScores | Measure-Object -Property Score -Maximum).Maximum.ToString().Length

    $highScores | ForEach-Object {
        $score = $_.Score.ToString().PadRight($maxScoreLength)
        if ($_.Initials -eq $script:Player.Initials -and $_.Score -eq $script:Player.Cash) {
            Write-Centered ('-> {0} - ${1} <-' -f $_.Initials, $score) -ForegroundColor Green
        }
        elseif ($_.Initials -eq $highScores[0].Initials -and $_.Score -eq $highScores[0].Score) {
            Write-Centered ('{0} - ${1}' -f $_.Initials, $score) -ForegroundColor Yellow
        }
        elseif ($_.Initials -eq $highScores[1].Initials -and $_.Score -eq $highScores[1].Score) {
            Write-Centered ('{0} - ${1}' -f $_.Initials, $score) -ForegroundColor Gray
        }
        elseif ($_.Initials -eq $highScores[2].Initials -and $_.Score -eq $highScores[2].Score) {
            Write-Centered ('{0} - ${1}' -f $_.Initials, $score) -ForegroundColor DarkYellow
        }
        else {
            Write-Centered ('{0} - ${1}' -f $_.Initials, $score) -ForegroundColor DarkGray
        }
    }

    $script:GameOver = $true

    Write-Host
    Write-Centered 'Would you like to play again? (Y/N)' -NoNewline
    # Wait for user to press a valid key
    $Host.UI.RawUI.Flushinputbuffer()
    do {
        $choice = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown').Character.ToString().ToUpper()
    } while ('Y', 'N' -notcontains $choice)

    if ($choice -eq 'N') {
        $script:Playing = $false
    }
}

# This function displays the game over screen when the player runs out of days.
function ShowGameOverCuzDays {
    param (
        [int]$GameDays
    )

    Clear-Host
    ShowHeader
    Write-Host

    # Define an array of colors
    $colours = [System.ConsoleColor]::GetValues([System.ConsoleColor])

    # Loop through each color in the array (skipping black)
    foreach ($colour in $colours) {
        if ($colour -eq [System.ConsoleColor]::Black) {
            continue
        }

        Write-BlockLetters ('Day {0}!' -f ($GameDays + 1)) -ForegroundColor $colour -VerticalPadding 1 -Align Center

        if ($colour -eq $colours[-1]) {
            break
        }
        OverWriteLastLines -Count 7
    }

    Start-Sleep -Seconds 2
    Write-Host
    Write-Centered 'Time''s up, boss!' -ForegroundColor Green
    Start-Sleep -Seconds 3
    Write-Host
    PressEnterPrompt
    EndGame
}


# This function displays the help screen.
function ShowHelp {
    Clear-Host
    ShowHeader
    Write-Host
    Write-Centered '------'
    Write-Centered 'Help'
    Write-Centered '------'
    Write-Host
    Write-Centered 'Drug Wars is a text-based game where you buy and sell drugs in various cities around the world.'
    Write-Centered ('The goal is to make as much cash money as possible in {0} days.' -f $script:GameDays)
    Write-Host
    Write-Host 'Main Menu'
    Write-Host '---------'
    Write-Host '[B]uy drugs'
    Write-Host '[S]ell drugs'
    Write-Host '[F]lush drugs'
    Write-Host '[G]un shop'
    Write-Host '[J]et to another city'
    Write-Host '[D]rug-o-pedia'
    Write-Host '[Q]uit'
    Write-Host
    Write-Host 'Buy Drugs'
    Write-Host '---------'
    Write-Host 'This displays the current prices of all drugs in the city you are in.'
    Write-Host 'Enter the name of the drug you want to buy, and the quantity you want to buy.'
    Write-Host 'You can only buy as much as you can afford, and as much as you have room for in your pockets.'
    Write-Host
    Write-Host 'Sell Drugs'
    Write-Host '----------'
    Write-Host 'This displays the current prices of all drugs in the city you are in.'
    Write-Host 'Enter the name of the drug you want to sell, and the quantity you want to sell.'
    Write-Host 'You can only sell as much as you have in your inventory.'
    Write-Host
    Write-Host 'Flush Drugs'
    Write-Host '-----------'
    Write-Host 'This displays the current drugs in your inventory.'
    Write-Host 'Enter the name of the drug you want to flush, and the quantity you want to flush.'
    Write-Host 'You can only flush as much as you have in your inventory.'
    Write-Host 'Flushing drugs is a good way to get rid of evidence and unmarketable drugs, and sometimes leads to a good time.'
    Write-Host
    Write-Host 'Gun Shop'
    Write-Host '--------'
    Write-Host 'This displays a list of guns you can buy.'
    Write-Host 'Buying a gun costs cash, and can help you in a fight.'
    Write-Host 'You can also sell your guns (at a discount, of course).'
    Write-Host 'You can only carry up to two guns at a time.'
    Write-Host 'There are only two gun stores in the game, in random cities.'
    Write-Host
    Write-Host 'Jet to Another City'
    Write-Host '-------------------'
    Write-Host 'This displays a list of cities you can travel to.'
    Write-Host 'Enter the number of the city you want to travel to.'
    Write-Host 'Traveling to another city takes a day, and costs some cash (don''t get stuck!).'
    Write-Host
    Write-Host 'Drug-o-pedia'
    Write-Host '------------'
    Write-Host 'This displays detailed information about the drugs currently active in this game session.'
    Write-Host
    Write-Host 'Quit'
    Write-Host '----'
    Write-Host 'This exits the game.'
    Write-Host
    Write-Host 'Random Events'
    Write-Host '-------------'
    Write-Host 'Random events can occur at any time.'
    Write-Host 'Some are good, some are bad.'
    Write-Host
    PressEnterPrompt
}

# This function displays tag line prompt (for title screen)
function ShowTaglinePrompt {
    param (
        [string]$Text
    )

    function GetTagLineAlternateText {
        $startPromptWords = @(
            'activate',
            'begin',
            'blaze up',
            'do this',
            'fire it up',
            'hit it off',
            'launch',
            'lift off',
            'roll out',
            'spark one up',
            'square off',
            'start',
            'throw down'
        )

        return ('Press Enter to {0}' -f (Get-Random -InputObject $startPromptWords))
    }

    # Define an array of taglines to be used for the text
    $tagLines = @(
        '"My version is better." - John E. Dell',
        'In Drug Wars, it''s not personal; it''s strictly business.',
        'Red pill or Blue pill? Why not both?',
        'To infinity and beyond (the law).',
        'Life is like a box of narcotics; you never know what you''re gonna get.',
        'There''s no crying In Drug Wars!',
        'I see dead people... dealing drugs in Drug Wars.',
        'Frankly, my dear, I don''t give a gram.',
        'We''re gonna need a bigger syndicate.',
        'Keep your friends close and your narcotics closer.',
        'In Drug Wars, the first rule is you do talk about Drug Wars.',
        'I''ll be back... after I conquer the drug trade.',
        'Where every decision could be your last.',
        'The stakes have never been higher. (Get it?)',
        'In the shadows of a city gripped by vice, every move has consequences.',
        'Say hello to my little bag of weed.',
        'I feel the need... the need for speed! And by speed, I mean Amphetamines.',
        'May the force be with you, druggie.',
        'There''s no place like the seedy underbelly of a city.',
        '"Grandma loves it; reminds her of the good ol'' days." - Sarcastic Sally Says',
        '"Pixelated corner store trip. Play hide and seek with the cops!" - StonerGamer420',
        '"High scores as wild as my weekend. Like Mario Kart, but with banana peels." - Captain Cannabis',
        '"Monopoly''s side hustle. Laughed so hard, neighbours thought I was on something!" - ChuckleMaster69',
        '"Five stars for unexpected therapy!" - Johnny Two-eyes',
        '"In-game lawyer pricier than virtual stash. Legal drama with pixels, fewer objections." - The Gamer''s Ass',
        '"Meh" - Most People',
        'Dedicated to the big boss, Janny "Two-Titz". ♥'
    )

    # If no text is supplied, randomly pick a tagline to use as $text
    if ([string]::IsNullOrEmpty($Text)) {
        $Text = Get-Random -InputObject $tagLines
        $useTagLines = $true
    }

    # Define an array of colors to be used for the tag text fade steps
    $colours = @('DarkGray', 'Gray')
    for ($i = 0; $i -lt 20; $i++) {
        $colours += 'White'
    }
    $colours += @('Gray', 'DarkGray')
    for ($i = 0; $i -lt 10; $i++) {
        $colours += 'Black'
    }

    # Store the original cursor position
    $originalCursorPosition = $host.UI.RawUI.CursorPosition

    $alternateText = GetTagLineAlternateText

    $counter = 1

    # Start an infinite loop
    while ($true) {
        # Loop through each color in the colors array
        foreach ($colour in $colours) {
            # Reset the cursor position to the original position
            $host.UI.RawUI.CursorPosition = $originalCursorPosition

            # Write the text to the host with the current color, without a newline at the end
            if ($colour -eq "Black") {
                # If the color is black, clear the line instead.
                Write-Centered (' ' * $Text.Length) -NoNewline
                $host.UI.RawUI.CursorPosition = $originalCursorPosition
            }
            else {
                Write-Centered $Text -ForegroundColor $colour -NoNewline
            }

            # Set the sleep duration based on the current color
            $sleepDuration = 125

            # Pause execution for the specified duration
            Start-Sleep -Milliseconds $sleepDuration

            # Check if a key has been pressed
            if ([System.Console]::KeyAvailable) {
                # Read the key that was pressed
                $key = [System.Console]::ReadKey($true)
                # If the Enter key was pressed, exit the loop
                if ($key.Key -eq "Enter") {
                    Write-Host
                    # Exit the function
                    return
                }
            }
        }

        # Swap the text and the alternate text
        if ($useTagLines) {
            if ($counter % 2 -eq 0) {
                $Text = Get-Random -InputObject $tagLines
            }
            else {
                $Text = GetTagLineAlternateText
            }
            $counter++
        }
        else {
            $temp = $Text
            $Text = $alternateText
            $alternateText = $temp
        }
    }
}

# Function to show the title screen
function ShowTitleScreen {
    $titleBlocks = @(
        @(
            ' (                                                    ____',
            ' )\ )                      (  (                      |   /',
            '(()/(   (      (   (  (    )\))(   ''    )  (         |  /',
            ' /(_))  )(    ))\  )\))(  ((_)()\ )  ( /(  )(   (    | /',
            '(_))_  (()\  /((_)((_))\  _(())\_)() )(_))(()\  )\   |/',
            ' |   \  ((_)(_))(  (()(_) \ \((_)/ /((_)_  ((_)((_) (',
            ' | |) || ''_|| || |/ _` |   \ \/\/ / / _` || ''_|(_-< )\',
            ' |___/ |_|   \_,_|\__, |    \_/\_/  \__,_||_|  /__/((_)',
            '                  |___/'
        ),
        @(
            '________                           __      __                       ._.',
            '\______ \ _______  __ __   ____   /  \    /  \_____  _______  ______| |',
            ' |    |  \\_  __ \|  |  \ / ___\  \   \/\/   /\__  \ \_  __ \/  ___/| |',
            ' |    `   \|  | \/|  |  // /_/  >  \        /  / __ \_|  | \/\___ \  \|',
            '/_______  /|__|   |____/ \___  /    \__/\  /  (____  /|__|  /____  > __',
            '        \/              /_____/          \/        \/            \/  \/'
        ),
        @(
            ' _______  .______       __    __    _______    ____    __    ____  ___      .______           _______. __',
            '|       \ |   _  \     |  |  |  |  /  _____|   \   \  /  \  /   / /   \     |   _  \         /       ||  |',
            '|  .--.  ||  |_)  |    |  |  |  | |  |  __      \   \/    \/   / /  ^  \    |  |_)  |       |   (----`|  |',
            '|  |  |  ||      /     |  |  |  | |  | |_ |      \            / /  /_\  \   |      /         \   \    |  |',
            '|  ''--''  ||  |\  \----.|  `--''  | |  |__| |       \    /\    / /  _____  \  |  |\  \----..----)   |   |__|',
            '|_______/ | _| `._____| \______/   \______|        \__/  \__/ /__/     \__\ | _| `._____||_______/    (__)'
        ),
        @(
            '    ,---,',
            '  .''  .'' `\',
            ',---.''     \   __  ,-.         ,--,',
            '|   |  .`\  |,'' ,''/ /|       ,''_ /|  ,----._,.',
            ':   : |  ''  |''  | |'' |  .--. |  | : /   /  '' /',
            '|   '' ''  ;  :|  |   ,'',''_ /| :  . ||   :     |',
            '    | ;  .  |''  :  /  |  '' | |  . .|   | .\  .',
            '|   | :  |  ''|  | ''   |  | '' |  | |.   ; '';  |',
            '    : | /  ; ;  : |   :  | : ;  ; |''   .   . |',
            '|   | ''` ,/  |  , ;   ''  :  `--''   \`---`-''| |',
            ';   :  .''     ---''    :  ,      .-./.''__/\_: |     ,---,',
            '|   ,.''                `--`----''    |   :    :  ,`--.'' |',
            '---''      .---.                      \   \  /   |   :  :',
            '          /. ./|                      `--`-''    ''   ''  ;',
            '      .--''.  '' ;             __  ,-.            |   |  |',
            '     /__./ \ : |           ,'' ,''/ /|  .--.--.   ''   :  ;',
            ' .--''.  ''   \'' .  ,--.--.  ''  | |'' | /  /    ''  |   |  ',
            '/___/ \ |    '' '' /       \ |  |   ,''|  :  /`./  ''   :  |',
            ';   \  \;      :.--.  .-. |''  :  /  |  :  ;_    ;   |  ;',
            ' \   ;  `      | \__\/: . .|  | ''    \  \    `. `---''. |',
            '  .   \    .\  ; ," .--.; |;  : |     `----.   \ `--..`;',
            '   \   \   '' \ |/  /  ,.  ||  , ;    /  /`--''  /.--,_',
            '    :   ''  |--";  :   .''   \---''    ''--''.     / |    |`.',
            '     \   \ ;   |  ,     .-./          `--''---''  `-- -`, ;',
            '      ''---"     `--`---''                          ''---`"'''
        ),
        @(
            '... ... .         . . ................. ... ......... ............. .........',
            '.......              ......... . . ..... ..........  ......... ..............',
            '.....   i2gBBBBBDJi     .                   .....     ...           .........',
            '...... ZBBBBBBBBBBBBZ:    .7  iSgR5r  .:jY .....  :Bg      .i7J5jvi. ........',
            '.....  dBBB:     .SBBQJ  .dQRBBBBBBBb MBBQ  ...  .BBBr  .dBQBBBBBBBj  .......',
            '.....  iQBQs       rBBBr  BBBBQ.   :: BBBS  .... .QBB: :BBBg.          ......',
            '.....  .BQBj  . .   PQBS  qQBB:       BBBJ  .    1BQQ  LBQB.     JBBBL  .....',
            '...... .BBB1   .    JBBD  rBBB:  ...  BBBg      :BBBi   BBBB:  rBBBBQB   ....',
            '.....  :BBBi       :BBB7   QBQg  .... iQBQQ:. .UBBBL     5BBBBBQBQSQBQ. .....',
            '...... rQBBr:vUbMBBBBBr    XBBQr ...   .ZBBBBBBBBE.  .     rXQDI:  BBBi  ....',
            '.....  iBZguXQBBBBBJ:   .  rZbb:  ....    .irii:    ...           :BBB. .....',
            '......  :              ...       .......           .....         .QBBU  .....',
            '.......     .       ..... .   . ........... . . ....... PQv::::jBQBBv  ......',
            '.... . . ..... . .......     ....................... .  :BBBBBQBBEi    ......',
            '.       ............. .  7J   .     . . ..... .            ..         . .....',
            '.  .sL  ..............  2BB              ..... ..   :ri.      .rJLr:    .....',
            '. vBBB. ...     .....  ZBBd  iuKRQQZXr.    .. .2B7dQBBBBBr iBQBBBBBQBB1. ....',
            '. :BBBi  .       ...  :BBBi  i2BBBBBBBBBu     .BBBBB7 .rK7:BBBs    .vgY   ...',
            '.  ZBBQ    sBQQi  .   SBBE        .:7JBBBB.    QBBB:      .BBBBEggRggEIi.  ..',
            '.. rBBB7  iBQBBB.    rBBB.    .qBBBBQPvPQBB.   XBBR    .    .uDBBBQBMQBBBv  .',
            '.   SBBB. BBBBBBB   iBBB:     BBBs      gBBU   .BBB7  ... .i.         5QBg. .',
            '..   XQBBBBBM:ZBBP JBBQi   .  jBBBv7rr::dBBB.   DBBB. .... sBBBBsr:::KBBBi ..',
            '...   iQBBBQ. .PBQBBBQ:   ...  :bQBQBBBBBBBv    KBBBi ....  .7ZBBQBBBBBL    .',
            '....            .r7r.    .....               .       .....         .       ..',
            '.......     . .       ...........           ....    ......... .         .....'
        ),
        @(
            '                     .',
            '   .__               M     .  .',
            '   |  \._.. . _     dM     |  | _.._. __',
            '   |__/[  (_|(_]    MMr    |/\|(_][  _)',
            '             ._|   4MMML                  .',
            '                   MMMMM.                xf',
            '   .              "MMMMM               .MM-',
            '    Mh..          +MMMMMM            .MMMM',
            '    .MMM.         .MMMMML.          MMMMMh',
            '     )MMMh.        MMMMMM         MMMMMMM',
            '      3MMMMx.     ''MMMMMMf      xnMMMMMM"',
            '      ''*MMMMM      MMMMMM.     nMMMMMMP"',
            '        *MMMMMx    "MMMMM\    .MMMMMMM=',
            '         *MMMMMh   "MMMMM"   JMMMMMMP',
            '           MMMMMM   3MMMM.  dMMMMMM            .',
            '            MMMMMM  "MMMM  .MMMMM(        .nnMP"',
            '=..          *MMMMx  MMM"  dMMMM"    .nnMMMMM*',
            '  "MMn...     ''MMMMr ''MM   MMM"   .nMMMMMMM*"',
            '   "4MMMMnn..   *MMM  MM  MMP"  .dMMMMMMM""',
            '     ^MMMMMMMMx.  *ML "M .M*  .MMMMMM**"',
            '        *PMMMMMMhn. *x > M  .MMMM**""',
            '           ""**MMMMhx/.h/ .=*"',
            '                    .3P"%....',
            '                  nP"     "*MMnx'
        )
    )

    # Change the foreground and background colors to gray and black
    $host.UI.RawUI.ForegroundColor = "Gray"
    $host.UI.RawUI.BackgroundColor = "Black"
    Clear-Host

    # Pick a random title block
    [string[]]$titleBlock = Get-Random -InputObject $titleBlocks

    # Figure out how many characters wide the longest line is.
    $longestLineLength = 0
    $titleBlock | ForEach-Object {
        if ($_.Length -gt $longestLineLength) {
            $longestLineLength = $_.Length
        }
    }

    $blockHeight = $titleBlock.Length

    # Based on the console height and width print the block centered verticalland horizontally
    $consoleWidth = $Host.UI.RawUI.WindowSize.Width
    $consoleHeight = $Host.UI.RawUI.WindowSize.Height

    # Calculate the left padding
    $leftPadding = [math]::Floor(($consoleWidth - $longestLineLength) / 2)

    # Calculate the top padding
    $topPadding = [math]::Floor(($consoleHeight - $blockHeight) / 2)

    # Remove some lines from the padding to make room for tagline
    $topPadding -= 3

    # Ensure top padding is not negative
    $topPadding = [math]::max(0, $topPadding)
    # Add top padding
    1..$topPadding | ForEach-Object { Write-Host }

    # Randomly pick a colour for the block
    $foreColour = Get-Random -InputObject @('DarkBlue', 'DarkGreen', 'DarkRed', 'White', 'DarkMagenta')

    # Print the block
    $titleBlock | ForEach-Object {
        Write-Host (' ' * $leftPadding) $_ -ForegroundColor $foreColour
    }

    # Capture the curent cursor position
    $originalCursorPosition = $host.UI.RawUI.CursorPosition

    # Move the cursor to the bottom left corner of the UI
    $host.UI.RawUI.CursorPosition = New-Object System.Management.Automation.Host.Coordinates 0, ($consoleHeight - 2)
    # Show GameVersion as "v1.00" padded to two decimal places
    Write-Host ('(v{0:0.00})' -f $script:GameVersion) -NoNewline -ForegroundColor DarkGray
    # Move the cursor back to the original position
    $host.UI.RawUI.CursorPosition = $originalCursorPosition

    Write-Host
    Write-Host
    ShowTaglinePrompt
}

# Function to load the high scores from the highscores.json file
function GetHighScores {
    $highScores = @()
    if (Test-Path -Path "highscores.json") {
        $highScores = Get-Content -Path "highscores.json" | ConvertFrom-Json
    }
    else {
        # Create default high score file with 10 made up initals and scores between 1000 and 100000
        $highScores = 1..10 | ForEach-Object {
            [PSCustomObject]@{
                # Generate 3 random uppercase letters for the initals.
                Initials = ('{0}{1}{2}' -f [char](Get-Random -Minimum 65 -Maximum 91), [char](Get-Random -Minimum 65 -Maximum 91), [char](Get-Random -Minimum 65 -Maximum 91))
                # Generate a random number between 1000 and 100000 that is a multiple of 10
                Score    = [int][Math]::Ceiling((Get-Random -Minimum 1000 -Maximum 100001) / 10) * 10
                Date     = (Get-Date).ToString("yyyy-MM-dd")
            }
        }

        # Save them to the json file
        $highScores | ConvertTo-Json | Out-File -FilePath "highscores.json" -Force
    }
    return $highScores | Sort-Object -Property Score -Descending
}

# Check if given score will make it onto the high score list
function IsHighScore {
    param (
        [Parameter(Mandatory = $true)]
        [int]$Score
    )

    $highScores = @(GetHighScores)
    $lowerScore = $highScores | Where-Object { $_.Score -lt $Score } | Select-Object -First 1

    return $null -ne $lowerScore
}

# Function to add a new score to the high scores list
function AddHighScore {
    param (
        [Parameter(Mandatory = $true)]
        [int]$Score,
        [Parameter(Mandatory = $true)]
        [string]$Initials
    )

    $highScores = @(GetHighScores)
    $newScore = [PSCustomObject]@{
        Initials = $Initials
        Score    = $Score
        Date     = (Get-Date).ToString("yyyy-MM-dd")
    }
    $highScores += $newScore

    # Sort the high scores by score, descending, and keep the top 10
    $highScores | Sort-Object -Property Score -Descending | Select-Object -First 10 | ConvertTo-Json | Out-File -FilePath "highscores.json" -Force
}

# Function to advance to the game day
function AdvanceGameDay {
    param (
        [int]$Days = 1,
        [switch]$ChangeOutfit,
        [switch]$SkipPriceUpdate
    )

    # Advance the game day
    $script:Player.GameDay += $Days

    if ($script:Player.GameDay -gt $script:GameDays) {
        return
    }

    Write-Centered ('Welcome to day {0}! ({1} days left)' -f $script:Player.GameDay, ($script:GameDays - $script:Player.GameDay)) -ForegroundColor Yellow

    # If today is a Home Drug Sale day, announce it
    if (IsHomeDrugSaleDay) {
        Write-Host
        Write-Centered ('*** Today is a home drug sale day! ***') -ForegroundColor Green
        Write-Centered ('Cities will be selling their home drugs for CHEAP!') -ForegroundColor DarkGray
        Start-Sleep 3
    }

    # Reset the random event chance for the day.
    $script:RandomEventChance_Current = $script:RandomEventChance_Start

    # Change your clothes
    if ($ChangeOutfit) {
        $clothesChangePhrases = @(
            'Yo, gotta switch up the fit, you know?',
            'Rollin'' with the fashion vibes, gotta keep them threads on point, staying icy for the streets, man.',
            'It''s all about that wardrobe rotation, staying lit and rockin'' those looks that scream realness, keeping it one hunnid, ya feel?',
            '''Cuz you gotta keep them threads fresh, homey.',
            'Time for a style upgrade, switchin'' it up like a boss!',
            'Stepping into a new aesthetic, changing lanes in the fashion game.',
            'Closet remix time, gotta keep the outfit playlist on shuffle!',
            'Switchin'' gears, stayin'' fierce in every wardrobe transition.',
            'Fresh threads alert! Changing the game one outfit at a time.',
            'Wardrobe evolution in progress, level up those fashion stats!',
            'Transforming the look, embracing the fashion chameleon within.',
            'Outfit switch: Engage! It''s like a style mission every day.',
            'Breaking out the fashion artillery, time for a sartorial revolution.',
            'Clothes swap mode: ON. Let the style adventure begin!',
            'Changin'' the attire game, making every outfit a masterpiece.',
            'Adios, old threads! Time for a stylish reincarnation.',
            'Fashion forward, always. Switchin'' up the narrative, one outfit at a time.',
            'Clothes metamorphosis unlocked: Embrace the style transformation!',
            'Upgrade the threads, amplify the vibes. It''s a fashion manifesto!',
            'Clothing alchemy in progress: Turning basics into bold statements.'
        )

        # Change the player's outfit, and capture the new outfit name
        $newOutfit = $script:Player.ChangeOutfit()

        # Lower-case the first character
        $newOutfit = $newOutfit.Substring(0, 1).ToLower() + $newOutfit.Substring(1)
        Write-Host
        Write-Centered ('You change your clothes, putting on your favourite {0}.' -f $newOutfit)
        Write-Centered ('({0})' -f (Get-Random -InputObject $clothesChangePhrases)) -ForegroundColor DarkGray
        Start-Sleep -Milliseconds 750
    }

    if (!$SkipPriceUpdate) {
        # Randomize the drug prices for the day
        SetGameDrugMultipliers
    }
}

# This function sets a random price multiplier for each drug in the game.
function SetGameDrugMultipliers {
    $drugs = $script:GameDrugs
    foreach ($drug in $drugs) {
        $drug.PriceMultiplier = Get-Random -Minimum 0.5 -Maximum 2.6
    }
}

# This function sets the price multiplier for a specified game drug to a specified multipler.
function SetDrugPriceMultiplier {
    param (
        [Parameter(Mandatory = $true)]
        [string[]]$DrugNames,
        [Parameter(Mandatory = $true)]
        [double]$Multiplier
    )

    foreach ($name in $DrugNames) {
        $drug = $script:GameDrugs | Where-Object { $_.Name -eq $name }
        $drug.PriceMultiplier = $Multiplier
    }
}

# Function to simulate a cop encounter
function CopFight {
    #region Function Definitions

    # Function to simulate getting arrested
    function GetArrested {
        param (
            [int]$CopsKilled = 0
        )

        if ($CopsKilled -lt 1) {
            StartRandomEvent -EventName 'Busted'
        }
        else {
            JailForLife
        }
    }

    # Function to simulate getting shot dead by cops
    function GetShotDead {
        $shotDeadStrings = @(
            'The cops shoot you dead!',
            'The pigs spray you with lead!',
            'The cops turn you into a human pinata!',
            'The pigs serve you a hot plate of justice!',
            'The flatfoots send you on a one-way ticket to the afterlife!',
            'The pigs give you a front-row seat to the great beyond!',
            'The flatfoots send you on an express elevator to the afterlife!',
            'The cops give you a golden ticket to paradise!',
            'The flatfoots whisk you away on a magical mystery tour of the great beyond!',
            'The pigs upgrade your ticket to first class on the cosmic express!',
            'The flatfoots give you a VIP pass to the celestial realm!'
        )

        Clear-Host
        ShowHeader
        Write-Host

        Write-BlockLetters 'Blammo!' -BackgroundColor DarkRed -ForegroundColor DarkGray -Align Center -VerticalPadding 1
        Start-Sleep -Seconds 3
        Write-Host
        Write-Centered (Get-Random -InputObject $shotDeadStrings) -ForegroundColor Red
        Start-Sleep -Seconds 2
        Write-Host
        Write-Centered ('You dead.') -ForegroundColor DarkRed
        Write-Host
        PressEnterPrompt
        EndGame
    }

    # Function to calculate the number of cops based on player money and inventory
    function CalculateCops {
        param (
            [Parameter(Mandatory = $true)]
            [int]$PlayerMoney,
            [Parameter(Mandatory = $true)]
            [int]$PlayerInventoryCount
        )
        # For every $5000 in player money, add 1 cop
        $numCopsMoney = [math]::Ceiling($PlayerMoney / 5000)
        # For every 50 items in player inventory, add 1 cop
        $numCopsInventory = [math]::Ceiling($PlayerInventoryCount / 50)

        # Add the two calculated values to get the total number of cops (Min. 1)
        $totalCops = $numCopsMoney + $numCopsInventory
        return [math]::Max($totalCops, 1)
    }

    #endregion Function Definitions

    Clear-Host
    ShowHeader
    Write-Host
    $grawlixes = @(
        '$#@%',
        '#@*&',
        '%$#@',
        '*&%$',
        '@#$%',
        '$@*%',
        'F***'
    )
    $grawlix = Get-Random -InputObject $grawlixes

    $copNames = @(
        'cops',
        'pigs',
        'law',
        'fuzz',
        'po-po'
    )
    $copName = Get-Random -InputObject $copNames

    Write-BlockLetters ('{0}! It''s the {1}!' -f $grawlix, $copName) -BackgroundColor DarkRed -ForegroundColor Blue -Align Center -VerticalPadding 1

    # Calculate the number of cops
    $numCops = CalculateCops -PlayerMoney $script:Player.Cash -PlayerInventoryCount $script:Player.get_DrugCount()

    # Display encounter message
    Write-Host
    if ($numCops -eq 1) {
        Write-Centered ('You encounter 1 cop!') -ForegroundColor Red
    }
    else {
        Write-Centered ('You encounter {0} cops!' -f $numCops) -ForegroundColor Red
        # if there's more than 5 cops, add a little extra drama
        if ($numCops -gt 5 -and $numCops -le 10) {
            Write-Centered ('It''s a whole squad of cops!') -ForegroundColor DarkGray
        }

        # if there's more than 10 cops, add even more drama
        if ($numCops -gt 10) {
            Write-Centered ('It''s a full-blown police raid!') -ForegroundColor DarkGray
        }
    }
    Start-Sleep -Seconds 2
    # Display player weapon level
    Write-Centered  ('Your weapon stopping power: {0}' -f $script:Player.get_StoppingPower())
    Start-Sleep -Milliseconds 500

    # Display options
    Write-Host
    $options = @(
        '1. Attempt to bribe',
        '2. Try to flee',
        '3. Fight'
    )

    # Find the length of the longest string
    $maxLength = ($options | Measure-Object -Property Length -Maximum).Maximum

    $line = '·' + ('=' * $maxLength) + '·'
    Write-Centered $line -ForegroundColor DarkGray

    # Loop through each option, pad it to the maximum length, and print it
    foreach ($option in $options) {
        Write-Centered ($option.PadRight($maxLength)) -ForegroundColor White
    }

    Write-Centered $line -ForegroundColor DarkGray

    # Get player choice
    Write-Host
    Write-Centered 'Choose an option:' -NoNewline
    $validOptions = '1', '2', '3'
    $choice = $null
    while ($choice -notin $validOptions) {
        $key = [System.Console]::ReadKey($true)
        $choice = $key.KeyChar.ToString()
    }
    Write-Host

    OverWriteLastLines -Count 8 -WithClear

    # Calculate the chance of getting shot (10% + 2% per cop)
    $shotChance = 10 + ($numCops * 2)

    # Process player choice
    switch ($choice) {
        1 {
            # Attempt to bribe (costs 20% of player's money or $250, per cop, whichever is higher)
            $bribeAmount = [math]::Max($script:Player.Cash * 0.2, 250) * $numCops

            Write-Host
            # Cops think about it for a moment
            if ($numCops -eq 1) {
                Write-Centered 'The cop considers your offer...' -ForegroundColor Yellow
            }
            else {
                Write-Centered 'The cops consider your offer...' -ForegroundColor Yellow
            }

            Start-Sleep -Seconds 5
            Write-Host
            if ($script:Player.Cash -ge $bribeAmount) {
                Write-Centered ('Bribe successful! You avoid legal consequences. You paid ${0} in bribes.' -f $bribeAmount) -ForegroundColor Green
                $script:Player.Cash -= $bribeAmount
                Start-Sleep -Seconds 2
                Write-Host
                PressEnterPrompt
            }
            else {
                if ($numCops -eq 1) {
                    Write-Centered 'Bribe failed! You don''t have enough money to bribe the cop.' -ForegroundColor DarkRed
                }
                else {
                    Write-Centered 'Bribe failed! You don''t have enough money to bribe all the cops.' -ForegroundColor DarkRed
                }
                Start-Sleep -Seconds 2
                Write-Host
                PressEnterPrompt
                GetArrested
            }
        }
        2 {
            # Try to flee
            $fleeSuccess = [bool](Get-Random -Maximum 2)

            if ($fleeSuccess) {
                Write-Host
                $fleeQuotes = @(
                    'You successfully flee from the police!',
                    'You manage to escape the cops!',
                    'You evade the cops and make a clean getaway!',
                    'You dodge the cops and disappear into the shadows!',
                    'You give the cops the slip and vanish into thin air!',
                    'You outmaneuver the cops and make a daring escape!',
                    'Deke left, deke right... you out!',
                    'You hoof it full bore and leave the cops in the dust!',
                    'Damn! Look at you! You''re like Usain Bolt or some shit.'
                    'Dude, you totally transcended the law! Freedom vibes!',
                    'Far out, man! You''ve slipped the cuffs and danced into the night!',
                    'Whoa, like magic, man! You''ve vanished from the pigs'' radar!',
                    'Groovy maneuvers, dude! You''ve melted into the cosmic ether!',
                    'You''ve become one with the shadows, man! The cops are clueless!',
                    'Incredible, dude! You''ve unlocked the groove and escaped the fuzz!',
                    'You zigged and zagged, man! Now you''re surfing the freedom wave!',
                    'Running like the wind, man! You''re a free spirit, unstoppable!',
                    'Unbelievable speed, man! You''re like a mythical creature or something.'
                )
                Write-Centered (Get-Random -InputObject $fleeQuotes) -ForegroundColor Green
                Start-Sleep -Seconds 2
                Write-Host
                PressEnterPrompt
            }
            else {
                Write-Host
                $fleeFailedQuotes = @(
                    'Flee attempt failed! The cop(s) nab you.',
                    'You need to loose some weight homey, you just got caught.',
                    'Hey noodle legs, you need to work out. They got ya!',
                    'Whoa, man! Looks like the fuzz crashed your party!',
                    'Dude, the cops totally harshed your mellow. Bummer.',
                    'Far out, man! You''re like, busted by the po-po.',
                    'Heavy vibes, bro. The heat''s got you in their trip.',
                    'Hey, spaced-out soul, they''ve got you in their cosmic net.',
                    'Groovy idea, man, but they''ve got you in their buzzkill zone.',
                    'Wipeout, dude! The authorities have totally buzzed your high.',
                    'Dang, you''re caught in their freaky fun-sucking vortex.',
                    'Cosmic fail, dude! You''re snagged in their astral lasso.',
                    'Bummer deal, man! The pigs have crashed your psychedelic party.'
                )
                Write-Centered (Get-Random -InputObject $fleeFailedQuotes) -ForegroundColor DarkRed
                Start-Sleep -Seconds 3
                Write-Host
                PressEnterPrompt
                GetArrested
            }
        }
        3 {
            # Track the cop fight in Game Statistics
            $script:GameStats.CopFights++

            # Pull out yer weapons...
            Write-Host
            $gunCount = $script:Player.get_Guns().Count

            if ($gunCount -gt 0) {
                $gunOutActions = @(
                    'bust',
                    'pop',
                    'pull',
                    'whip',
                    'yank'
                )
                $gunOutAction = Get-Random -InputObject $gunOutActions

                if ($gunCount -gt 1) {
                    $gunName = $script:Player.get_Guns()[0].Name
                    $gunName2 = $script:Player.get_Guns()[1].Name
                    Write-Centered ('You {0} out your {1} and {2} and prepare to fight!' -f $gunOutAction, $gunName, $gunName2) -ForegroundColor Yellow
                }
                else {
                    $gunName = $script:Player.get_Guns()[0].Name
                    Write-Centered ('You {0} out your {1} and prepare to fight!' -f $gunOutAction, $gunName)-ForegroundColor Yellow
                }
            }
            else {
                $fistDrawMessages = @(
                    'You bust out yo'' fists.',
                    'You gear up to throw down.',
                    'You get ready to knuckle up.',
                    'You square up for a brawl.',
                    'You lace up for a fistfight.',
                    'You glove up for a scrap.',
                    'You get your hands ready for a tussle.',
                    'You''re about to throw some punches.',
                    'You''re gearing up to duke it out.',
                    'You''re prepping to throw some knuckles.',
                    'You''re getting set for a bare-knuckle showdown.',
                    'You ''bout to throw down, fists up!',
                    'You gettin'' ready to knuckle up, homie!',
                    'You fixin'' to throw dem hands, gettin'' yo'' game face on!',
                    'You ''bout to bust out them fists, gettin'' in the zone!',
                    'You gearin'' up for a street brawl, fists cocked!',
                    'You ''bout to lay the smackdown, fists clenched!',
                    'You gettin'' set to throw dem bones, ready to rumble!',
                    'You gettin'' your fists primed, ready to throw some heat!',
                    'You preppin'' to duke it out, fists ready to fly!',
                    'You gettin'' your knuckles ready for a throwdown, ain''t holdin'' back!'
                )
                Write-Centered (Get-Random -InputObject $fistDrawMessages) -ForegroundColor Yellow
            }

            Start-Sleep -Seconds 2
            Write-Host

            # Initialize shootout variables
            $copsKilled = 0
            $playerCaught = $false

            # Calculate chance of killing a cop. Kill chance is between 1% and 90%, with +5% for each stopping power.
            $killChance = [math]::Max([math]::Min($script:Player.get_StoppingPower() * 5, 90), 1)

            # Loop until all cops are killed or player is caught or shot
            while ($numCops -gt 0 -and -not $playerCaught) {
                if ($gunCount -gt 0) {
                    $aboutToShootPhrases = @(
                        'Crosshairs aligned, breath held...  Blam!',
                        'One squeeze, one shot...',
                        'Ready, aim, fire!',
                        'The moment of truth...',
                        'With precision honed, the shot rings out...',
                        'You fire off a shot...',
                        'You get a cop in your sights...',
                        'Onomatopoeia'
                    )
                    $randomAboutToShootPhrase = Get-Random -InputObject $aboutToShootPhrases
                    if ($randomAboutToShootPhrase -eq 'Onomatopoeia') {
                        $randomIndex = Get-Random -Minimum 0 -Maximum $script:Player.Guns.Count
                        $randomGun = $script:Player.Guns[$randomIndex]
                        $randomAboutToShootPhrase = $randomGun.Onomatopoeia
                    }

                    Write-Centered $randomAboutToShootPhrase -ForegroundColor White
                }
                else {
                    $punchPhrase = GetRandomPunchPhrase
                    Write-Centered $punchPhrase
                }

                Start-Sleep -Seconds 2

                # Shooting at cops.
                $killedCop = [bool]((Get-Random -Maximum 100) -lt $killChance)

                # If the cop was killed, decrease the cop count
                if ($killedCop) {
                    $numCops--
                    $copsKilled++

                    $copKilledPhrases = @(
                        'You killed a cop!',
                        'You took out a cop!',
                        'You smoked a flatfoot!',
                        'You iced a pig!',
                        'You dropped a cop!',
                        'You capped his ass!',
                        'Yo, you just dropped a badge!',
                        'Coolin'' some of that heat! Nice.',
                        'Cop''s down, respect.',
                        'One less pig on the streets, good job.',
                        'You just made the streets safer, playa.',
                        'RIP, officer. Good work.',
                        'Damn, you smoked a cop!',
                        'You just made a serious statement, son.',
                        'Pig''s out of commission. Well done.',
                        'You handled that blue uniform smooth, like a boss.',
                        'You just rubbed out a flatfoot, see?',
                        'That copper won''t be walking the beat no more, see?',
                        'Yous made the big boss proud by knocking off that cop.',
                        'You just sent that bull on a one-way trip to the morgue.',
                        'That badge ain''t shining no more, thanks to you, see?',
                        'Yous just made the headlines, kid. Cop down!',
                        'You just made your bones with the family, taking out that cop.',
                        'That flatfoot won''t be hassling nobody else, not after you got to him.',
                        'You just earned yourself some serious respect in this town, see?'
                    )
                    $randomCopKilledPhrase = Get-Random -InputObject $copKilledPhrases

                    if ($copsKilled -gt 1) {
                        $replacements = @{
                            'a cop'      = 'another cop'
                            'a flatfoot' = 'another flatfoot'
                            'a pig'      = 'another pig'
                        }

                        foreach ($key in $replacements.Keys) {
                            $randomCopKilledPhrase = $randomCopKilledPhrase.Replace($key, $replacements[$key])
                        }
                    }
                    Write-Centered $randomCopKilledPhrase -ForegroundColor Green

                    # Increase chance of them shooting you in retaliation by 10%, max 90%
                    $shotChance = [math]::Min($shotChance + 10, 90)
                }
                else {
                    $youMissedPhrases = @(
                        'Close, but no cigar!',
                        'Come on, man, you gotta aim better than that!',
                        'Dude, you''re like, totally off target, but keep grooving!',
                        'Far out, that was way off! Channel your inner zen next time.',
                        'Haha, you shootin'' blanks, son!',
                        'Nice try, but you ain''t hitting nothin'' today.',
                        'Nice try, but your aim''s about as good as a broken compass!',
                        'Not even close, homey.',
                        'Not even close, man, but keep spreading those good vibes!',
                        'Swing! And a miss.',
                        'That was so far off, it''s in a different zip code!',
                        'Yo, you aiming with your eyes closed or what?!',
                        'You missed!',
                        'You missed, but hey, the universe still loves you!'
                    )
                    Write-Centered (Get-Random -InputObject $youMissedPhrases) -ForegroundColor Red
                }

                Start-Sleep -Seconds 1
                Write-Centered ('{0} cops remaining.' -f $numCops) -ForegroundColor Blue

                if ($numCops -gt 0) {
                    # Increase chance of them shooting you in retaliation by 2%, max 90%
                    $shotChance = [math]::Min($shotChance + 2, 90)
                    Write-Host

                    $copMovePhrase = @(
                        'The cops make their move...',
                        'The fuzz starts shufflin''...',
                        'The po-po''s rollin'' in on ya...',
                        'The law''s makin'' their play...',
                        'The authorities are throwin'' down...',
                        'The 5-0''s bustin'' a move...',
                        'The heat''s comin'' down...',
                        'The boys in blue are makin'' a move...',
                        'The badges are makin'' their move...',
                        'The law dogs are on the scent...'
                    )
                    Write-Centered (Get-Random -InputObject $copMovePhrase) -ForegroundColor Blue
                    Start-Sleep -Seconds 2
                    # 50% chance of losing the fight right now
                    if ((Get-Random -Maximum 100) -lt 50) {
                        $playerCaught = $true
                    }
                    else {
                        $copsMissedPhrases = @(
                            'The cops miss their shot!',
                            'The pigs'' shot goes wide!',
                            'The law''s aim is off!',
                            'The fuzz missed their mark!',
                            'You dodge the cops'' shot!',
                            'Duck and cover - the cops miss!',
                            'Zing! Just missed you!',
                            'You pull some Matrix-like shit and dodge the shots!'
                        )
                        Write-Centered (Get-Random -InputObject $copsMissedPhrases) -ForegroundColor Green

                        Start-Sleep -Seconds 5
                        OverWriteLastLines -Count 6 -WithClear
                    }
                }
            }

            Write-Host
            if (!$playerCaught) {
                $fightSuccessPhrases = @(
                    'You straight-up owned that scrap, ain''t no legal mess stuck to you.'
                    'You handled your business, no court bothered with you.'
                    'You won the brawl, no cops breathed down your neck.'
                    'You came out on top, no judge messed with you.'
                    'You dominated the fight, no legal drama touched you.'
                    'You took care of business, no courtroom saw your face.'
                    'You smashed it, no law hassled you.'
                    'You crushed it, no legal stuff stuck to you.'
                    'You handled that rumble, no court dealt with you.'
                    'You came out on top, no legal mess stuck to you.'
                    'You handled that scrap, no judge messed with you.'
                    'You handled your business, no legal mess touched you.'
                    'You took care of business, no legal heat came your way.'
                    'You won the showdown, no legal trouble came atcha.'
                    'You came out on top, no legal mess stuck to you.'
                )

                Write-Centered (Get-Random -InputObject $fightSuccessPhrases) -ForegroundColor Green
                Start-Sleep -Seconds 2

                if ($copsKilled -gt 0) {
                    # Get paid by the mob for each cop you killed
                    $bossName = $script:MobBossNames | Get-Random
                    $mobPayment = $copsKilled * 5000
                    $script:Player.Cash += $mobPayment
                    Write-Host
                    if ($copsKilled -eq 1) {
                        Write-Centered ('{0} pays you ${1} for taking out a cop!' -f $bossName, $mobPayment) -ForegroundColor Green
                    }
                    else {
                        Write-Centered ('{0} pays you ${1} for taking out {2} cops!' -f $bossName, $mobPayment, $copsKilled) -ForegroundColor Green
                    }

                    $mobAppreciationPhrases = @(
                        'Thanks, you''re making the family proud.',
                        'Appreciate your loyalty, keep up the good work.',
                        'Solid work, you''re earning your stripes.',
                        'You''re a real stand-up guy, thanks for holding it down.',
                        'Good looks, your efforts don''t go unnoticed.',
                        'Thanks for keeping things running smooth, capisce?',
                        'Much obliged, you''re an asset to the operation.',
                        'You''re an ace in our deck, thanks for your hustle.',
                        'Respect for putting in the work, it''s noticed.',
                        'Thanks, you''re keeping the wheels greased and turning.'
                    )
                    Write-Centered (Get-Random -InputObject $mobAppreciationPhrases) -ForegroundColor DarkGray
                }

                Write-Host
                PressEnterPrompt
            }
            else {
                $copsGotYouPhrases = @(
                    'You lose the fight!',
                    'They got ya, fam!',
                    'The cops take you down!',
                    'Pastafazool! They got you!',
                    'Damn! They got you!'
                )
                Write-Centered (Get-Random -InputObject $copsGotYouPhrases) -ForegroundColor Red
                Start-Sleep -Seconds 2

                Write-Centered 'Uh oh...' -ForegroundColor DarkGray
                Start-Sleep -Seconds 2
                Write-Host
                PressEnterPrompt

                # Calculate the chance of getting shot
                if ((Get-Random -Maximum 100) -lt $shotChance) {
                    GetShotDead
                }
                else {
                    GetArrested -CopsKilled $copsKilled
                }
            }
        }
    }
}

# Function to generate a random punch phrase
function GetRandomPunchPhrase {
    $punchNames = @(
        'backfist',
        'bitch slap',
        'body blow',
        'hammer fist',
        'haymaker',
        'hook',
        'jab',
        'overhand',
        'slap',
        'sucker punch',
        'superman punch',
        'thorat punch',
        'uppercut'
    )

    $punchPhrases = @(
        'You swing your arm like a pro, aiming for greatness with your best PUNCH_NAME...',
        'You unleash your inner boxer, swinging and hoping for the best with your PUNCH_NAME...',
        'You throw caution to the wind and your fist forward, attempting your most spectacular PUNCH_NAME...',
        'You channel your inner Rocky Balboa, swinging for the stars with your best PUNCH_NAME...',
        'You take a wild swing, hoping your PUNCH_NAME hits the mark like a comedic punchline...',
        'You throw your arm into the fray, attempting your PUNCH_NAME with the finesse of a clumsy superhero...',
        'You wind up like a cartoon character and deliver your PUNCH_NAME with all the gusto of a Saturday morning slapstick routine...',
        'You take a swing, aiming for glory with your PUNCH_NAME, like a clumsy knight in a medieval comedy...',
        'You give it your all, swinging your PUNCH_NAME like a dad trying to impress his kids with a wild dance move at a family party...'
    )

    # Select a random punch name and phrase
    $randomPunchName = $punchNames | Get-Random
    $randomPunchPhrase = $punchPhrases | Get-Random

    # Replace "PUNCH_NAME" placeholder with the selected punch name
    $randomPunchPhrase = $randomPunchPhrase -replace 'PUNCH_NAME', $randomPunchName

    return $randomPunchPhrase
}

function ShowGameStatsScreen {
    param (
        [int]$HeightReduction = 1, # Default to 1 line shorter (for prompt)
        [string[]]$Content, # Array of strings to display inside border
        [ConsoleColor]$BorderColor = [ConsoleColor]::DarkGray,
        [ConsoleColor]$ContentColor = [ConsoleColor]::White
    )

    # Get the current console size
    $width = $Host.UI.RawUI.WindowSize.Width
    $height = $Host.UI.RawUI.WindowSize.Height - $HeightReduction

    # Clear the console
    Clear-Host

    # Display the header (as top border)
    ShowHeader

    # Define the side borders for content area
    $sideBorderThin = '|' + (' ' * ($width - 2)) + '|'
    $sideBorderThick = '║' + (' ' * ($width - 2)) + '║'

    # Draw the border for the content area
    Write-Host $sideBorderThin -ForegroundColor $BorderColor
    for ($i = 0; $i -lt ($height - 6); $i++) {
        Write-Host $sideBorderThick -ForegroundColor $BorderColor
    }

    # Draw the bottom border with conditional middle pattern
    if (($width - 4) % 2 -eq 0) {
        # Even width:
        $middle = '-·  ·-'
    }
    else {
        # Odd width:
        $middle = '-· ·-'
    }

    # Calculate the left and right part lengths (without the middle pattern)
    $leftPartLength = [Math]::Floor(($width - 4 - $middle.Length) / 2) + 1
    $rightPartLength = $width - 2 - $leftPartLength - $middle.Length

    # Draw the bottom border
    $bottomBorder = '╚' + ('═' * $leftPartLength) + $middle + ('═' * $rightPartLength) + '╝'
    Write-Host $bottomBorder -ForegroundColor $BorderColor

    # Calculate the starting row for content placement (vertical centering)
    $currentRow = [Math]::Floor(($height - $Content.Length) / 2)

    # Place content at the correct locations (centered horizontally)
    foreach ($line in $Content) {
        $lineLength = $line.Length
        $padding = [Math]::Floor(($width - 2 - $lineLength) / 2)

        # Move cursor to the correct position and write the line
        $Host.UI.RawUI.CursorPosition = New-Object System.Management.Automation.Host.Coordinates($padding, $currentRow)
        Write-Host $line -ForegroundColor $ContentColor -NoNewline

        # Move to the next row
        $currentRow++
    }

    # Set the cursor position to the line below the bottom border
    $Host.UI.RawUI.CursorPosition = New-Object System.Management.Automation.Host.Coordinates(0, $height)

    PressEnterPrompt
}
##############################
#endregion Function Definitions
################################

#################
# Main Entry Point
###################

# Set default error action
$ErrorActionPreference = 'Stop'

# Confirm that the console window is large enough to display the game.
if (!$SkipConsoleSizeCheck) {
    CheckConsoleSize
}

# Commence playing!
$script:Playing = $true

while ($script:Playing) {
    # Show title screen
    ShowTitleScreen

    # Initialize game state.
    InitGame

    # Main game loop.
    while (!$script:GameOver) {

        # Update MostCashAtOnce stats by comparing player's current cash
        $script:GameStats.UpdateMostCashAtOnce($script:Player.Cash)

        # Show main menu and get user choice
        $choice = ShowMainMenu
        switch ($choice) {
            "B" {
                ShowBuyDrugsMenu
            }
            "D" {
                ShowDrugopedia
            }
            "F" {
                ShowFlushDrugsMenu
            }
            "J" {
                Jet
            }
            "Q" {
                QuitGame
            }
            "S" {
                ShowSellDrugsMenu
            }
            "T" {
                ShowGameStatsScreen -Content $script:GameStats.GetPropertiesAsStrings()
            }
            "?" {
                ShowHelp
            }
            "!" {
                $secondKey = [Console]::ReadKey($true).KeyChar.ToString()
                if ($secondKey -eq ")") {
                    StartRandomEvent -EventName (Read-Host -Prompt 'Enter event name')
                }
            }
            "G" {
                if ($script:Player.City.HasGunShop) {
                    ShowGunshopMenu
                }
                else {
                    Write-Host
                    Write-Centered 'Invalid choice'
                    Start-Sleep -Milliseconds 500
                }
            }
            default {
                Write-Host
                Write-Centered 'Invalid choice'
                Start-Sleep -Milliseconds 500
            }
        }

        # User is quitting, or the game is over, break out of the loop.
        if ((!$script:Playing) -or $script:GameOver) {
            break
        }

        # Random events have an X% chance of happening each day.
        if ((Get-Random -Maximum 100) -lt $script:RandomEventChance_Current) {
            StartRandomEvent

            # Each time one random event fires off, the chance of getting another that day is halved.
            $script:RandomEventChance_Current = [math]::Floor($script:RandomEventChance_Current / 2)

            # If the chance is less than 1% set it to 0.
            if ($script:RandomEventChance_Current -lt 1) {
                $script:RandomEventChance_Current = 0
            }
        }

        # No cash and no drugs, game over
        if ($script:Player.Cash -le 0 -and $script:Player.Drugs.Count -eq 0) {
            Clear-Host
            ShowHeader
            Write-Host
            Write-Centered 'You''re broke and you have no drugs left.' -ForegroundColor DarkRed
            Start-Sleep -Seconds 3
            Write-Centered 'You''re not really cut out for this business.' -ForegroundColor DarkGray
            Start-Sleep -Seconds 4
            Write-Host
            Write-BlockLetters 'Game over.' -ForegroundColor Black -BackgroundColor DarkRed -VerticalPadding 1 -Align Center
            Write-Host
            PressEnterPrompt
            EndGame
        }

        # Out of days, game over.
        if ($script:Player.GameDay -gt $script:GameDays) {
            ShowGameOverCuzDays -GameDay $script:GameDays
        }
    }
}