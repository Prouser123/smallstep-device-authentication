{
    "subject": {{ toJson .Subject }},
    "issuer": {{ toJson .Subject }},
    "keyUsage": ["certSign", "crlSign"],
    "basicConstraints": {
        "isCA": true,
        "maxPathLen": 1
    },
    "nameConstraints": {
        "_": "This seems to apply to all sub certs!",
        "critical": true,
        "permittedDNSDomains": ["$CA_URL"],
        "_2": "Block all other dns names, emails, etc.",
        "excludedDNSDomains": [""],
        "excludedIPRanges": ["0.0.0.0/0", "0:0:0:0:0:0:0:0/0"],
        "excludedEmailAddresses": [""],
        "excludedURIDomains": [""]
    }   
}