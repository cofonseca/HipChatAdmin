Import-Module PSHipChat

Describe "Remove-HipchatUser" {

    BeforeAll {
        New-HipchatUser -FirstName 'Pester' -LastName 'Test'
        Start-Sleep 2
    }

    Context "When the API call is sent" {

        It "Should return a 204 Status Code" {
            Remove-HipchatUser -MentionName 'PesterTest' | 
            Should Be '204'
        }
    }
}