#!/bin/bash

#unalias ls
for entry in $(ls -1 */ | awk -F/ '{print $1}')
do
	#entry = $(awk '{printf $1}')
	echo "dump $entry repo to :: $entry.svn.dump"
	svnadmin dump $entry > $entry.svn.dump
done

