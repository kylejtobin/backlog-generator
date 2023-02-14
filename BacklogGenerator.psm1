function New-Backlog {
    param (
        [string] $Token,
        [string] $Owner,
        [string] $RepoName,
        [int] $ProjectId
    )

    # Authenticate to GitHub API
    $headers = @{
        Authorization = "token $Token"
        Accept = "application/vnd.github.v3+json"
    }

    # Get JSON data from standard input
    $json = [System.Console]::In.ReadToEnd()

    # Convert JSON to PowerShell objects
    $data = ConvertFrom-Json $json

    # Create a milestone for the epic
    $milestoneName = $data.epic
    $milestoneParams = @{
        milestone_title = $milestoneName
    }
    $milestoneUrl = "https://api.github.com/repos/$Owner/$RepoName/milestones"
    Invoke-RestMethod -Uri $milestoneUrl -Method Post -Headers $headers -Body (ConvertTo-Json $milestoneParams)

    # Loop through each user story in the data
    foreach ($userStory in $data.user_stories) {

        # Create an issue for the user story
        $issueTitle = $userStory.user_story
        $issueParams = @{
            title = $issueTitle
            milestone = $milestoneName
            project_id = $ProjectId
        }
        $issueUrl = "https://api.github.com/repos/$Owner/$RepoName/issues"
        Invoke-RestMethod -Uri $issueUrl -Method Post -Headers $headers -Body (ConvertTo-Json $issueParams)
    }
}
