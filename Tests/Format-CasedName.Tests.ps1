Import-Module PSHipChat

Describe "Format-CasedName" {
    
    Context "When a name is provided" {

        It "Should remove numbers, spaces, and special characters from the name" {
            Format-CasedName 'pe$ ste3r' | 
            Should Be 'pester'
        }

        It "Should properly capitalize the first letter of the name" {
            Format-CasedName 'pester' | 
            Should BeExactly 'Pester'
        }

    }

}