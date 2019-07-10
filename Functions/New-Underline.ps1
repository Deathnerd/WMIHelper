function New-Underline {
    <#
.Synopsis
 Creates an underline the length of the input string
.Example
 New-Underline -strIN "Hello world"
.Example
 New-Underline -strIn "Morgen welt" -char "-" -sColor "blue" -uColor "yellow"
.Example
 "this is a string" | New-Underline
.Role
 Helper
.Component
 HSGWMIModuleV6
.Notes
 NAME:
 AUTHOR: Ed Wilson
 LASTEDIT: 5/20/2009
 KEYWORDS:
.Link
 Http://www.ScriptingGuys.com
#>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, Position = 0, valueFromPipeline = $true)]
        [Alias("strIN")]
        [string]$String,
        [Alias("char")]
        [string]$UnderlineCharacter = "=",
        [Alias("sColor")]
        [string]$StringColor = "Green",
        [Alias("uColor")]
        [string]$UnderlineColor = "darkGreen",
        [switch]$Pipe
    ) #end param
    $strLine = $UnderlineCharacter * $String.length
    if ($Pipe) {
        $String
        $strLine
    } else {
        Write-Host -ForegroundColor $StringColor $String
        Write-Host -ForegroundColor $UnderlineColor $strLine
    }
} #end new-underline function
