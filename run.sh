#!/bin/bash

# user speficied arguments
author=$1 
outfile=$2

# create a new dump file
echo "# Dump File" > "$outfile"
echo "This is a dumpfile for testing." >> "$outfile"

# count number of files
total_number_of_files=$(git ls-files | grep -v ".png" | grep -v "jpg" | grep -v ".pptx" | grep -v ".jar" | wc -l)

# number of files analyzed so far
current_file_counter=1

# list all tracked files, filter binary files not suitable to be blamed
git ls-files | grep -v ".png" | grep -v "jpg" | grep -v ".pptx" | grep -v ".jar" |
while read in; do

	is_printing_code=false;
	output=$(git --no-pager blame -M -C -w --line-porcelain "$in")

	echo "Analyzing $in ... ($current_file_counter/$total_number_of_files)"

	# append file title
	echo "## $in" >> "$outfile"

	# append code start
	echo "\`\`\`" >> "$outfile"
	printf '%s\n' "$output" | 
	while IFS= read -r line; do
		# skipping irrelevant metadata
		if [[ $line =~ [0-9a-f]{40}.* ]]; then continue; fi
		if [[ $line =~ committer.* ]]; then continue; fi
		if [[ $line =~ author-.* ]]; then continue; fi
		if [[ $line =~ summary.* ]]; then continue; fi
		if [[ $line =~ filename.* ]]; then continue; fi
		if [[ $line =~ boundary.* ]]; then continue; fi

		# if the line is written by the speficified author,
		# set the flag to true, ignore the current author line but print the actual code in next iteration
		if [[ $line =~ author[[:space:]].* ]]; then
			line_author=$(echo "$line" | sed 's/author //')

			if [[ $line_author == $author ]]; then
				is_printing_code=true;
			fi

			continue
		fi

		if [[ $is_printing_code == true ]]; then
			printf '%s\n' "$line" | sed 's/\t//' >> "$outfile"
			is_printing_code=false
		fi
		
	done 

	# append code end
	echo "\`\`\`" >> "$outfile"

	current_file_counter=$((current_file_counter+1))
done

echo "Done!"