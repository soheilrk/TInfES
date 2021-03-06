#!/bin/sh

USAGE="$0 <inp_dir> [<suffix>]
Link *<suffix>.cnl files from the specified directory to the current one respecting the folders
Example:  $0 ../results/statix/biomedical
"

if [ $# -gt 2 ] || [ $# -eq 0 ]
then
	printf "$USAGE"
	exit 1
fi

if [ "${1%*elp}" = "-h" ]
then
	printf "$USAGE"
	exit 0
fi

RDIR=$1  # Input directory of the *.cnl results
find -maxdepth 1 -type d | while read SDIR
do
	# Skip ".", process only "./" ...
	if [ ${#SDIR} -eq 1 ]
	then
		continue
	fi
	# Retain only the dir names without the leading ./
	NAME=${SDIR##*/}
	#echo $NAME
	find -L "$RDIR" -maxdepth 1 -type f -name "${NAME}*${2}.cnl" -exec ln -s "../{}" "$NAME/" \;
done
