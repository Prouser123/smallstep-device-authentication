#!/bin/sh

CA_URL="$1"
CA_WEBUI_CN="$2"
ACME_DEVICE_ATTEST_CN_SUFFIX="$3"

echo "Found CA_URL: '$CA_URL'"
echo "Found Web Server CN: '$CA_WEBUI_CN'"
echo "Found device attestation CN suffix of '$3'"



if [ -d "config" ]; then
echo "Removing old config..."
rm -r config
fi

cp -r base_configuration config

cd config

sed -i 's/$CA_WEBUI_CN/'"$CA_WEBUI_CN"'/g' config/ca.json
sed -i 's/$CA_URL/'"$CA_URL"'/g' config/ca.json
sed -i 's/$CA_URL/'"$CA_URL"'/g' config/defaults.json
sed -i 's/$SUFFIX/'"$ACME_DEVICE_ATTEST_CN_SUFFIX"'/g' templates/certs/x509/acme-client.tpl