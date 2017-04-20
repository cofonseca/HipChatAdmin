Import-Module PHipChatAdmin

Describe "New-HipchatUser" {

    Context "When the API call is sent" {

        It "Should return a 201 Status Code" {
            New-HipchatUser -FirstName 'Pester' -LastName 'Test' -ApiToken $ApiToken | 
            Should Be '201'
        }
    }

    AfterAll {
        Remove-HipchatUser -MentionName 'PesterTest'
    }
}