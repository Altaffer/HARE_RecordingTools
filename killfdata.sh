#!/bin/bash
FILE=fdata.txt
while read -a line;do
kill $line
done < $FILE
