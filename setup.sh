#!/bin/sh

CA_URL="$1"
CA_WEBUI_CN="$2"
ACME_DEVICE_ATTEST_CN_SUFFIX=".$3.$1"
NAME="$4"

createPasswordFile () {
    echo "Making password file in file $1..."
    
    
    tr -dc 'A-Za-z0-9!"#$%&'\''()*+,-./:;<=>?@[\]^_`{|}~' </dev/urandom | head -c 33 | cat > $1
}

echo "Found CA_URL: '$CA_URL'"
echo "Found Web Server CN: '$CA_WEBUI_CN'"
echo "Found device attestation CN suffix of '$ACME_DEVICE_ATTEST_CN_SUFFIX'"
echo "Found CA Name: '$NAME'"



if [ -d "config" ]; then
echo "Removing old config..."
rm -r config
fi

cp -r base_configuration config

cd config

sed -i 's/$CA_WEBUI_CN/'"$CA_WEBUI_CN"'/g' config/ca.json
sed -i 's/$CA_URL/'"$CA_URL"'/g' config/ca.json
sed -i 's/$CA_URL/'"$CA_URL"'/g' config/defaults.json

sed -i 's/$CA_URL/'"$CA_URL"'/g' templates/certs/x509/root.tpl
sed -i 's/$CA_URL/'"$CA_URL"'/g' templates/certs/x509/intermediate.tpl
sed -i 's/$SUFFIX/'"$ACME_DEVICE_ATTEST_CN_SUFFIX"'/g' templates/certs/x509/intermediate.tpl
sed -i 's/$SUFFIX/'"$ACME_DEVICE_ATTEST_CN_SUFFIX"'/g' templates/certs/x509/acme-client.tpl



mkdir -p certs secrets
# Create certificates

#           1 year              = 8760 hours
# 10 years (Root CA Default)    = 87600 hours
# 5y (Intermediate CA Default)  = 43800 hours
# Highest time unit is hours (h)

# 1. Create root certificate

createPasswordFile secrets/root_password
createPasswordFile secrets/password

step certificate create \
    --template templates/certs/x509/root.tpl \
    --not-after 87600h \
    --password-file secrets/root_password \
    "$NAME Root CA" \
    certs/root_ca.crt secrets/root_ca_key

# 2. Create Intermediate
step certificate create \
    --template templates/certs/x509/intermediate.tpl \
    --not-after 43800h \
    --password-file secrets/password \
    --ca certs/root_ca.crt \
    --ca-key secrets/root_ca_key \
    --ca-password-file secrets/root_password \
    "$NAME Intermediate CA" \
    certs/intermediate_ca.crt secrets/intermediate_ca_key