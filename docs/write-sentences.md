The 'write-sentences.ps1' Script
========================

write-sentences.ps1 


Parameters
----------
```powershell


[<CommonParameters>]
    This script supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, 
    WarningVariable, OutBuffer, PipelineVariable, and OutVariable.
```

Script Content
--------------
```powershell
<#
.SYNOPSIS
	← enter a brief description of the script here
.DESCRIPTION
	← enter a detailed description of the script here
.PARAMETER
	← enter the description of a parameter here (optional, repeat the .PARAMETER for each parameter)
.EXAMPLE
	← enter a sample command that uses the script, optionally followed by sample output and a description (repeat the .EXAMPLE for each example)
.NOTES
	Author:        ← enter full name here
	License:       ← enter license here
.LINK
	https://       ← enter the URL to additional information here
#>

    "Afrikaans: Die vinnige bruin jakkals spring oor die luiaard hond."
    "Albanian: Dhelpra e shpejtë ngjyrë kafe kërcej mbi qenin dembel."
    "Amharic: ፈጣን ቡናማ ቀበሮ በሰነፉ እንቁላል ላይ ይዘልላል።"
    "Arabic: الثعلب البني السريع يقفز فوق الكلب الكسول."
    "Armenian: Արագ դարչնագույն աղվեսը անցնում է ծուլ շունի վրայով։"
    "Assamese: দ্ৰুত বাদামী ৰঙৰ শিয়ালটো অলস কুকুৰটোৰ ওপৰেৰে জঁপিয়ায়।"
    "Azerbaijani: Sürətli qəhvəyi tilki tənbəl itin üstündən atlar."
    "Basque: Azkarreko azeri marroia zaldi gainetik igarotzen da."
    "Belarusian: Хуткі карычневы ліс спрыгвае праз лянівага сабаку."
    "Bengali: দ্রুত বাদামী শিয়ালটি অলস কুকুরটির উপর দিয়ে লাফ দেয়।"
    "Bosnian: Brza smeđa lisica skače preko lijenog psa."
    "Bulgarian: Бързата кафява лисица скача през мързеливото куче."
    "Catalan: La guineu ràpida i marró salta sobre el gos mandrós."
    "Cebuano: Ang paspas nga brown nga fox molukso ibabaw sa tapulan nga iro."
    "Chinese (Simplified): 快速的棕色狐狸跳过懒狗。"
    "Chinese (Traditional): 快速的棕色狐狸跳過懶狗。"
    "Croatian: Brza smeđa lisica preskače preko lijenog psa."
    "Czech: Rychlá hnědá liška přeskakuje přes líného psa."
    "Danish: Den hurtige brune ræv hopper over den dovne hund."
    "Dhivehi: މައްސަލަ ބަރަންފައިކު މިންވަރު ކުޅުނު މީހުން އުޅެލެވޭނެ."
    "Dogri: ਤੇਜ਼ ਭੂਰਾ ਫ਼ੌਕਸ ਸੁਸਤ ਕੁੱਤੇ ਦੇ ਉੱਤੇ ਛਲਾਂਗ ਲਾਉਂਦਾ ਹੈ।"
    "Dutch: De snelle bruine vos springt over de luie hond."
    "English: The quick brown fox jumps over the lazy dog."
    "Estonian: Kiire pruun rebane hüppab üle laisa koera."
    "Filipino: Ang mabilis na kayumangging soro ay tumalon sa ibabaw ng tamad na aso."
    "Finnish: Nopea ruskea kettu hyppää laiskan koiran yli."
    "French: Le renard brun rapide saute par-dessus le chien paresseux."
    "Galician: A rápida raposa marrón salta por riba do can preguiceiro."
    "Georgian: სწრაფი ყავისფერი მგელი ხტება ზარმაც ძაღლზე."
    "German: Der schnelle braune Fuchs springt über den faulen Hund."
    "Greek: Η γρήγορη καφετιά αλεπού πηδάει πάνω από τον τεμπέλη σκύλο."
    "Gujarati: ઝડપી તપકીરો શિયાળ આળસુ કૂતરા પર કૂદે છે."
    "Hausa: Jakin nan mai saurin launin ruwan kasa ya tsallake karen da ba shi da aiki."
    "Hebrew: השועל החום המהיר קופץ מעל הכלב העצלן."
    "Hindi: तेज भूरी लोमड़ी आलसी कुत्ते के ऊपर से कूद जाती है।"
    "Hungarian: A gyors barna róka átugrik a lusta kutyán."
    "Icelandic: Hraði brúni refurinn hoppar yfir letidýrið hundinn."
    "Igbo: A nkịta aja aja ngwa ngwa na-agbapụ n'elu nkịta ala."
    "Indonesian: Rubah coklat yang cepat melompati anjing yang malas."
    "Irish: Léimíonn an sionnach donn tapaidh thar an madra leisciúil."
    "Italian: La volpe marrone rapida salta sopra il cane pigro."
    "Japanese: 素早い茶色の狐が怠け者の犬を飛び越える。"
    "Javanese: Rubah coklat sing cepet loncat ngluwari asu sing males."
    "Kannada: ತ್ವರಿತ ಕಂದು ನರಿ ಸೋಮಾರಿ ನಾಯಿಯ ಮೇಲೆ ಹಾರುತ್ತದೆ."
    "Kazakh: Жылдам қоңыр түлкі еріншек иттің үстінен секіреді."
    "Khmer: កណ្តុរលឿងរហ័សលោតលើឆ្កែអណ្ដែតអណ្ដែត។"
    "Kinyarwanda: Injangwe yihuta y'umukara isimbuka imbwa y'umunebwe."
    "Konkani: मळगी तोंड्यो वळख उडता आस्लेल्या कुत्र्याचेर."
    "Korean: 빠른 갈색 여우가 게으른 개를 뛰어넘습니다."
    "Kurdish (Kurmanji): Rojek çav reş têze dixwe ser sega belengaz."
    "Kurdish (Sorani): رۆژەکی خێرا قاوەیی دەپەڕێتە سەر سەگێکی بە تاڵ."
    "Kyrgyz: Тез күрөң түлкү эринчек иттин үстүнөн секирет."
    "Lao: ສັດຟ້ອກສີຟ້າດ່ານດີ້ນກາຍຫາມາດວາດ."
    "Latvian: Ātrs brūns lapsa pārlekt slinko suni."
    "Lingala: Mbwako ya mbala-mbala azali kopumbwa likoló lya mbwa ya koyina."
    "Lithuanian: Greita ruda lapė peršoka per tingų šunį."
    "Luganda: Embwa enkalu enzirugavu ekkaatirako embwa emenya."
    "Macedonian: Брзата кафеава лисица прескокнува преку мрзливото куче."
    "Malagasy: Ny amboahaolo mainty haingana mitsambikina manodidina ny alika kamo."
    "Malay: Rubah perang yang cepat melompati anjing yang malas."
    "Malayalam: ക്ഷിപ്രമായ തവിട്ട് നിറമുള്ള കുറുക്കൻ അലസമായ നായയെ ചാടി കടന്നു."
    "Maltese: Il-volpi kannella mgħaġġel jaqbeż fuq il-kelb għażżien."
    "Marathi: चपळ तपकिरी ससा आळशी कुत्र्यावर उडी मारतो."
    "Mongolian: Хурдан бор хүрэн үнэг алжаалтай нохойн дээгүүр алгасдаг."
    "Myanmar (Burmese): အမြန်ဆုံး ညိုနောက်ခြောက် ဝက်ဝံက ပျော်နေတဲ့ ခွေးကို ခုန်လွှားသည်။"
    "Nepali: चट्पटे भूरा स्यालले आलसी कुकुरमाथि छलाङ गर्दछ।"
    "Norwegian: Den raske brune reven hopper over den late hunden."
    "Odia (Oriya): ଦ୍ରୁତ ବାଦାମୀ ଲୋମଶ ଶିଆଳ ଅଳସ କୁକୁର ଉପରେ ଲାଫି ଯାଉଛି।"
    "Oromo: Harreen saffisaa fardaan gurraacha saree gogsuudhaan ol dabarfata."
    "Pashto: د زرغون لوچک وریځ د خوبیدو سپی باندې وازی."
    "Persian: روباه قهوه‌ای سریع بر فراز سگ تنبل می‌پرد."
    "Polish: Szybki brązowy lis przeskakuje leniwego psa."
    "Portuguese: A rápida raposa marrom pula sobre o cão preguiçoso."
    "Punjabi: ਤੇਜ਼ ਭੂਰੀ ਲੋਮੜੀ ਸੁਸਤ ਕੁੱਤੇ ਉੱਤੇ ਛਾਲ ਮਾਰਦੀ ਹੈ।"
    "Romanian: Vulpea rapidă maro sare peste câinele leneș."
    "Russian: Быстрая коричневая лиса перепрыгивает через ленивую собаку."
    "Samoan: O le 'oti vave enaena o lo'o oso i luga o le maile leaga."
    "Sepedi: Phokojwe e bohale e tlola godimo ga ntša e botšehali."
    "Serbian: Брза смеђа лисица прескаче лењег пса."
    "Shona: Shumba yakasviba inokasira kusvetuka pamusoro pebwa rinovenga."
    "Sindhi: ڇپڻ ٻڙھيو رند ٿو ريتل بيلي کان ٻاهر ڦڙي ٿو."
    "Sinhala: වේගයෙන් පැහැදිලි රන් නරියා හිනාවෙන සුනඛයා හරහා පැන යයි."
    "Slovak: Rýchla hnedá líška skáče cezivého psa."
    "Slovenian: Hitra rjava lisica skače čez lenega psa."
    "Somali: Dacawo dhaqso leh oo bunni ah ayaa ka boodaysa eey caajis ah."
    "Spanish: El rápido zorro marrón salta sobre el perro perezoso."
    "Sundanese: Rubah coklat nu gancang luncat ngaliwatan anjing bosen."
    "Swahili: Mbweha wa kahawia mwepesi anaruka juu ya mbwa mvivu."
    "Swedish: Den snabba bruna räven hoppar över den late hunden."
    "Tajik: Тез сурх рӯбоҳ аз рӯи саги танбал мепарид."
    "Tamil: விரைவான பழுப்பு நிற நரி சோம்பேறியான நாய் மீது குதிக்கிறது."
    "Tatar: Тиз көрән төлке буеңгы ит өстен атлый."
    "Telugu: వేగవంతమైన గోధుమ రంగు నక్క బద్దకస్తులైన కుక్కపైన దూకుతుంది."
    "Thai: จิ้งจอกสีน้ำตาลที่ว่องไวกระโดดข้ามหมาเกียจคร้าน."
    "Tigrinya: ፈጣን ብኩራይ ቀበሮ በኣታዊ ዓራዊ እንቁላል ይዘልማል።"
    "Turkish: Hızlı kahverengi tilki tembel köpeğin üzerinden atlar."
    "Turkmen: Çalt gara çal tilki ýaltan itiň üstünden böker."
    "Ukrainian: Швидка коричнева лисиця стрибає через ледачого собаку."
    "Urdu: تیز بھوری لومڑی سست کتے کے اوپر سے کود جاتی ہے۔"
    "Uzbek: Tez jigarrang tulki dangasa itning ustidan sakraydi."
    "Vietnamese: Con cáo nhanh màu nâu nhảy qua con chó lười."
    "Welsh: Y llwynog brown cyflym yn neidio dros y ci diog."
    "Xhosa: Ibhokhwe ensundu ekhawulezayo itsiba phezu kwenja evila."
    "Yiddish: דער גיכער ברוינער פוקס שפּרינגט איבער דעם פוילן הונט."
    "Yoruba: Aja aláwọ̀ dúdú yára náà fo lórí ajá aláìnílórí."
    "Zulu: Impisi ensundu esheshayo igxuma phezu kwenja evila."
```

*(page generated by convert-ps2md.ps1 as of 07/15/2026 09:44:06)*
