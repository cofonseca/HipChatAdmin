Import-Module HipChatAdmin

Describe "New-HipchatRoom" {

    Context "When the API call is sent" {

        Mock Invoke-WebRequest { 
            [pscustomobject]@{
                StatusCode = 201
                } 
        }  

        It "Should return a 201 Status Code" {
            New-HipchatRoom -Name 'PesterTest' -Private -ApiToken $ApiToken | 
            Should Be '201'
        }

        It 'Should use Invoke-WebRequest only 1 time' {
            Assert-MockCalled Invoke-WebRequest -Times 1 -Exactly
            }
    }

    AfterAll {
        Remove-HipchatRoom -Name 'PesterTest'
    }
}