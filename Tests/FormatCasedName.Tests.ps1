Import-Module PSHipChat

Describe "FormatCasedName" {
    
    Context "When a name is provided" {

        It "Should remove numbers, spaces, and special characters from the name" {
            FormatCasedName 'pe$ ste3r' | 
            Should Be 'pester'
        }

        It "Should properly capitalize the first letter of the name" {
            FormatCasedName 'pester' | 
            Should BeExactly 'Pester'
        }

    }

}