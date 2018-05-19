SwiftyRSA
=========

![](https://img.shields.io/badge/language-swift_3.2/4.0-brightgreen.svg)


Quick Start
-----------

#### Create a public/private key
```

// In the terminal do the following things:

// Generate a 1024-bit private key
openssl genrsa -out private_key.pem 1024

// Generate a public key from the private key
openssl rsa -in private_key.pem -pubout -out public_key.pem

// Convert the private key to PKCS#8 format
openssl pkcs8 -topk8 -inform PEM -in private_key.pem -outform PEM -out private_key_pkcs8.pem -nocrypt
```

#### Add the 2 files public_key.pem & private_key_pkcs8.pem(optional) if you will decrypt message app side to the Xcode bundle.
#### Have a look at class RSAEncryptionViewController the way it's implemented.

Thanks to
-------------

 - <https://plus.google.com/114734226380957035996>

Inspired from
-------------

 - <https://studyswift.blogspot.in/2016/02/encrypt-decrypt-string-with-public.html>
