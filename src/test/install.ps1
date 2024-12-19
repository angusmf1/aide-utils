# Install AIDE configuration.
 
# Download the root CA certificate.
Write-Output "[+] Downloading root CA certificate..."
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/angusmf1/aide-utils/refs/heads/main/files/test/MyCustomCA.crt" -OutFile "$env:USERPROFILE\Downloads\MyCustomCA.crt"
 
# Install the root CA certificate.
Write-Output "[+] Preparing root CA..."
Import-Certificate -FilePath "$env:USERPROFILE\Downloads\MyCustomCA.crt" -CertStoreLocation "Cert:\CurrentUser\Root\"
