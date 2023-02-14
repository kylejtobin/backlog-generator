@{
    RootModule = 'BacklogGenerator.psm1'
    ModuleVersion = '1.0.0'
    GUID = '12a34567-8901-2345-6789-012345678901'
    Author = 'Your Name Here'
    Description = 'A PowerShell module for generating GitHub issues and milestones based on input JSON data'
    FunctionsToExport = 'New-Backlog'
    PrivateData = @{
        PSData = @{
            # Store any private data, such as secrets or credentials
        }
    }
    RequiredModules = @()
    ReleaseNotes = @'
1.0.0 - Initial release
'@
}
