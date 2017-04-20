Import-Module HipChatAdmin

Describe "Remove-HipchatUser" {

    BeforeAll {
        New-HipchatUser -FirstName 'Pester' -LastName 'Test' -ApiToken $ApiToken
    }

    Context "When the API call is sent" {

        It "Should return a 204 Status Code" {
            Remove-HipchatUser -MentionName 'PesterTest' -ApiToken $ApiToken | 
            Should Be '204'
        }
    }
}