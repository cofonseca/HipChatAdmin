Get-Module HipChatAdmin | Remove-Module -Force
Import-Module $PSScriptRoot\..\HipChatAdmin\HipChatAdmin.psm1

Describe "New-HipchatUser" {
    InModuleScope HipChatAdmin {
        
        Context "When the API call is sent" {
            
            It 'Attempts to invoke web api' {
                Mock Invoke-WebRequest -MockWith {
                    $returned = @{'id' = '123456';
                                'Content' = 'someContent';
                                'Status' = 'someStatus';
                                'StatusCode' = '201'
                                }
                    return $returned
                }
                $global:result = New-HipchatUser -FirstName 'Pester' -LastName 'Test' -EmailAddress 'test@nomatter.com' -ApiToken 'REXsCauSe553gsoIJg1Gj4zwNsSAwS'
                Assert-MockCalled -CommandName 'Invoke-WebRequest' -Times 1 -Scope It
            }
            
            It 'StatusCode field exists and not null' {
                $result.StatusCode.ToString() | Should Not Be $null
            }
            
            It "Should return a 201 Status Code" {
                $result.StatusCode.ToString() | Should Be '201'
            }
        }

    }
    
}
