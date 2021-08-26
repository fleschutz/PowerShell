#!/bin/sh
#
# requires <hashdeep>

if [ -r new_hashes.xml ]
then
	echo "Found new_hashes.xml, renaming it to known_hashes.xml ..."
	mv new_hashes.xml known_hashes.xml
fi

echo "Calculating new_hashes.xml of folder $1 ..."
hashdeep -c md5,sha1,sha256,tiger,whirlpool -r -d -l -j 1 $1 > new_hashes.xml

if [ -r known_hashes.xml ]
then
	echo "This has changed:"
	diff known_hashes.xml new_hashes.xml
fi

exit 0
