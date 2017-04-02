#requires -version 5

<#
.SYNOPSIS
	Returns a list of all HipChat users.
.DESCRIPTION
	Returns a list of all existing HipChat user accounts.
.PARAMETER ApiToken
	Required: Your HipChat API Token. You can obtain an API Token from the
	HipChat website by navigating to Account Settings > API Access.
.NOTES
	Version:        1.0
	Author:         Corey Fonseca
	Creation Date:  3/15/17
	Purpose/Change: Added object output.
.EXAMPLE
	Get-HipchatUser -ApiToken 'REXsCauSe553gsoIJg1Gj4zwNsSAwS'
	Returns a list of all HipChat users' names and mention names.

#>
function Get-HipchatUser{

    [CmdletBinding()]
    param(
		[Parameter(Mandatory=$true,ValueFromPipeline=$true,HelpMessage="Enter your API Token")][Alias('ApiKey')][string]$ApiToken
	)

	BEGIN {

		$Uri = "https://api.hipchat.com/v2/user?auth_token="+$ApiToken
    }

    PROCESS {

		# Make API Call #
		$Call = (
			Invoke-WebRequest `
				-Uri $Uri `
				-Method GET `
				-ContentType "application/json"
		)

		# Check response status code #
		if ($Call.StatusCode -eq '200') {

			# Convert data and select what we need #
            $Users = (ConvertFrom-Json $Call.Content).Items

			# Remove unused variables to save memory #
			Remove-Variable -Name Call
			
			# Create an object for each user #
			foreach ($User in $Users) {
				$UserObject = New-Object -TypeName PSObject
				$UserObject | Add-Member `
					-MemberType 'NoteProperty' `
					-Name 'Name' `
					-Value $User.name
				$UserObject | Add-Member `
					-MemberType 'NoteProperty' `
					-Name 'MentionName' `
					-Value $User.mention_name
				Write-Output $UserObject
			}

		} else {
			Write-Error "Failed to retreive users from HipChat servers."
		}

    }
    
}