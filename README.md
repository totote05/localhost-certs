# localhost-certs

Generate both kind of certificates, **Crtificate Authority** and **Self-Signed** certificated for local develoment

## Become a CA and sign your certificate using your CA cert+key

```bash
$ ./generate-cert.sh 
Generating RSA private key, 2048 bit long modulus (2 primes)
..+++++
..........................+++++
e is 65537 (0x010001)
Enter pass phrase for certs/localhostCA.key: ****
Verifying - Enter pass phrase for certs/localhostCA.key: ****
Enter pass phrase for certs/localhostCA.key: ****
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [AU]:AR
State or Province Name (full name) [Some-State]:.
Locality Name (eg, city) []:.
Organization Name (eg, company) [Internet Widgits Pty Ltd]:.
Organizational Unit Name (eg, section) []:.
Common Name (e.g. server FQDN or YOUR name) []:localhost
Email Address []:.
Generating RSA private key, 2048 bit long modulus (2 primes)
..........................................................................+++++
...............+++++
e is 65537 (0x010001)
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [AU]:AR
State or Province Name (full name) [Some-State]:.
Locality Name (eg, city) []:.
Organization Name (eg, company) [Internet Widgits Pty Ltd]:.
Organizational Unit Name (eg, section) []:.
Common Name (e.g. server FQDN or YOUR name) []:localhost
Email Address []:.

Please enter the following 'extra' attributes
to be sent with your certificate request
A challenge password []:
An optional company name []:
Signature ok
subject=C = AR, CN = localhost
Getting CA Private Key
Enter pass phrase for certs/localhostCA.key: ****
```

## Import CA in your browser

As Authorities (not into "Your Certificates) import the localhostCA.pem. And for security reason only check **identify websites**.

* Chrome: Settings > Privacy and ecurity > Security > Manage certificates > Authorities > Import
* Firefox: Preferences > Privacy & Security > Security > Certificates > View Certificates... > Authorities > Import

## Use the certificates

Use the localhost.crt and localhost.key files in your server

### vscode liveServer
```json
"liveServer.settings.https": {
  "enable": true,
  "cert": "/home/totote/.ssh/server/localhost.crt",
  "key": "/home/totote/.ssh/server/localhost.key",
  "passphrase": "localhost"
}
```