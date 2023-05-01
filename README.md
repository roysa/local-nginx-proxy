## Installation

- Clone the repository `git clone git@github.com:roysa/local-nginx-proxy.git nginx-proxy`

- Create a network `docker network create domains`

- Run containers `docker compose up -d`

## CA installation for Ubuntu

- Copy the CA cert `sudo cp data/certs/ca.crt /usr/local/share/ca-certificates/nginx-proxy-CA.crt`
- Verify `openssl x509 -in /usr/local/share/ca-certificates/nginx-proxy-CA.crt -noout -text`
- Run `sudo update-ca-certificates` , the expected result is "1 added, 0 removed; done."
- For Chrome, import the CA file in chrome://settings/certificates Authorities tab

## CA installation for macOS

- Import the data/certs/ca.crt file using instructions at https://support.apple.com/guide/keychain-access/add-certificates-to-a-keychain-kyca2431/mac