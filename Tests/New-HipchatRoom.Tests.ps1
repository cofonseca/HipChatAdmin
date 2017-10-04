Import-Module HipChatAdmin

Describe "New-HipchatRoom" {

    Context "When the API call is sent" {

        It "Should return a 201 Status Code" {
            New-HipchatRoom -Name 'PesterTest' -Private -ApiToken $ApiToken | 
            Should Be '201'
        }
    }

    AfterAll {
        Remove-HipchatRoom -Name 'PesterTest'
    }
}