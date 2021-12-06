Set-ExecutionPolicy -ExecutionPolicy bypass -Force
Start-Transcript -Path C:\WindowsAzure\Logs\extensionlog.txt -Append
Write-Host "Logon-task-started" 

Start-Process C:\Packages\extensions.bat
Write-Host "Bypass-Execution-Policy" 

choco install docker-desktop --version=3.5.2-edge --pre 

Write-Host "Docker-install"

#Installing PostgreSQL extension fro Azure Data Studio
$WebClient = New-Object System.Net.WebClient
$WebClient.DownloadFile("https://github.com/microsoft/azuredatastudio-postgresql/releases/download/v0.2.6/azuredatastudio-postgresql-0.2.6-win-x64.vsix","C:\Windows\System32\azuredatastudio-postgresql-0.2.6-win-x64.vsix")
azuredatastudio --install-extension azuredatastudio-postgresql-0.2.6-win-x64.vsix 

[Environment]::SetEnvironmentVariable("Path", $env:Path+";C:\Users\demouser\AppData\Roaming\npm\node_modules\azure-functions-core-tools\bin","User")

Unregister-ScheduledTask -TaskName "SetUpVMs" -Confirm:$false 
Restart-Computer -Force 
