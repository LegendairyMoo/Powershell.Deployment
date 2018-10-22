﻿function Install-All {
    param(     
        [Parameter(Mandatory = $true)]
        [string]
        $rootPath,     
        [Parameter(Mandatory = $true)]
        [string]
        $environmentConfigurationFilePath,
        [Parameter(Mandatory = $true)]
        [string]
        $productConfigurationFilePath
    )

    $webAdministrationAvailable = Get-Module WebAdministration -ListAvailable
    $serviceBusAvailable = Test-Path "$rootPath\Deployment\PowershellModules\Tools\Microsoft.ServiceBus.dll"
    $configuration = Get-Configuration $environmentConfigurationFilePath $productConfigurationFilePath

    Install-FilePermissions $rootPath $configuration
    Install-Certificates $rootPath $configuration

    if ($serviceBusAvailable) {
        Install-ServiceBuses $rootPath $configuration
    }

    if ($webAdministrationAvailable) {
        UninstallIfExistAndInstall-Websites $rootPath $configuration
    }
    Install-Services $rootPath $configuration
    Install-PrtgMonitors $rootPath $configuration
}


function Stop-All {
    param( 
        [Parameter(Mandatory = $true)]
        [string]
        $rootPath,             
        [Parameter(Mandatory = $true)]
        [string]
        $environmentConfigurationFilePath,
        [Parameter(Mandatory = $true)]
        [string]
        $productConfigurationFilePath
    )

    $webAdministrationAvailable = Get-Module WebAdministration -ListAvailable
    $serviceBusAvailable = Test-Path "$rootPath\Deployment\PowershellModules\Tools\Microsoft.ServiceBus.dll"
    $configuration = Get-Configuration $environmentConfigurationFilePath $productConfigurationFilePath

    if ($webAdministrationAvailable)
    {
       Stop-Websites $configuration
    }
    Stop-Services $rootPath $configuration

    if ($serviceBusAvailable) {
        Stop-ServiceBuses $rootPath $configuration
    }

    Stop-PrtgMonitors $rootPath $configuration
}

function Start-All {
    param(    
        [Parameter(Mandatory = $true)]
        [string]
        $rootPath,          
        [Parameter(Mandatory = $true)]
        [string]
        $environmentConfigurationFilePath,
        [Parameter(Mandatory = $true)]
        [string]
        $productConfigurationFilePath
    )

    $webAdministrationAvailable = Get-Module WebAdministration -ListAvailable
    $serviceBusAvailable = Test-Path "$rootPath\Deployment\PowershellModules\Tools\Microsoft.ServiceBus.dll"
    $configuration = Get-Configuration $environmentConfigurationFilePath $productConfigurationFilePath

    if ($webAdministrationAvailable)
    {
       Start-Websites $configuration
    }
    Start-Services $rootPath $configuration

    if ($serviceBusAvailable) {
        Start-ServiceBuses $rootPath $configuration
    }

    Start-PrtgMonitors $rootPath $configuration
}


function Uninstall-All {
    param( 
        [Parameter(Mandatory = $true)]
        [string]
        $rootPath,         
        [Parameter(Mandatory = $true)]
        [string]
        $environmentConfigurationFilePath,
        [Parameter(Mandatory = $true)]
        [string]
        $productConfigurationFilePath
    )

    $webAdministrationAvailable = Get-Module WebAdministration -ListAvailable
    $serviceBusAvailable = Test-Path "$rootPath\Deployment\PowershellModules\Tools\Microsoft.ServiceBus.dll"
    $configuration = Get-Configuration $environmentConfigurationFilePath $productConfigurationFilePath

    if ($webAdministrationAvailable)
    {
       Uninstall-Websites $rootPath $configuration
    }
    Uninstall-Services $rootPath $configuration

    if ($serviceBusAvailable) {
        Uninstall-ServiceBuses $rootPath $configuration
    }

    Uninstall-Certificates $rootPath $configuration
    Uninstall-FilePermissions $rootPath $configuration
    Uninstall-PrtgMonitors $rootPath $configuration
}

function Get-Metadata {
    param( 
        [Parameter(Mandatory = $true)]
        [string]
        $rootPath,         
        [Parameter(Mandatory = $true)]
        [string]
        $environmentConfigurationFilePath,
        [Parameter(Mandatory = $true)]
        [string]
        $productConfigurationFilePath
    )

    $webAdministrationAvailable = Get-Module WebAdministration -ListAvailable
    $serviceBusAvailable = Test-Path "$rootPath\Deployment\PowershellModules\Tools\Microsoft.ServiceBus.dll"
    $configuration = Get-Configuration $environmentConfigurationFilePath $productConfigurationFilePath

    Get-MetadataForCertificates $rootPath $configuration
    if ($webAdministrationAvailable) {
        Get-MetadataForWebsites $rootPath $configuration
    }

    if ($serviceBusAvailable) {
        Get-MetadataForServiceBuses $rootPath $configuration
    }

    Get-MetadataForServices $rootPath $configuration
}
