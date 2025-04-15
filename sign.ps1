echo "Signing with Digicert Token"

# Check if the required environment variables are set
if (-not $env:DIGICERT_TOKEN_PASSWORD) {
    Write-Host "Error: DIGICERT_TOKEN_PASSWORD environment variable is not set."
    exit 1
}
if (-not $env:DIGICERT_TOKEN_CFG_PATH) {
    Write-Host "Error: DIGICERT_TOKEN_CFG_PATH environment variable is not set."
    exit 1
}
if (-not $env:DIGICERT_KEY_ALIAS) {
    Write-Host "Error: DIGICERT_KEY_ALIAS environment variable is not set."
    exit 1
}
if (-not $env:SIGNED_BINARY_NAME) {
    Write-Host "Error: SIGNED_BINARY_NAME environment variable is not set."
    exit 1
}

jarsigner -verbose `
    -tsa http://timestamp.digicert.com `
    -keystore NONE `
    -storetype PKCS11 `
    -storepass $env:DIGICERT_TOKEN_PASSWORD `
    -providerClass sun.security.pkcs11.SunPKCS11 `
    -providerArg "$env:DIGICERT_TOKEN_CFG_PATH" `
    -sigalg SHA256withRSA `
    -signedjar $env:SIGNED_BINARY_NAME `
    spice.taco `
    "$env:DIGICERT_KEY_ALIAS" 