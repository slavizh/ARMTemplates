Login-AzAccount

New-AzResourceGroup `
    -Name templateSpecs `
    -Location 'West Europe' `
    -Force

New-AzTemplateSpec `
    -ResourceGroupName templateSpecs `
    -Name sql `
    -Version 1.0.0 `
    -Location 'West Europe' `
    -TemplateFile .\azuredeploy.json `
    -Force `
    -OutVariable sqlTemplateSpec `
    | Select-Object -Property Name, ResourceGroupName, Location, Versions, CreationTime, LastModifiedTime

New-AzDeployment `
    -Name sql `
    -Location 'West Europe' `
    -TemplateSpecId $sqlTemplateSpec.Versions[0].Id `
    -TemplateParameterFile .\parameters.json `
    -WhatIf

New-AzDeployment `
    -Name sql `
    -Location 'West Europe' `
    -TemplateSpecId $sqlTemplateSpec.Versions[0].Id `
    -TemplateParameterFile .\parameters.json `
    -Verbose
