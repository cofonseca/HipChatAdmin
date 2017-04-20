Import-Module HipChatAdmin

Describe "Remove-HipchatRoom" {

    BeforeAll {
        New-HipchatRoom -Name 'PesterTest' -Private -ApiToken $ApiToken
        Start-Sleep 2
    }

    Context "When the API call is sent" {

        It "Should return a 204 Status Code" {
            Remove-HipchatRoom -Name 'PesterTest' -ApiToken $ApiToken | 
            Should Be '204'
        }
    }
}