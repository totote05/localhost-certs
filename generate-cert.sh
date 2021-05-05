######################
# Chech if directory exists
######################
if [ ! -d "certs" ]; then
  mkdir certs
fi

######################
# Become a Certificate Authority
######################

# Generate private key
openssl genrsa -des3 -out certs/localhostCA.key 2048
# Generate root certificate
openssl req -x509 -new -nodes -key certs/localhostCA.key -sha256 -days 3650 -out certs/localhostCA.pem

######################
# Create CA-signed certs
######################

# Generate a private key
openssl genrsa -out certs/localhost.key 2048
# Create a certificate-signing request
openssl req -new -key certs/localhost.key -out certs/localhost.csr
# Create a config file for the extensions
>certs/localhost.ext cat <<-EOF
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names
[alt_names]
DNS.1 = localhost # Be sure to include the domain name here because Common Name is not so commonly honoured by itself
DNS.2 = *.localhost # Optionally, add additional domains (I've added a subdomain here)
IP.1 = 127.0.0.1 # Optionally, add an IP address (if the connection which you have planned requires it)
EOF
# Create the signed certificate
openssl x509 -req -in certs/localhost.csr -CA certs/localhostCA.pem -CAkey certs/localhostCA.key -CAcreateserial \
-out certs/localhost.crt -days 3650 -sha256 -extfile certs/localhost.ext


# To recap:
#
# Become a CA
# Sign your certificate using your CA cert+key
# Import localhostCA.pem as an "Authority" (not into "Your Certificates") in your Chrome settings (Settings > Manage certificates > Authorities > Import)
# Use the localhost.crt and localhost.key files in your server
#
# source: https://stackoverflow.com/questions/7580508/getting-chrome-to-accept-self-signed-localhost-certificate