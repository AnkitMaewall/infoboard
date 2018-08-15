#!/bin/bash
TMP_FOLDER=".\static\tmp\"

# does a file from today exist?
if [ ! `find "/tmp/wiki-faotd.xml" -daystart -mtime 0 2> /dev/null` ]; 
then
	#echo "fetching wiki stuff..."
	curl "http://en.wikipedia.org/w/api.php?action=query&action=featuredfeed&feed=featured" > /tmp/wiki-faotd.xml

	xmllint --xpath '(//description)[last()]/text()' /tmp/wiki-faotd.xml \
		| head -n1 		\
		| egrep -o '[^ ]*\s2x' 	\
		| sed -e "s/ 2x//" 	\
		| sed -e "s/^/http:/"	\
		| xargs curl 		\
		> $TMP_FOLDER/wiki-faotd.jpg

	xmllint --xpath '(//description)[last()]/text()' /tmp/wiki-faotd.xml \
		| sed -e "s/&lt;/</g" 	\
		| sed -e "s/&gt;/>/g" 	\
		| sed -e "s/<[^>]*>//g" \
		| egrep -o "[^.]*" 	\
		| head -n3 		\
		| sed -e "s/$/./" 	\
		| tr -d '\n'		\
		> /tmp/wiki-faotd.txt
fi


echo '
	<div style="text-align:left">
<h3>
	Wikipedia Featured Article of the Day</h3>
<br/>
</div>
	<div style="text-align:left">
		<img align="right" src="/tmp/wiki-faotd.jpg" style="padding-left:25px;" />
		<blockquote style="font-size:1.3em">
		'

cat /tmp/wiki-faotd.txt
echo '
		</blockquote>
	</div>'
