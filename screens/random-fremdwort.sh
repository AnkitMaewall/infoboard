#!/bin/bash
TMP_FOLDER=".\static\tmp\"

echo '
	<div style="text-align:left;">'

# does a file from today exist?
if [ ! `find "$TMP_FOLDER/random-fremdwort-title.txt" -daystart -mtime 0 2> /dev/null` ]; 
then
	#echo "fetching fremdwort archiv list.."
	curl http://neueswort.de/archiv/ > /tmp/fremdwoerter.html
	cat /tmp/fremdwoerter.html | grep 'rel="bookmark"' | sed -e "s/\s*<a href=\"//g" | sed -e "s/\".*//g" > /tmp/alle-fremdwoerter.lst

	count=$(wc -l /tmp/alle-fremdwoerter.lst)
	#echo $count

	r=$RANDOM
	rand=$(( r %= 200 ))
	#echo "random: " $rand

	wort=$(cat /tmp/alle-fremdwoerter.lst | head -n$rand | tail -1)
	#echo "wort: " $wort

	curl $wort > /tmp/random-fremdwort.html

	# omitt some text 
	match=$(cat /tmp/random-fremdwort.html  | grep -n "Weitere interessante W" | cut -f1 -d:)
	cat /tmp/random-fremdwort.html  | head -n$match >/tmp/random-fremdwort-edited.html

	xmllint --html --xpath "//h2[@class='entry-title']/text()" /tmp/random-fremdwort-edited.html \
	> $TMP_FOLDER/random-fremdwort-title.txt

	xmllint --html --xpath "//div[@class='entry-content']/p" /tmp/random-fremdwort-edited.html \
	> $TMP_FOLDER/random-fremdwort-desc.txt

	xmllint --html --xpath "//div[@class='entry-content']/blockquote" /tmp/random-fremdwort-edited.html \
	>> $TMP_FOLDER/random-fremdwort-desc.txt
fi


echo '
<h3>(Zuf&auml;lliges) Fremdwort des Tages</h3>
<br/>
<h1 style="margin-bottom:0.5em;">'
cat $TMP_FOLDER/random-fremdwort-title.txt
echo '</h1>'


echo '<p style="font-size:1.6em">'
#echo '<blockquote>'
cat $TMP_FOLDER/random-fremdwort-desc.txt
#echo '</blockquote>'

echo '</p>
	</div>'
