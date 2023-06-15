Automated nginx proxy with self-signed SSL certificates for local development 

## Installation

- Clone the repository `git clone git@github.com:roysa/local-nginx-proxy.git nginx-proxy`

- `cp .env.example .env`

- Create a network `docker network create domains`

- Run containers `docker compose up -d`

## Ubuntu Docker Rootless 

There are specific steps to allow containers run at rootless docker.

- Allow to expose privileged ports https://docs.docker.com/engine/security/rootless/#exposing-privileged-ports and reboot the system

- Clone the repository `git clone git@github.com:roysa/local-nginx-proxy.git nginx-proxy`

- `cp .env.rootless.example .env`

- Create a network `docker network create domains`

- Run containers `docker compose up -d`


## CA installation for Ubuntu

- Copy the CA cert `sudo cp data/certs/ca.crt /usr/local/share/ca-certificates/nginx-proxy-CA.crt`
- Verify `openssl x509 -in /usr/local/share/ca-certificates/nginx-proxy-CA.crt -noout -text`
- Run `sudo update-ca-certificates` , the expected result is "1 added, 0 removed; done."
- For Chrome, import the CA file in chrome://settings/certificates Authorities tab

## CA installation for macOS

Import the data/certs/ca.crt file using instructions at https://support.apple.com/guide/keychain-access/add-certificates-to-a-keychain-kyca2431/mac

- In the Keychain Access app  on your Mac, select either the login or System keychain.

- Drag the ca.key certificate file onto the Keychain Access app.

- If you’re asked to provide a name and password, type the name and password for an administrator user on this computer.

- If "This root certificate is not trusted" message is displayed, open imported certificate details and set "Always Trust" in "Trust" section

## Update expired certificates

1. regenerate all certificates including CA: `docker compose stop && rm -rf data/certs/* && docker compose up -d && wait 10 && docker compose restart`

2. install new CA
