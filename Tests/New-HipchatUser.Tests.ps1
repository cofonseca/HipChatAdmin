Import-Module PHipChatAdmin

Describe "New-HipchatUser" {
    InModuleScope PHipChatAdmin {
        
        Context "When the API call is sent" {
            
            It 'Attempts to invoke web api' {
                Mock Invoke-WebRequest -MockWith {
                    $request = @{'id' = '123456';
                                'Content' = 'someContent';
                                'Status' = 'someStatus';
                                'StatusCode' = '201'
                                }
                    return $request
                }
                $global:result = New-HipchatUser -FirstName 'Pester' -LastName 'Test' -ApiToken $ApiToken
            }
            
            It 'Should be mocked' {
                $MockParams = @{
                    CommandName = 'Invoke-WebRequest'
                    Times = 1
                    Exactly = $true
                }
                Assert-MockCalled @MockParams
            }
            
            It "Should return a 201 Status Code" {
                $result.StatusCode.ToString() | Should Be '201'
            }
        }

    }
    
}
