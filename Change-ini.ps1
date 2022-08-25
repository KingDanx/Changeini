# Ini files
# Replacing a value in a key inside a section sample
$ipAddress = 2
$Path="\\200.200.200.$ipAddress\c$\Penta\PSC\config.ini"
 
 
function Set-INIKey{

    param(
        [string]$path,
        [string]$section,
        [string]$key,
        [string]$value
    )

    $edits = (Get-Content $path) -join "`r`n" -split '\s(?=\[.+?\])' | ForEach-Object{
        If($_ -match "\[$section\]"){
            $_ -replace "($key=)\w+", "$key=$value"
        } Else {
            $_
        }
    }

    -join $edits | Set-Content $path
}


for (($i=2); $i -lt 250; $i++)
{
    $script:ipAddress = $i
    $script:Path = "\\10.204.$ipAddress.10\c$\Penta\PSC\config.ini"
    Write-Output $Path
    Set-INIKey $Path "config" "auto_recovery" "false"
}


