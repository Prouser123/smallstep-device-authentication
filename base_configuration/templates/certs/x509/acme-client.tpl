{
    "keyUsage": ["digitalSignature"],
    "extKeyUsage": ["clientAuth"],
    "_0": "common name is set to udid",
    "subject": {
        "commonName": "{{ toJson .Subject.CommonName }}.$SUFFIX"
    },
    "_1": "If we put sans we get 1.3.6.1.5.5.7.8.3 with the uuid",
    "sans": {{ toJson .SANs }}
}

