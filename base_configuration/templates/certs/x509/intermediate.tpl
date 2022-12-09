{
    "subject": {{ toJson .Subject }},
    "keyUsage": ["certSign", "crlSign"],
    "basicConstraints": {
        "isCA": true,
        "maxPathLen": 0
    },
    "nameConstraints": {
        "critical": true,
        "permittedDNSDomains": ["$CA_URL", "$SUFFIX"]
    } 
}