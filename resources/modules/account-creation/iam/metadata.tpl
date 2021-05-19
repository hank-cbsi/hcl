<?xml version="1.0" encoding="UTF-8"?>
<md:EntityDescriptor entityID="http://www.okta.com/${APPLICATIONID}" xmlns:md="urn:oasis:names:tc:SAML:2.0:metadata">
  <md:IDPSSODescriptor WantAuthnRequestsSigned="false" protocolSupportEnumeration="urn:oasis:names:tc:SAML:2.0:protocol">
    <md:KeyDescriptor use="signing">
      <ds:KeyInfo xmlns:ds="http://www.w3.org/2000/09/xmldsig#">
        <ds:X509Data>
          <ds:X509Certificate>MIIDmDCCAoCgAwIBAgIGAVzDcekVMA0GCSqGSIb3DQEBCwUAMIGMMQswCQYDVQQGEwJVUzETMBEG A1UECAwKQ2FsaWZvcm5pYTEWMBQGA1UEBwwNU2FuIEZyYW5jaXNjbzENMAsGA1UECgwET2t0YTEU MBIGA1UECwwLU1NPUHJvdmlkZXIxDTALBgNVBAMMBGNic2kxHDAaBgkqhkiG9w0BCQEWDWluZm9A b2t0YS5jb20wHhcNMTcwNjIwMDI1OTQxWhcNMjcwNjIwMDMwMDQxWjCBjDELMAkGA1UEBhMCVVMx EzARBgNVBAgMCkNhbGlmb3JuaWExFjAUBgNVBAcMDVNhbiBGcmFuY2lzY28xDTALBgNVBAoMBE9r dGExFDASBgNVBAsMC1NTT1Byb3ZpZGVyMQ0wCwYDVQQDDARjYnNpMRwwGgYJKoZIhvcNAQkBFg1p bmZvQG9rdGEuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAirQpUnNTfyeidZxb DVTJ0SZ7xzQk86C4gvP/Zr1kmJfkqg+qyhcrHtyehiLe0x0BfRsxRI0D/2lz8/MMYopwdKKkuSbb loj9dhVDnDPdCyJqva4CV7HaIdDXuO3kDOikXXy+woLKLRYoT+CBqCHwmuT3SsKREGDzMtCHd3Px dEjDaW5UJgcDRDrqKfMlgEDF5gxgE8JfVvuEOauXdUGjLnlqVR5FnlcgO846VMJxlmTkHkkqKSKi E5i/FIMEhu/SlzknwIy0XCYtVEpusQHXqsn5RYKY+67RJqTepbcTTiSouerfUub9uLUrzxWU/oW9 qOPg5j4VrsGefhLWa6D3owIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQAEDhGNumEbtn9/l2dDdxn2 BjZsHiXNOes14mprFiV/9VT0/gYtsC7/gVgRdan2aGAqJdEdVbTL0+mqYatdhULPPe/G795R281B 6mhiahmJHZdHrwue29iQoJsSag4bdML8YRgOpKnE4EQCoCQMDfTa0weQClwQyz4GayaFsWQFcEQj A3LURs6MO27j9zk5vv3UTT4DQy1QwDO1gzKLFeo2mciEK5/B48QTb9SrX4Y5noqwQAVkIgIG+Q5i +Kv+1u1LAVw5MxlOD2+f1fwRDxowpaOzPGjILI7aDsYkspnqTkFAWdYY3TjQ6kq/MuVd9aaj+I/e J7yd/PHDOjl/npgj</ds:X509Certificate>
        </ds:X509Data>
      </ds:KeyInfo>
    </md:KeyDescriptor>
    <md:NameIDFormat>urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified</md:NameIDFormat>
    <md:NameIDFormat>urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress</md:NameIDFormat>
    <md:SingleSignOnService Binding="urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST" Location="https://cbsi.okta.com/app/amazon_aws/${APPLICATIONID}/sso/saml"/>
    <md:SingleSignOnService Binding="urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Redirect" Location="https://cbsi.okta.com/app/amazon_aws/${APPLICATIONID}/sso/saml"/>
  </md:IDPSSODescriptor>
</md:EntityDescriptor>
