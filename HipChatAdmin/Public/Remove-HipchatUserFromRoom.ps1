#requires -version 5

<#
.SYNOPSIS
	Removes a HipChat user from a HipChat room.
.DESCRIPTION
	Removes an existing HipChat user from an existing HipChat room.
.PARAMETER MentionName
	Required: The user's mention name (@name). Accepts an array of strings.
.PARAMETER RoomName
	Required: The name of the room.
.PARAMETER ApiToken
	Required: Your HipChat API Token. You can obtain an API Token from the
	HipChat website by navigating to Account Settings > API Access.
.NOTES
	Version:        1.0
	Author:         Corey Fonseca
	Creation Date:  5/4/17
	Purpose/Change: Full Functionality
.EXAMPLE
	Remove-HipchatUserFromRoom -MentionName 'JohnSmith' -RoomName 'Development' -ApiToken 'REXsCauSe553gsoIJg1Gj4zwNsSAwS'
	Removes @JohnSmith from the Development room.
	Remove-HipchatUserFromRoom -MentionName 'JohnSmith','JaneDoe','AlPennyworth' -RoomName 'Development' -ApiToken 'REXsCauSe553gsoIJg1Gj4zwNsSAwS'
	Removes @JohnSmith, @JaneDoe, and @AlPennyworth from the Development room.

#>
function Remove-HipchatUserFromRoom{

    [CmdletBinding()]
	Param(
		[Parameter(Mandatory=$true,ValueFromPipeline=$true,HelpMessage="Enter the user's mention name (@name)")][Alias('UserName')][string[]]$MentionName,
    	[Parameter(Mandatory=$true,ValueFromPipeline=$true,HelpMessage="Enter the room name")][string]$RoomName,
		[Parameter(Mandatory=$true,ValueFromPipeline=$true,HelpMessage="Enter your API Token")][Alias('ApiKey')][string]$ApiToken
    )

    BEGIN {}

    PROCESS {

		Foreach ($Name in $MentionName) {
			$Uri = "https://api.hipchat.com/v2/room/"+$RoomName+"/member/@"+$Name+"?auth_token="+$ApiToken
			# Send API Request #
			$Call = (
				Invoke-WebRequest `
					-Uri $Uri `
					-Method DELETE `
					-ContentType "application/json"
			)
			
			# Check response status code #
			if ($Call.StatusCode -eq '204') {
				Write-Verbose "User Removed Successfully!"
				$OutputObject = New-Object -TypeName PSObject
			    $OutputObject | Add-Member -MemberType 'NoteProperty' -Name 'Name' -Value $name
			    $OutputObject | Add-Member -MemberType 'NoteProperty' `-Name 'StatusCode' -Value $Call.StatusCode
			    Write-Output $OutputObject
			} else {
				Write-Error "Failed to add user!"
			}
		}

	}

	END {}
    
}
