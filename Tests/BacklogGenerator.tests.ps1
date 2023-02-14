Describe 'BacklogGenerator' {
    BeforeAll {
        # Define the GitHub personal access token, owner name, repository name, and project ID for testing
        $Token = 'your_github_token_here'
        $Owner = 'your_github_owner_here'
        $RepoName = 'your_github_repo_here'
        $ProjectId = 12345

        # Define example input JSON data for testing
        $json = @"
        {
            "epic": "Title of Epic",
            "user_stories": [
                {
                    "user_story": "As a [user persona], I want to [perform some action] so that [achieve some goal].",
                    "acceptance_criteria": [
                        "Criterion 1",
                        "Criterion 2",
                        "Criterion 3"
                    ],
                    "outcome": "Desired outcome or impact of the user story"
                }
            ]
        }
"@
    }

    It 'Can create a milestone for an epic' {
        # Invoke the New-Backlog function to create a milestone
        $result = New-Backlog -Token $Token -Owner $Owner -RepoName $RepoName -ProjectId $ProjectId -InputObject $json

        # Assert that the milestone was created successfully
        $milestoneUrl = "https://api.github.com/repos/$Owner/$RepoName/milestones"
        $headers = @{
            Authorization = "token $Token"
            Accept = "application/vnd.github.v3+json"
        }
        $response = Invoke-RestMethod -Uri $milestoneUrl -Headers $headers
        $milestoneNames = $response.title
        $milestoneName = $json | ConvertFrom-Json | Select-Object -ExpandProperty epic
        $milestoneNames | Should Contain $milestoneName
    }

    It 'Can create an issue for a user story' {
        # Invoke the New-Backlog function to create an issue
        $result = New-Backlog -Token $Token -Owner $Owner -RepoName $RepoName -ProjectId $ProjectId -InputObject $json

        # Assert that the issue was created successfully
        $issueUrl = "https://api.github.com/repos/$Owner/$RepoName/issues"
        $headers = @{
            Authorization = "token $Token"
            Accept = "application/vnd.github.v3+json"
        }
        $response = Invoke-RestMethod -Uri $issueUrl -Headers $headers
        $issueTitles = $response.title
        $issueTitle = $json | ConvertFrom-Json | Select-Object -ExpandProperty user_stories | Select-Object -ExpandProperty user_story
        $issueTitles | Should Contain $issueTitle
    }
}
