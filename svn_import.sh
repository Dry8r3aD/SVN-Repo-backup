#!/bin/bash

svnadmin load /path/to/repo < ~/reposA.svn_dump

for entry in $(ls *.svn.dump)
do
	repo_name=$( echo $entry | awk -F. '{print $1}')
	echo "Importing SVN Repo $repo_name to $(pwd)/$repo_name/"
	#svnadmin dump $entry > $entry.svn.dump
	svnadmin create $(pwd)/$repo_name
	svnadmin load $(pwd)/$repo_name/ < ./$entry
done

