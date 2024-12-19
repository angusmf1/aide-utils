# install.ps
#
# Install AIDE configuration.

# Download and install the mkcert binary;
# the binary is kept in Downloads to avoid admin requirement
echo "Downloading mkcert..."
Invoke-WebRequest -Uri "https://github.com/FiloSottile/mkcert/releases/download/v1.4.4/mkcert-v1.4.4-windows-amd64.exe" -OutFile "$env:USERPROFILE\Downloads\mkcert.exe"

# Download the root CA certificate
echo "Downloading root CA certificate..."
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/angusmf1/aide-utils/refs/heads/main/files/test/rootCA.crt" -OutFile "$env:USERPROFILE\Downloads\rootCA.crt"

# Get the mkcert CA root folder and move the root CA certificate there
echo "Preparing root CA..."
$caRootPath = & "$env:USERPROFILE\Downloads\mkcert.exe" -CAROOT
if (-not (Test-Path -Path $caRootPath)) {
    New-Item -Path $caRootPath -ItemType Directory
}
Move-Item -Force -Path "$env:USERPROFILE\Downloads\rootCA.crt" -Destination $caRootPath

# Install the root CA certificate
echo "Installing root CA..."
& "$env:USERPROFILE\Downloads\mkcert.exe" -install

# Remove downloads
echo "Cleaning up..."
Remove-Item "$env:USERPROFILE\Downloads\mkcert.exe"