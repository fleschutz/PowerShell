# Cherry-picks a commit ID from main branch to all the other branches
$CommitID = "1234"
$CommitMessage = "Update rules for .gitignore file (cherry-picked from main branch)"
$RepoDir  = "D:\Repos\ufa"
$Branches = "attower_bugfix_14.43.x", "attower_bugfix_14.42.x", "attower_bugfix_14.41.x", "attower_bugfix_14.40.x", "attower_bugfix_14.39.x", "attower_bugfix_14.38.x", "attower_bugfix_14.37.x", "attower_bugfix_14.36.x", "attower_bugfix_14.35.x", "attower_bugfix_14.34.x", "attower_bugfix_14.33.x", "attower_bugfix_14.32.x", "attower_bugfix_14.31.x", "attower_bugfix_14.30.x", "attower_bugfix_14.29.x", "attower_bugfix_14.27.x", "attower_bugfix_14.26.x", "attower_bugfix_14.25.x", "attower_bugfix_14.24.x", "attower_bugfix_14.23.x", "attower_bugfix_14.22.x", "attower_bugfix_14.21.x", "attower_bugfix_14.20.x", "attower_bugfix_14.19.x", "attower_bugfix_14.18.x", "attower_bugfix_14.17.x", "attower_bugfix_14.16.x", "attower_bugfix_14.15.x", "attower_bugfix_14.13.x", "attower_bugfix_14.11.x", "attower_bugfix_14.10.x", "attower_bugfix_14.9.x", "attower_bugfix_14.8.x", "attower_bugfix_14.6.x", "attower_bugfix_14.5.x", "attower_bugfix_14.4.x"

try {
    set-location "$RepoDir"

    foreach($Branch in $Branches) {

        "STEP: Switching to branch $Branch (git checkout)..."
        & git checkout --recurse-submodules --force $Branch
        if ($lastExitCode -ne "0") { throw "'git checkout' failed" }

        "STEP: Updating submodules (git submodule update)..."
        & git submodule update --init --recursive
        if ($lastExitCode -ne "0") { throw "'git submodule update' failed" }

        "STEP: Cleaning the repository (git clean -fdx)..."
        & git clean -fdx
        if ($lastExitCode -ne "0") { throw "'git clean -fdx' failed" }
		
		& git submodule foreach --recursive git clean -fdx
		if ($lastExitCode -ne "0") { throw "'git clean -fdx' in submodules failed" }

        "STEP: Pulling latest updates (git pull)..."
        & git pull --recurse-submodules 
        if ($lastExitCode -ne "0") { throw "'git pull' failed" }

        "STEP: Checking the status (git status)..."
        $Result = (git status)
        if ($lastExitCode -ne "0") { throw "'git status' failed" }
        if ("$Result" -notmatch "nothing to commit, working tree clean") { throw "Branch is NOT clean: $Result" }

        & git cherry-pick --no-commit "$CommitID"
        if ($lastExitCode -ne "0") { throw "'git cherry-pick $CommitID' failed" }

        & git commit -m "$CommitMessage"
        if ($lastExitCode -ne "0") { throw "'git commit' failed" }

        & git push
        if ($lastExitCode -ne "0") { throw "'git push' failed" }
    }

    "DONE."
    exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}