#requires -version 5

<#
.SYNOPSIS
	Removes an existing HipChat user account.
.DESCRIPTION
	Removes an existing HipChat user account using HipChat's API. This cmdlet 
    accepts the e-mail address or mention name (@ name) of the user.
.PARAMETER MentionName
	Required: The user's mention name (@ name).
.PARAMETER EmailAddress
	Required: The user's e-mail address.
.PARAMETER ApiToken
    Required: Your HipChat API Token. You can obtain an API Token from the
	HipChat website by navigating to Account Settings > API Access.
.NOTES
	Version:        1.0
	Author:         Corey Fonseca
	Creation Date:  3/17/17
	Purpose/Change: Full Functionality
.EXAMPLE
	Remove-HipchatUser -MentionName 'JohnSmith' -ApiToken 'REXsCauSe553gsoIJg1Gj4zwNsSAwS'
	Removes the user account associated with the mention name '@JohnSmith'.
.EXAMPLE
	Remove-HipchatUser -EmailAddress 'jsmith@example.com' -ApiToken 'REXsCauSe553gsoIJg1Gj4zwNsSAwS'
	Removes the user account associated with 'jsmith@example.com'.

#>
function Remove-HipchatUser{

    [CmdletBinding()]
	Param(
      [Parameter(ValueFromPipeline=$true)][string]$MentionName,
      [Parameter(ValueFromPipeline=$true)][string]$EmailAddress,
      [Parameter(Mandatory=$true,ValueFromPipeline=$true,HelpMessage="Enter your API Token")][Alias('ApiKey')][string]$ApiToken
    )

    BEGIN {

      if ($MentionName) {
          $Key = "@$MentionName"
          Write-Verbose "The mention name $MentionName has been specified."
      } elseif ($EmailAddress) {
          $Key = $EmailAddress
          Write-Verbose "The e-mail address $EmailAddress has been specified."
      } else {
          Write-Error "No inputs have been provided."
      }

    $Uri = "https://api.hipchat.com/v2/user/"+$Key+"?auth_token=$ApiToken"

    }

    PROCESS {
  
        Write-Verbose "Sending $Key to HipChat API at $Uri"

        # Remove user via HipChat API #
        $Call = (
            Invoke-WebRequest `
                -Uri $Uri `
                -Method DELETE `
                -ContentType "application/json"
        )

        # Check response status code #
        if ($Call.StatusCode -eq '204') {
            Write-Verbose "Response: $Response Success!"
            $OutputObject = New-Object -TypeName PSObject
			$OutputObject | Add-Member -MemberType 'NoteProperty' -Name 'Name' -Value $name
			$OutputObject | Add-Member -MemberType 'NoteProperty' -Name 'StatusCode' -Value $Call.StatusCode
			Write-Output $OutputObject
        } else {
            Write-Error "Response: $Response Failed!"
        }

    }
    
}