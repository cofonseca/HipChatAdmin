#requires -version 5
<#
.SYNOPSIS
  Formats a first or last name.
.DESCRIPTION
  This function will properly format a first or last name by ensuring that the 
  first letter is a capital letter, and the other letters are lowercase. This 
  function will strip out any spaces or special characters.
.PARAMETER Name
  The first or last name to be formatted.
.NOTES
  Version:        1.0
  Author:         Corey Fonseca
  Creation Date:  3/16/17
  Purpose/Change: Initial script development
.EXAMPLE
  Format-CasedName -Name 'john'
  Formats 'john' into 'John'
.EXAMPLE
  Format-CasedName 'smith'
  Formats 'smith' into 'Smith'
.EXAMPLE
  Format-CasedName 'jo$ hn'
  Formats 'jo$ hn' into 'John'
#>
function Format-CasedName{
    [CmdletBinding()]Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true,Position=0)][string]$Name
    )

    PROCESS {

        $RegEx = '[^a-zA-Z]'
        $Name = $Name -Replace $RegEx, ''
        $Name = $Name.Substring(0,1).toupper()+$Name.Substring(1).tolower()
        
    }

    END {

        Write-Output $Name

    }

}