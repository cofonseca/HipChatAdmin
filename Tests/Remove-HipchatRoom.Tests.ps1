Import-Module PSHipChat

Describe "Remove-HipchatRoom" {

    BeforeAll {
        New-HipchatRoom -Name 'PesterTest' -Private
        Start-Sleep 2
    }

    Context "When the API call is sent" {

        It "Should return a 204 Status Code" {
            Remove-HipchatRoom -Name 'PesterTest' | 
            Should Be '204'
        }
    }
}