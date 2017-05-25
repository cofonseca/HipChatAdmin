$ScriptAnalyzerRules = @(
		'PSAlignAssignmentStatement',
		'PSAvoidUsingCmdletAliases',
		'PSAvoidDefaultValueSwitchParameter',
		'PSAvoidDefaultValueForMandatoryParameter',
		'PSAvoidUsingEmptyCatchBlock',
		'PSAvoidGlobalAliases',
		'PSAvoidGlobalFunctions',
		'PSAvoidGlobalVars',
		'PSAvoidNullOrEmptyHelpMessageAttribute',
		'PSReservedCmdletChar',
		'PSReservedParams',
		'PSAvoidUsingUserNameAndPassWordParams',
		'PSAvoidUsingComputerNameHardcoded',
		'PSAvoidUsingConvertToSecureStringWithPlainText',
		'PSAvoidUsingPlainTextForPassword',
		'PSAvoidUsingWMICmdlet',
		'PSAvoidUsingWriteHost',
		'PSMisleadingBacktick',
		'PSMissingModuleManifestField',
		'PSPlaceCloseBrace',
		'PSPlaceOpenBrace',
		'PSProvideCommentHelp',
		'PSUseApprovedVerbs',
		'PSUseBOMForUnicodeEncodedFile',
		'PSUseCmdletCorrectly',
		'PSUseConsistentIndentation',
		'PSUseConsistentWhitespace',
		'PSUseDeclaredVarsMoreThanAssignments',
		'PSUseOutputTypeCorrectly',
		'PSUseSingularNouns',
		'PSUseToExportFieldsInManifest'
	)

$ProjectRoot = Resolve-Path "$PSScriptRoot\.."

Describe "General Build Validation" {

    $Scripts = Get-ChildItem $ProjectRoot -Include *.ps1,*.psm1,*.psd1 -Recurse

    foreach ($Script in $Scripts) { 

        Context "$Script" {    

            It "Should parse as valid PowerShell" {

                $FileContent = Get-Content -Path $Script.fullname -ErrorAction Stop
                $Errors = $null
                $null = [System.Management.Automation.PSParser]::Tokenize($FileContent, [ref]$Errors)
                $Errors.Count | Should Be 0

            }
        }

		Context "$Script" {

			foreach ($Rule in $ScriptAnalyzerRules) {

				It "Should Not Return Any Violations for Rule: $Rule" {

					Invoke-ScriptAnalyzer -IncludeRule $Rule -Path $Script | Should BeNullOrEmpty

				}

			}

		}
		
	}

}

