# bashsomware
A simple POC ransomware written in bash, using aescrypt and gpg.

I DO NOT hold ANY responsability concerning what this script is being used.
If you don't understand what exactly this script does, first read the commented version (bashsomware_comments.sh)

Requirements:
GPG installed on the target machine

This script downloads a pre-compiled aescrypt binary, generates multiple random variables with the variable $RANDOM, combines them to one variable, gets the md5sum of this variable, cuts it down to 32 characters, saves that in a variable, stores it in a for a provided pgp public key encrypted file and uses the generated key to encrypt all files in a specified directory using aescrypt. The default directory is testdir, which is located inside this repo.
