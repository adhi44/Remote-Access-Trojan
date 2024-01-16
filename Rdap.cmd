# Set variables
$RemoteComputer = "DESKTOP-99DDMT8"
$Username = "Student"
$Password = "REMOTE_PASSWORD"

# FTP server details
$FTPHost = "FTP_SERVER"
$FTPUsername = "FTP_USERNAME"
$FTPPassword = "FTP_PASSWORD"

# Path to the script
$ScriptPath = "C:\Path\To\Your\Script.ps1"

# Check if the script is running for the first time
$FirstRunMarker = "C:\Path\To\Your\FirstRun.marker"
$IsFirstRun = -not (Test-Path $FirstRunMarker)

# If it's the first run, display setup complete message
if ($IsFirstRun) {
    [System.Windows.Forms.MessageBox]::Show("Setup Complete", "Setup", "OK", "Information")
    # Create a marker file to indicate that the setup has been completed
    New-Item -ItemType File -Path $FirstRunMarker -Force
}

# Create credentials object for remote desktop connection
$SecurePassword = ConvertTo-SecureString $Password -AsPlainText -Force
$RDPCredentials = New-Object System.Management.Automation.PSCredential ($Username, $SecurePassword)

# Create credentials object for FTP connection
$FTPSecurePassword = ConvertTo-SecureString $FTPPassword -AsPlainText -Force
$FTPCredentials = New-Object System.Management.Automation.PSCredential ($FTPUsername, $FTPSecurePassword)

# Create RDP connection file
$RDPFile = "$env:USERPROFILE\Desktop\AutoConnect.rdp"
"screen mode id:i:1" | Out-File -FilePath $RDPFile

# Add additional RDP settings as needed
# For example:
# "full address:s:$RemoteComputer" | Out-File -Append -FilePath $RDPFile
# "username:s:$Username" | Out-File -Append -FilePath $RDPFile
# "password 51:b:$(ConvertTo-SecureString $Password -AsPlainText -Force | ConvertFrom-SecureString)" | Out-File -Append -FilePath $RDPFile

# Connect to FTP server temporarily
# Add your FTP commands here using $FTPHost, $FTPUsername, and $FTPPassword

# Start Remote Desktop Connection
Start-Process "mstsc.exe" -ArgumentList $RDPFile -WindowStyle Hidden

# Optionally, you can remove the RDP file after connecting
# Remove-Item $RDPFile
