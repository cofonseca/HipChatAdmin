Import-Module PSHipChat

Describe "Add-HipchatUserToRoom" {

	BeforeAll {
		Add-HipchatUser -FirstName 'Pester' -LastName 'Test' -EmailAddress 'PesterTest@example.com' -ApiToken $ApiToken
		New-HipchatRoom -RoomName 'PesterTest' -Private
	}

    Context "When the API call is sent" {

        It "Should return a 204 Status Code" {
            Add-HipchatUserToRoom -MentionName 'PesterTest' -RoomName 'PesterTest' -ApiToken $ApiToken | 
            Should Be '204'
        }
    }

    AfterAll {
        Remove-HipchatUser -MentionName 'PesterTest'
        Remove-HipchatRoom -Name 'PesterTest'
    }
}