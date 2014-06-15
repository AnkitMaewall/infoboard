#!/bin/bash

TMP_FOLDER="./static/tmp/"

# does a file from today exist?
if [ ! `find "$TMP_FOLDER/nichtlustig.jpg" -mtime -1 2> /dev/null` ]; 
then
	echo "creating file..."
	curl "http://static.nichtlustig.de/rss/nichtrss.rss" 		\
		| grep "http://static.nichtlustig.de/comics/full/"	\
		| head -n1 						\
		| sed -e 's/^\s*>//g' 					\
		| sed -e 's/<[\/]*url>//g'				\
		| xargs curl > $TMP_FOLDER/nichtlustig.jpg
fi

echo '<img src="/tmp/nichtlustig.jpg" />'