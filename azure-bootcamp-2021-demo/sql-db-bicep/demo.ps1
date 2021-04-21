Login-AzAccount

New-AzResourceGroup `
    -Name templateSpecs `
    -Location 'West Europe' `
    -Force


New-AzDeployment `
    -Name sql `
    -Location "West Europe" `
    -TemplateFile .\main.bicep `
    -TemplateParameterFile .\parameters.json `
    -Verbose `
    -WhatIf

New-AzDeployment `
    -Name sql `
    -Location "West Europe" `
    -TemplateFile .\main.bicep `
    -TemplateParameterFile .\parameters.json `
    -Verbose



# Publish and deploy template spec
bicep build .\main.bicep

New-AzTemplateSpec `
    -ResourceGroupName templateSpecs `
    -Name sql-bicep `
    -Version 1.0.0 `
    -Location 'West Europe' `
    -TemplateFile .\main.json `
    -Force `
    -OutVariable sqlTemplateSpec

New-AzDeployment `
    -Name sql-bicep `
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



