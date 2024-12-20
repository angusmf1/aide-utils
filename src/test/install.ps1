# Install AIDE configuration.

# Define paths
$UserProfile = $env:USERPROFILE
$RootCAPath = "$UserProfile\Downloads\MyCustomCA.crt"
$HostsFilePath = "C:\Windows\System32\drivers\etc\hosts"
$BackupHostsFilePath = "$HostsFilePath.bak"
$HostsTxtUrl = "https://raw.githubusercontent.com/angusmf1/aide-utils/refs/heads/main/files/test/hosts.txt"
$RootCAUrl = "https://raw.githubusercontent.com/angusmf1/aide-utils/refs/heads/main/files/test/MyCustomCA.crt"

# Download the root CA certificate
Write-Output "[+] Downloading root CA certificate..."
try {
    Invoke-WebRequest -Uri $RootCAUrl -OutFile $RootCAPath -ErrorAction Stop
    Write-Output "[+] Root CA certificate downloaded to: $RootCAPath"
} catch {
    Write-Error "Failed to download root CA certificate: $_"
    exit 1
}

# Install the root CA certificate
Write-Output "[+] Installing root CA certificate..."
try {
    Import-Certificate -FilePath $RootCAPath -CertStoreLocation "Cert:\CurrentUser\Root" -ErrorAction Stop
    Write-Output "[+] Root CA certificate installed successfully."
} catch {
    Write-Error "Failed to install root CA certificate: $_"
    exit 1
}

# Back up the original hosts file
Write-Output "[+] Backing up hosts file..."
try {
    Copy-Item -Path $HostsFilePath -Destination $BackupHostsFilePath -Force -ErrorAction Stop
    Write-Output "[+] Hosts file backed up to: $BackupHostsFilePath"
} catch {
    Write-Error "Failed to back up hosts file: $_"
    exit 1
}

# Download the hosts.txt content
Write-Output "[+] Downloading hosts.txt content..."
try {
    $HostsContent = Invoke-WebRequest -Uri $HostsTxtUrl -UseBasicParsing -ErrorAction Stop | Select-Object -ExpandProperty Content
    Write-Output "[+] hosts.txt content downloaded successfully."
} catch {
    Write-Error "Failed to download hosts.txt content: $_"
    exit 1
}

# Remove any CRLF characters
$CleanHostsContent = $HostsContent -replace "`r", ""

# Append the downloaded content to the hosts file
Write-Output "[+] Updating hosts file..."
try {
    Add-Content -Path $HostsFilePath -Value $CleanHostsContent -ErrorAction Stop
    Add-Content -Path $HostsFilePath -Value "" -ErrorAction Stop
    Write-Output "[+] Hosts file updated successfully."
} catch {
    Write-Error "Failed to update hosts file: $_"
    exit 1
}
