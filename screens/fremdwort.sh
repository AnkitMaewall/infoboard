#!/bin/bash
TMP_FOLDER=".\static\tmp\"

echo '
	<div style="text-align:left;">'

# does a file from today exist?
if [ ! `find "/tmp/fremdwort.xml" -daystart -mtime 0 2> /dev/null` ]; 
then
	echo "fetching fremdwort..."
	curl "http://neueswort.de/feed/" > /tmp/fremdwort.xml

	xmllint --xpath "(//item)[1]/title/text()" /tmp/fremdwort.xml \
	> $TMP_FOLDER/fremdwort.txt

	xmllint --xpath '(//item/*)[9]/text()' /tmp/fremdwort.xml \
	| head -n-1 			\
	| sed -e "s/]]>//g" 		\
	| sed -e "s/<!\[CDATA\[//"	\
	> $TMP_FOLDER/fremdwort-desc.txt
fi


echo '
<h3>Fremdwort des Tages</h3>
<br/>
<h1 style="margin-bottom:0.6em;">'
cat $TMP_FOLDER/fremdwort.txt
echo '</h1>'


echo '<p style="font-size:1.6em">'
#echo '<blockquote>'
cat $TMP_FOLDER/fremdwort-desc.txt
#echo '</blockquote>'

echo '</p>
	</div>'
