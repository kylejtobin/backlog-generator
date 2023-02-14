$Token = "your_github_token_here"
$Owner = "your_github_owner_here"
$RepoName = "your_github_repo_here"
$ProjectId = 12345
$json = Get-Content -Raw input.json | ConvertFrom-Json
New-Backlog -Token $Token -Owner $Owner -RepoName $RepoName -ProjectId $ProjectId -InputObject $json