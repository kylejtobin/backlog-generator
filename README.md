# Backlog Generator

The Backlog Generator is a PowerShell module that allows you to create GitHub issues and milestones based on input JSON data from ChatGPT. This is useful for quickly generating a backlog of issues and milestones for a new project or feature.

## Usage

To use the Backlog Generator, you'll need to pipe input JSON data into the `New-Backlog` function. The JSON data should contain an "epic" field and an array of "user_stories" fields. Each "user_story" field should contain a "user_story" field, an "acceptance_criteria" field, and an "outcome" field. Here's an example of what the input JSON data might look like:

```{
    "epic": "Online Ordering System",
    "user_stories": [
        {
            "user_story": "As a customer, I want to be able to browse menu items so that I can choose what to order.",
            "acceptance_criteria": [
                "The menu should be presented in a clear and easy-to-read format.",
                "The user should be able to filter and search for menu items based on various criteria.",
                "The user should be able to click on a menu item to see more information, such as a description, price, and ingredients."
            ],
            "outcome": "Customers are able to quickly and easily find the menu items they want to order."
        },
        {
            "user_story": "As a customer, I want to be able to add items to my cart so that I can place an order.",
            "acceptance_criteria": [
                "The user should be able to add an item to their cart by clicking a button or link.",
                "The user should be able to adjust the quantity of the item in their cart.",
                "The user should be able to remove an item from their cart.",
                "The user should be able to see a summary of their order, including the total price and any applicable taxes or fees."
            ],
            "outcome": "Customers are able to easily build and customize their orders before placing them."
        }
    ]
}
```

To use this input data with the `New-Backlog` function, you would save the JSON data to a file (e.g. `input.json`) and then run the following command:
```
$Token = "your_github_token_here"
$Owner = "your_github_owner_here"
$RepoName = "your_github_repo_here"
$ProjectId = 12345
$json = Get-Content -Raw input.json | ConvertFrom-Json
New-Backlog -Token $Token -Owner $Owner -RepoName $RepoName -ProjectId $ProjectId -InputObject $json
```

This will create a milestone with the name "Online Ordering System" and two issues, one for each user story.

## Contributing

Pull requests are welcome! If you have any suggestions or bug reports, please submit an issue on the [GitHub repository](https://github.com/your_username/your_repo).

## License

This project is licensed under the [GNU General Public License v3.0](https://www.gnu.org/licenses/gpl-3.0.en.html). See the LICENSE file for details.
