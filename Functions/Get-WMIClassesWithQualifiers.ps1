Function Get-WMIClassesWithQualifiers {
    <#
   .Synopsis
    This function finds wmi classes with a specific qualifier
   .Description
    This function allows you to explore WMI namespaces to find classes with a
    specific qualifier. Search for qualifiers such as dynamic, abstract,
    supportsupdate, singleton
   .Example
    Get-WmiClassesWithQualifiers -q dynamic
    finds all wmi classes in default namespace (root/cimv2) that are dynamic
   .Example
    Get-WmiClassesWithQualifiers -q supportsupdate -n root/wmi
    Finds all wmi classes in root/wmi that support updating
   .Parameter Qualifier
    The qualifier to search for. Ex: dynamic, abstract, supportsupdate,
    Singleton
   .Parameter Namespace
    The namespace to search. Default is Root/Cimv2
   .Role
    Meta
   .Component
    HSGWMIModuleV6
   .Notes
    NAME:  Get-WmiClassesWithQualifiers
    AUTHOR: ed wilson, msft
    LASTEDIT: 10/16/2011 13:49:42
    KEYWORDS: Scripting Techniques, WMI
    HSG: HSG-10-22-11, 10-24-11
   .Link
     Http://www.ScriptingGuys.com
 #Requires -Version 2.0
 #>
    Param(
        [string]$qualifier = "dynamic",
        [string]$namespace = "root\cimv2"
    )
    $classes = Get-WmiObject -list -namespace $namespace
    foreach ($class in $classes) {
        $query = "Select * from meta_class where __this isa ""$($class.name)"" "
        $a = Get-WmiObject -Query $query -Namespace $namespace |
            Select-Object -Property __class, qualifiers
        if ($a.qualifiers | ForEach-Object { $_ | Where-Object { $_.name -match "$qualifier" }}) {
            $a.__class
        }
    } #end foreach $class
} #end function Get-WMIClassesWithQualifiers
