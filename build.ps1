param ($Task = 'Default')

# Grab nuget bits, install modules, set build variables, start build.
Get-PackageProvider -Name NuGet -ForceBootstrap | Out-Null

Invoke-Pester .\Tests\Build.Tests.ps1
. .\Tests\Build.Tests.ps1 -Finalize
#Invoke-psake -buildFile $ENV:BHProjectPath\psake.ps1 -taskList $Task -nologo
#exit ( [int]( -not $psake.build_success ) )