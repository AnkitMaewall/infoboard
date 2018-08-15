#!/bin/bash

TMP_FOLDER=".\static\tmp\"

# does a file from today exist?
if [ ! `find "$TMP_FOLDER/nichtlustig.jpg" -daystart -mtime 0 2> /dev/null` ]; 
then
	echo "creating file..."
	curl "http://static.nichtlustig.de/rss/nichtrss.rss" 		\
		| grep "http://static.nichtlustig.de/comics/full/"	\
		| head -n1 						\
		| sed -e 's/^\s*>//g' 					\
		| sed -e 's/<[\/]*url>//g'				\
		| xargs curl 						\
		> $TMP_FOLDER/nichtlustig.jpg
fi

if [ -f $TMP_FOLDER/nichtlustig.jpg ]; then
	FILESIZE=$(stat -c%s "$TMP_FOLDER/nichtlustig.jpg")
	if [[ ! $FILESIZE > 0 ]] ;then
		rm $TMP_FOLDER/nichtlustig.jpg
	fi
fi

echo '<img width="50%" src="/tmp/nichtlustig.jpg" />'
