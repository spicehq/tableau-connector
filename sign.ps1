echo $env:DIGICERT_TOKEN_CFG_PATH
echo $env:DIGICERT_TOKEN_PASSWORD | jarsigner -verbose `
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