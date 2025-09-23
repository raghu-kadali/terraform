# About key
 so before we going to vm to do connection of vm 
 not git,powershell,manually also automatic way

#tls_private_key → Terraform resource that generates a private key.
#When you create a VM in GCP, you usually need an SSH key to log in.
#Instead of generating it manually with ssh-keygen, Terraform can generate it using tls_private_key.


what is rsa and rsa_bits
so many algorithms:
1. ECDSA (Elliptic Curve Digital Signature Algorithm)
2. RSA
3.ED25519 fastest today


algorithm = "RSA"
→ The type of key to generate. RSA is the most common algorithm.

rsa_bits = "4096"
→ The strength (size) of the key in bits.

Bigger = more secure, but slightly slower.

Common values: 2048 or 4096.

Here, we’re making a strong key (4096-bit).

when its creating not a file type like ssh-keygen terraform store like values 

gives like a pem file;
tls_private_key.example.private_key_pem

tls_private_key.example.public_key_openssh





keys:
# Save private key to local file
# PEM stands for Privacy Enhanced Mail, but in practice, it’s just a standard format for storing cryptographic keys.
# PEM is used because it’s a standard for storing private keys safely
# openssh:It gives the public key in OpenSSH format, ready to be used in SSH authorized_keys
# localfile: create or manage a file on the local filesystem—the machine where Terraform runs. no interact cloud