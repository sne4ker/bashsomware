# DO NOT RUN THIS AT ITS CURRENT STATE. THIS IS A WORK IN PROGRESS, THERE IS NO BUILT-IN WAY TO DECRYPT ENCRYPTED FILES AGAIN YET!

# bashsomware
A simple POC ransomware written in bash, using aescrypt and gpg.

I DO NOT hold ANY responsability concerning what this script is being used.

If you don't understand what exactly this script does don't run it.

I won't be held liable for any harm you do to your own machine/s or machine/s of others.

# Requirements:
GPG installed on the target machine

# Attention!
The PGP Files pub.key and private.key are generated by me. They exist so you can use this project out of the box.
To use your own, replace the pub.key with your own public PGP key.
The private.key is in this repository, so that if someone manages to encrypt some stuff they shouldn't have, the private key can be imported and the files can be decrypted again.

This script downloads a pre-compiled aescrypt binary, generates multiple random variables with the variable $RANDOM, combines them to one variable, gets the md5sum of this variable, cuts it down to 32 characters, saves that in a variable, stores it in a for a provided pgp public key encrypted file and uses the generated key to encrypt all files in a specified directory using aescrypt. The default directory is testdir, which is located inside this repo.

# Usage

To encrypt the files:
./bashsomware

To decrypt the files:
./bashsomware dekey

dekey: The key used to encrypt the files with aescrypt.

To revert the directory 'testdir' back to its original state:

./reverttestdir.sh
