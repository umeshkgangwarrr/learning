Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted

# Run PowerShell with administrator permissions.
If(!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) 
{ 
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit 
}
Else
{
	############################################## Import Scheduled Task ##############################################
	$LogFile = "D:\Data\Logging\import_files.log"
	$Path = 'D:\Data\Tasks'			  # Path where you have putted task file
	$pwd = Get-Location               # get the current Path
	Set-Location -Path $Path          # change the path

	$task_user = "Gangwar\Gangwar"    # Set username
	$task_pass = "gangwar123"         # Set password
	$task_path = "testing"            # Set folder name
	#$TaskFolder = "D:\Data\Tasks\Microsoft\XblGameSave\XblGameSaveTask.xml"
	#$task_name = "XblGameSaveTask"

	$schedule = new-object -com("Schedule.Service")
	$schedule.Connect() # servername

	#Register-ScheduledTask -Xml (Get-Content $TaskFolder | Out-String) -TaskName $task_name -TaskPath $task_path -User $task_user -Password $task_pass –Force
	
	if(Test-Path $LogFile)
	{
		Remove-Item $LogFile
	}


	$files = Get-ChildItem  "*.xml" -Recurse 

	Start-Transcript -Path $LogFile
	Write-Output "Start importing the task in scheduler Tasks."


	$folder = Get-ChildItem $files -Recurse | select -ExpandProperty fullname 

	#Write-Output $folder

	Foreach ($TaskFolder in $folder)
	{
		#Write-Output "Task folder: $TaskFolder"
		$task_name = Split-Path -Path "$TaskFolder" -Leaf -Resolve | %{ $_.Split('.')[0]; }
		#Write-Output $task_name
		Register-ScheduledTask -Xml (Get-Content $TaskFolder | Out-String) -TaskName $task_name -TaskPath $task_path -User $task_user -Password $task_pass -Force  	
	}

	echo "successfully import the task in scheduler task"
	Stop-Transcript
	Set-Location -Path $pwd

}