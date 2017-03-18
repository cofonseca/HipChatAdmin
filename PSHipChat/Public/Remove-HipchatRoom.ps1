#requires -version 5

<#
.SYNOPSIS
	Removes an existing HipChat room and kicks all users.
.DESCRIPTION
	Removes an existing HipChat room using HipChat's API. If there are any 
    users in the room, they will automatically be removed from the room.
.PARAMETER Name
	Required: The name of the room. The name must be entered exactly as it 
    appears on HipChat.
.PARAMETER ApiToken
	Required: Your HipChat API Token. You can obtain an API Token from the
	HipChat website by navigating to Account Settings > API Access.
.NOTES
	Version:        1.0
	Author:         Corey Fonseca
	Creation Date:  3/17/17
	Purpose/Change: Full Functionality
.EXAMPLE
	Remove-HipchatRoom 'Development' -ApiToken 'REXsCauSe553gsoIJg1Gj4zwNsSAwS'
	Removes the HipChat room called 'Development' and kicks all users.

#>
function Remove-HipchatRoom{

    [CmdletBinding()]
	Param(
		[Parameter(Mandatory=$true,ValueFromPipeline=$true,HelpMessage="Enter the room name",Position=0)][string]$Name,
		[Parameter(Mandatory=$true,ValueFromPipeline=$true,HelpMessage="Enter your API Token")][Alias('ApiKey')][string]$ApiToken
    )

	BEGIN {

		$Uri = "https://api.hipchat.com/v2/room/"+$Name+"?auth_token="+$ApiToken

	}

    PROCESS {

		# Data to be sent to HipChat API #
		$Body = @{
			room_id_or_name = $Name
		}
	
		Write-Verbose "Sending $Body to HipChat API"

		# Send API Request #
		$Call = (
			Invoke-WebRequest `
				-Uri $Uri `
				-Method DELETE `
				-ContentType "application/json" `
				-Body (ConvertTo-Json $Body)
		)

	}

	END {

		# Check response status code #
		if ($Call.StatusCode -eq '204') {
			Write-Verbose "Room Deleted Successfully!"
			Write-Output $Call.StatusCode
		} else {
			Write-Error "Room Deletion Failed!"
		}

    }
    
}