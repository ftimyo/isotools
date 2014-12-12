#!/bin/bash 

function get_artists()
{
	echo $@ |awk -F', ' '{for(i=1;i<=NF;i++){printf "%s\n", $i}}'|while read artist; do
		artist=(`echo $artist | sed -e 's/ /_/g'`)
		echo $artist
	done
}

find $1 -type d -d 2 -print | while read file; do
	path=$file

	album=${path##*/}
	album=`echo $album | sed -e 's/_//g'`
	album_name=`echo $album | sed -e 's/ /_/g' -e 's/_-_/-/g' -e 's/_\&_/\&/g'\
		-e 's/_\([0-9]\)/\1/g'\
		-e 's/;_/;/g'\
		-e 's/,_/,/g'`
	artists=${path%/*}

	artists=${artists##*/}

	artists=`echo $artists | sed  's/Wiener Philharmoniker/WPO/'`
	artists=`echo $artists | sed  's/Berliner Philharmoniker/BPO/'`
	artists=`echo $artists | sed  's/The Philadelphia Orchestra/PO/'`
	artists=`echo $artists | sed  's/ &/,/'`

	artists=(`get_artists $artists`)

	label=$album
	if ((${#album} > 30)); then
		label=${album:0:30}
#echo "automatic generated label: $label"
	fi

#now let's just add at most two artists
	if ((${#artists[@]} == 1))
	then
		artists_name=${artists[0]}
	else
		artists_name=${artists[0]},${artists[1]}
	fi

	file="$album_name[$artists_name].iso"

	mkisofs -J -R -V "$label" -o "$file" "$path"

done

