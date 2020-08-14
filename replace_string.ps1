Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted


$pwd = Get-Location  ## get the current Path
$LogFile = "D:\Data\Logging\replace_srting.log"	
#$files = Get-ChildItem "*.xml" -Recurse
$Path = 'D:\Data\umesh\'
Set-Location -Path $Path # change the path

$files = Get-ChildItem  "*.xml" -Recurse 

if(Test-Path $LogFile)
{
    Remove-Item $LogFile
}

Start-Transcript -Path $LogFile
Write-Output "Start replacing the string."

$find = 'Microsoft'

$replace = 'testing'

Get-ChildItem $files -Recurse |
select -ExpandProperty fullname |
foreach {
     If(Select-String -Path $_ -SimpleMatch $find -quiet){
          (Get-Content $_) |
          ForEach-Object {$_ -replace $find, $replace } |
              Set-Content $_
              write-host "File Changed : " $_
          } 
     }
	 
Write-Output "successfully replaced the value."
Stop-Transcript

Set-Location -Path $pwd
