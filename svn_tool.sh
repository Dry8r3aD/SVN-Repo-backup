#!/bin/bash
##########################################################################################################
# Usage : ./svn_tool.sh [import | export | dumpall | import all] -d [Dump path] -r [Repo path]           #
#														       					 						 #
# Options 													  					  						 #
# 	-d		Dump name to import / export					  					  						 #
# 	-r		Repo path to import / export					   					  						 #
##########################################################################################################

function svn_import(){
	svnadmin dump $3 > $2
}

function svn_export(){
	svnadmin create $3
	svnadmin load $3 < $2
}

function svn_dumpall(){
	for entry in $(ls -1 */ | awk -F/ '{print $1}')
	do
		echo "Dump $entry repo to :: $entry.svn.dump"
		svnadmin dump $entry > $entry.svn.dump
	done
}

function svn_importall(){
	for entry in $(ls *.svn.dump)
	do
		repo_name=$( echo $entry | awk -F. '{print $1}')
		echo "Importing SVN Repo $repo_name to $(pwd)/$repo_name/"
		svnadmin create $(pwd)/$repo_name
		svnadmin load $(pwd)/$repo_name/ < ./$entry
	done
}


if [ $# -ne 3 ] ; then
	echo "Proper usase of this script requires 3 arguments."
	exit 1;
fi

if [ "$1" == "import" ] ; then
	svn_import
	exit 0;
elif [ "$1" == "export" ] ; then
	svn_export
	exit 0;
elif [ "$1" == "dumpall" ] ; then
	svn_dumpall
	exit 0;
elif [ "$1" == "importall" ] ; then
	svn_importall
	exit 0;
else
	echo "Only support 'import' and 'export'"
	exit 1;
fi
