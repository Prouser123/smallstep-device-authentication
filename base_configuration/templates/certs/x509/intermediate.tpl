{
    "subject": {{ toJson .Subject }},
    "keyUsage": ["certSign", "crlSign"],
    "basicConstraints": {
        "isCA": true,
        "maxPathLen": 0
    },
    "nameConstraints": {
        "critical": true,
        "permittedDNSDomains": ["$CA_URL", ".uids.acme.certs.step-eaptls.delta.cloud.jcx.ovh"]
    } 
}