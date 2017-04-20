Import-Module HipChatAdmin

Describe "Get-HipchatUser" {

    Context "When the API call is sent" {

        BeforeAll {

            $Users = Get-HipchatUser -ApiToken $ApiToken
        }

        It "Should return PSObjects" {
            $Users[0] | Should BeOfType PSCustomObject
        }

        It "Should contain a property with the user's name" {
            $Users[0].Name | Should Not BeNullOrEmpty
        }

        It  "Should contain a property with the user's mention name" {
            $Users[0].MentionName | Should Not BeNullOrEmpty
        }

    }
}