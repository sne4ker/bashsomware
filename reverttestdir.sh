#!/bin/bash
echo "Reverting directory 'testdir' back to its original state..."

if [ -e testdir ]
then
	rm -rf testdir
fi
mkdir testdir
wget -O testdir/fun.txt https://github.com/sne4ker/bashsomware/blob/main/testdir/fun.txt > /dev/null 2>&1 /dev/null
wget -O testdir/randomtextfile.txt https://github.com/sne4ker/bashsomware/blob/main/testdir/randomtextfile.txt > /dev/null 2>&1 /dev/null
wget -O testdir/sense.png https://github.com/sne4ker/bashsomware/blob/main/testdir/sense.png > /dev/null 2>&1 /dev/null


echo "Done!"
echo ""
echo "testdir now contains the following files again:"

for value in testdir/*
do
	base=$(basename $value)
	echo "$base"
done