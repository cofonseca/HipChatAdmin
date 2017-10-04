#requires -version 5

<#
.SYNOPSIS
	Creates a new HipChat user account.
.DESCRIPTION
	Creates a new HipChat user account using HipChat's API. The mention name is
	the user's first name and last name by default, but a custom mention name 
	can be provided.
.PARAMETER FirstName
	Required: The user's first name.
.PARAMETER LastName
	Required: The user's last name.
.PARAMETER EmailAddress
	Required: The user's e-mail address.
.PARAMETER ApiToken
	Required: Your HipChat API Token. You can obtain an API Token from the
	HipChat website by navigating to Account Settings > API Access.
.PARAMETER MentionName
	Optional: The mention name (@MentionName) that should be used, if different
	from the default first name last name format.
.NOTES
	Version:        1.0
	Author:         Corey Fonseca
	Creation Date:  3/17/17
	Purpose/Change: Full Functionality
.EXAMPLE
	New-HipchatUser -FirstName 'John' -LastName 'Smith' -EmailAddress 'jsmith@example.com' -ApiToken 'REXsCauSe553gsoIJg1Gj4zwNsSAwS'
	Creates an account for John Smith, with a mention name of @JohnSmith.
.EXAMPLE
	New-HipchatUser 'John' 'Smith' -EmailAddress 'jsmith@example.com' '-MentionName 'Jay.Smith' -ApiToken 'REXsCauSe553gsoIJg1Gj4zwNsSAwS'
	Creates an account for John Smith with a custom mention name of @jay.smith.

#>
function New-HipchatUser{

    [CmdletBinding()]
	Param(
		[Parameter(Mandatory=$true,ValueFromPipeline=$true,HelpMessage="Enter the user's first name",Position=0)][Alias('GivenName')][string]$FirstName,
    	[Parameter(Mandatory=$true,ValueFromPipeline=$true,HelpMessage="Enter the user's last name",Position=1)][Alias('SirName')][string]$LastName,
		[Parameter(Mandatory=$true,ValueFromPipeline=$true,HelpMessage="Enter the user's e-mail address")][Alias('Email')][string]$EmailAddress,
		[Parameter(Mandatory=$true,ValueFromPipeline=$true,HelpMessage="Enter your API Token")][Alias('ApiKey')][string]$ApiToken,
    	[Parameter(ValueFromPipeline=$true)][string]$MentionName
    )

    BEGIN {

		# Capitalize first and last name for proper formatting. #
		$FirstName = FormatCasedName $FirstName
		$LastName = FormatCasedName $LastName

		# If no MentionName was specified, create one from the user's first and last name. #
		if (-Not ($MentionName)) {
			$MentionName = ($FirstName+$LastName)
		}
    }

    PROCESS {

		# Data to be sent to HipChat API #
		$Body = @{
			name = "$FirstName $LastName";
			mention_name = $MentionName;
			email = $EmailAddress
		}
	
		Write-Verbose "Sending $Body to HipChat API"

		# Send API Request #
		try {
			$Call = (
				Invoke-WebRequest `
					-Uri "https://api.hipchat.com/v2/user?auth_token=$ApiToken" `
					-Method POST `
					-ContentType "application/json" `
					-Body (ConvertTo-Json $Body)
			)
		}
		catch {
			Write-Output "Caught an exception:"
			Write-Output "Exception Type: $($_.Exception.GetType().FullName)"
			Write-Output "Exception Message: $($_.Exception.Message)"
			Exit 1
		}
		# Check response status code #
		if ($Call.StatusCode -eq '201') {
			Write-Verbose "User Created Successfully!"
			$OutputObject = New-Object -TypeName PSObject
			$OutputObject | Add-Member -MemberType 'NoteProperty' -Name 'MentionName' -Value $MentionName
            $OutputObject | Add-Member -MemberType 'NoteProperty' -Name 'FirstName' -Value $FirstName
            $OutputObject | Add-Member -MemberType 'NoteProperty' -Name 'LastName' -Value $LastName
			$OutputObject | Add-Member -MemberType 'NoteProperty' -Name 'StatusCode' -Value $Call.StatusCode
			Write-Output $OutputObject
		} else {
			Write-Error "User Creation Failed!"
		}

	}

	END {

    }
    
}
