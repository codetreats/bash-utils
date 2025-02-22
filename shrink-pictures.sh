#!/bin/bash
set -e
#cd $(dirname "$0")
BASEDIR=$(pwd)

find . -type d | while read DIR; do	
  	cd "$BASEDIR/$DIR"
	echo "Process " $(pwd)
	for FILE in $(find .  -maxdepth 1 -type f -iname "*.jpg"); do
		FILE=$(echo $FILE | cut -d "/" -f2)
		echo convert $FILE
  		convert "$FILE" -resize 1200x1200 "$FILE.res.jpg"
	done

	for FILE in $(find .  -maxdepth 1 -type f -iname "*.png"); do
		FILE=$(echo $FILE | cut -d "/" -f2)
		echo convert $FILE
  		convert "$FILE" -resize 1200x1200 "$FILE.res.jpg"
	done
done

