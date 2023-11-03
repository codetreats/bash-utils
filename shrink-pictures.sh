#!/bin/bash
set -e

for FILE in $(find .  -maxdepth 1 -type f -iname "*.jpg"); do
	convert $FILE -resize 1200x1200 $FILE.res.jpg
done

for FILE in $(find .  -maxdepth 1 -type f -iname "*.png"); do
	convert $FILE -resize 1200x1200 $FILE.res.png
done