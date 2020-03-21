#!/bin/bash

id_current=$(cat ~/.config/conky/current/current.txt)
id_new=$(~/.config/conky/scripts/id.sh)
cover=
imgurl=

if [ "$id_new" != "$id_current" ]; then

	cover=$(ls ~/.config/conky/covers | grep $id_new)

	if [ "$cover" == "" ]; then

	    imgurl=$(~/.config/conky/scripts/imgurl.sh $id_new)
	    wget -q -O ~/.config/conky/covers/$id_new.jpg $imgurl &> /dev/null
		# clean up covers folder, keeping only the latest X amount, in below example it is 10
	    rm -f $(ls -t ~/.config/conky/covers/* | awk 'NR>10')
	    rm wget-log #wget-logs are accumulated otherwise
	    cover=$(ls ~/.config/conky/covers | grep $id_new)
	fi

	if [ "$cover" != "" ]; then
		cp ~/.config/conky/covers/$cover ~/.config/conky/current/current.jpg
	else
		cp ~/.config/conky/empty.jpg ~/.config/conky/current/current.jpg
	fi

	echo $id_new > ~/.config/conky/current/current.txt
fi
