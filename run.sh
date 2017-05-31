#!/bin/bash

# user speficied arguments
author=$1 
outfile=$2

# create a new dump file
echo "# Dump File" > "$outfile"
echo "This is a dumpfile for testing." >> "$outfile"

# list all tracked files, filter binary files not suitable to be blamed
git ls-files | grep -v ".png" | grep -v "jpg" | grep -v ".pptx" |

while read in; do 
	
	# for each line, grep the line edited by the specified author
	output=$(git --no-pager blame -M -C -w "$in" | grep "$author")

	if [ -z "$output" ]; then
		# if the file has no edit, output to console
		echo "no edit found in $in"
	else
		# if the file has at least some edits, append to file
		echo "## $in" >> "$outfile"
		echo "\`\`\`" >> "$outfile"
		echo "$output" >>  "$outfile"
		echo "\`\`\`" >> "$outfile"
	fi

done