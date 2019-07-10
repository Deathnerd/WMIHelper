. "$PSScriptRoot\New-Underline.ps1"
function Get-WmiClassMethods {
    <#
   .Synopsis
    This function returns implemented methods for a WMI class
   .Description
    This function returns implemented methods for a WMI class
   .Example
    Get-WmiClassMethods Win32_logicaldisk
    Returns implemented methods from the Win32_logicaldisk class
   .Example
    Get-WmiClassMethods -class bcdstore -namespace root\wmi
    Returns methods of the bcdStore WMI class from the root\wmi namespace
   .EXAMPLE
    Get-WmiClassMethods -class Win32_networkadapter -computer DC1
    Returns methods from the Win32_networkadapter wmi class in the root\cimv2
    namespace from a remote server named DC1
   .Parameter Class
    The name of the WMI class
   .Parameter Namespace
    The name of the WMI namespace. Defaults to root\cimv2
   .Parameter Computer
    The name of the computer. Defaults to local computer
   .Role
    Meta
   .Component
    HSGWMIModuleV6
   .Notes
    NAME:  Get-WmiClassMethods
    AUTHOR: ed wilson, msft
    LASTEDIT: 10/17/2011 13:43:24
    KEYWORDS:
    HSG: HSG-10-24-11, based upon WES-3-12-11
   .Link
     Http://www.ScriptingGuys.com
 #Requires -Version 2.0
 #>
    Param(
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$class,
        [string]$namespace = "root\cimv2",
        [string]$computer = $env:computername
    )
    $abstract = $false
    $method = $null
    [wmiclass]$class = "\\{0}\{1}:{2}" -f $computer, $namespace, $class
    Foreach ($q in $class.Qualifiers)
    { if ($q.name -eq 'Abstract') {$abstract = $true} }
    If (!$abstract) {
        Foreach ($m in $class.methods) {
            Foreach ($q in $m.qualifiers) {
                if ($q.name -match "implemented") {
                    $method += $m.name + "`r`n"
                }
            }
        }
        if ($method) {
            New-Underline -strIN $class.name
            New-Underline "METHODS" -char "-"
        }
        $method
    }
    $abstract = $false
    $method = $null
}
