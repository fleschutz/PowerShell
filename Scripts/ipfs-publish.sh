#!/bin/sh

# Syntax:	./ipfs-publish <dir-tree>
# Description:	publishes the given directory tree to IPFS
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0
# NOTE: 	requires <ipfs> and <hashdeep>

DIR=$1
IPFS_HASHES="IPFS_hash_list.txt"
DF_HASHES="checksum_list.xml"

echo "Publishing folder $DIR to IPFS"
echo "(1/3) Removing Thumbs.db in subfolders ..."
nice find "$DIR" -name Thumbs.db -exec rm -rf {} \;

echo "(2/3) Adding $DIR to IPFS ..."
nice ipfs add -r "$DIR" > $IPFS_HASHES

echo "(3/3) Calculating digital forensics hashes to $DF_HASHES ..."
nice hashdeep -c md5,sha1,sha256 -r -d -l -j 1 "$DIR" > $DF_HASHES

echo "OK - to publish the content execute: ipfs name publish <HASH>"
exit 0
