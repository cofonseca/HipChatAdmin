#requires -version 5

<#
.SYNOPSIS
	Sends a message to a HipChat room.
.DESCRIPTION
	Sends a message to a HipChat room. The message will always display as the 
    user whom the API Token belongs to. If this will be used by an application 
    or automated script, a dedicated user and API Token should be created.
.PARAMETER Message
	Required: The contents of the message.
.PARAMETER RoomName
    Required: The name of the room where the message will be sent.
.PARAMETER From
	Optional: The user or application who will be shown as the sender of the 
	message. This will be displayed next to the sender's name, and does not 
	override the sender's actual name.
.PARAMETER Color
	Optional: The background color of the message. Defaults to gray.
.PARAMETER Notify
	Optional: Whether or not HipChat should notify users of your message.
    Defaults to false.
.PARAMETER ApiToken
	Required: Your HipChat API Token. You can obtain an API Token from the
	HipChat website by navigating to Account Settings > API Access.
.NOTES
	Version:        1.0
	Author:         Corey Fonseca
	Creation Date:  3/17/17
	Purpose/Change: Full Functionality
.EXAMPLE
	Send-HipchatMessage 'Deployment Failed!' -From 'Jenkins' -Color 'Red' -Notify -ApiToken 'REXsCauSe553gsoIJg1Gj4zwNsSAwS'
	Sends a message from Jenkins with a red background that will notify all users in the room.
.EXAMPLE
	Send-HipchatMessage 'Testing 123' -Color 'Green' -ApiToken 'REXsCauSe553gsoIJg1Gj4zwNsSAwS'
	Sends a message with a green background that will not send a notification.

#>
function Send-HipchatMessage{

    [CmdletBinding()]
	Param(
		[Parameter(Mandatory=$true,ValueFromPipeline=$true,HelpMessage="Enter the message contents",Position=0)][string]$Message,
        [Parameter(Mandatory=$true,ValueFromPipeline=$true,HelpMessage="Enter the room name",Position=0)][string]$RoomName,
    	[Parameter(ValueFromPipeline=$true,HelpMessage="Enter the name or title of the sender")][Alias('MentionName')][string]$From,
		[Parameter()][string]$Color,
		[Parameter(Mandatory=$true,HelpMessage="Notify users?")][boolean]$Notify,
    	[Parameter(Mandatory=$true,ValueFromPipeline=$true,HelpMessage="Enter your API Token")][Alias('ApiKey')][string]$ApiToken
    )

    BEGIN {

        if (-Not ($Color)) {
            $Color = 'gray'
        }

		if (-Not ($From)) {
			$From = ''
		}

		$Uri = "https://api.hipchat.com/v2/room/"+$RoomName+"/notification?auth_token="+$ApiToken
    }

    PROCESS {

		# Data to be sent to HipChat API #
		$Body = @{
			room_id_or_name = $RoomName;
			color = $Color;
            from = $From;
			message = $Message;
            notify = $Notify
		}
	
		Write-Verbose "Sending $Body to HipChat API"

		# Send API Request #
		$Call = (
			Invoke-WebRequest `
				-Uri $Uri `
				-Method POST `
				-ContentType "application/json" `
				-Body (ConvertTo-Json $Body)
		)
        # Check response status code #
		if ($Call.StatusCode -eq '204') {
			Write-Verbose "Message Successfully Sent!"
			$OutputObject = New-Object -TypeName PSObject
			$OutputObject | Add-Member -MemberType 'NoteProperty' -Name 'Name' -Value $name
			$OutputObject | Add-Member -MemberType 'NoteProperty' -Name 'StatusCode' -Value $Call.StatusCode
			Write-Output $OutputObject
		} else {
			Write-Error "Message Failed to Send!"
		}

	}

	END {

    }
    
}