Import-Module PSHipChat

Describe "New-HipchatRoom" {

    Context "When the API call is sent" {

        It "Should return a 201 Status Code" {
            New-HipchatRoom -Name 'PesterTest' -Private | 
            Should Be '201'
        }
    }

    AfterAll {
        Remove-HipchatRoom -Name 'PesterTest'
    }
}