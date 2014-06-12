#!/bin/sh

if [[ ! -f /tmp/qod ]]; 
then
	touch /tmp/qod
	echo "touched"
	curl --silent www.brainyquote.com/quotes_of_the_day.html 		\
		| egrep '(span class="bqQuoteLink")|(div class="bq-aut")' 	\
		| sed -n '1p; 2p; ' 						\
		| sed -e 's/<[^>]*>//g' 					\
		> /tmp/qod
fi

if [ ! `find "/tmp/qod" -mtime -1` ]; 
then
	echo "creating file..."
	curl --silent www.brainyquote.com/quotes_of_the_day.html 		\
		| egrep '(span class="bqQuoteLink")|(div class="bq-aut")' 	\
		| sed -n '1p; 2p; ' 						\
		| sed -e 's/<[^>]*>//g' 					\
		> /tmp/qod
fi

echo '
	<div class="col-lg-10 col-lg-offset-1" style="margin-top:-40px;text-align:left;">
		<h3 style="font-size:70px;font-weight:normal;">
'

cat /tmp/qod | head -n1

echo '
		</h3>
		<br/>
		<h4 class="text-center">&mdash;
'
cat /tmp/qod | tail -n1

echo '&mdash;
	</h4>
	</div>
'
