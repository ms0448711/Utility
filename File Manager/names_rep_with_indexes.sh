#!/bin/bash
echo "change file name"
count=1
for file in *.mp3; do
	s=$(printf "%02d. " $count)
	s+=${file/$1/}
	echo $s
	mv "$file" "$s"
	count=$(($count+1))
done
exit 0
