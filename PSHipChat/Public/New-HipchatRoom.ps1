#requires -version 5

<#
.SYNOPSIS
	Creates a new HipChat room.
.DESCRIPTION
	Creates a new HipChat room using HipChat's API. The room can be
.PARAMETER Name
	Required: The name of the room.
.PARAMETER Private
	Optional: Rooms are made public by default, allowing all users within the 
    organization to view them. Specifying -Private will make the room private.
.PARAMETER ApiToken
	Required: Your HipChat API Token. You can obtain an API Token from the
	HipChat website by navigating to Account Settings > API Access.
.NOTES
	Version:        1.0
	Author:         Corey Fonseca
	Creation Date:  3/17/17
	Purpose/Change: Full Functionality
.EXAMPLE
	New-HipchatRoom -Name 'Development' -ApiToken 'REXsCauSe553gsoIJg1Gj4zwNsSAwS'
	Creates a HipChat room called 'Development' that is publicly accessible to 
    anyone in your organization.
.EXAMPLE
	New-HipchatRoom -Name 'Finance' -Private -ApiToken 'REXsCauSe553gsoIJg1Gj4zwNsSAwS'
	Creates a private HipChat room called 'Finance' that is invite-only.

#>
function New-HipchatRoom{

    [CmdletBinding()]
	Param(
		[Parameter(Mandatory=$true,ValueFromPipeline=$true,HelpMessage="Enter the room name",Position=0)][string]$Name,
    	[Parameter()][switch]$Private,
		[Parameter(Mandatory=$true,ValueFromPipeline=$true,HelpMessage="Enter your API Token")][Alias('ApiKey')][string]$ApiToken
    )

    BEGIN {

		# Set Privacy #
		if ($Private -eq $true) {
			$Privacy = 'private'
		} else {
            $Privacy = 'public'
        }
    }

    PROCESS {

		# Data to be sent to HipChat API #
		$Body = @{
			name = $Name;
			privacy = $Privacy
		}
	
		Write-Verbose "Sending $Body to HipChat API"

		# Send API Request #
		$Call = (
			Invoke-WebRequest `
				-Uri "https://api.hipchat.com/v2/room?auth_token=$ApiToken" `
				-Method POST `
				-ContentType "application/json" `
				-Body (ConvertTo-Json $Body)
		)

	}

	END {

		# Check response status code #
		if ($Call.StatusCode -eq '201') {
			Write-Verbose "Room Created Successfully!"
			Write-Output $Call.StatusCode
		} else {
			Write-Error "Room Creation Failed!"
		}

    }
    
}