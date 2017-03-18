Import-Module PSHipChat

Describe "Send-HipchatMessage" {

    Context "When the API call is sent" {

        It "Should return a 204 Status Code" {
            Send-HipchatMessage 'Running Pester Unit Test...' -RoomName $RoomName -Notify $false -ApiToken $ApiToken | 
            Should Be '204'
        }
    }

}