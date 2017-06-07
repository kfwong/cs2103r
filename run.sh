#!/bin/bash

# user speficied arguments
author=$1 
outfile=$2

# sanity check
if [[ -z $author ]]; then
	echo "Missing parameter for author name."
	exit
fi

if [[ -z $outfile ]]; then
	echo "Missing output filename."
	exit
fi

# upkeep
running_time_start=$(date +%s)

# create a new output file with title
echo "# Code Contributed by $author" > "$outfile"

# count number of files to be analyzed (excluding binary files)
total_number_of_files=$(git ls-files | grep -v ".png" | grep -v "jpg" | grep -v ".pptx" | grep -v ".jar" | wc -l)

# number of files analyzed so far
current_file_counter=1

# list all tracked files, excludeing binary files
git ls-files | grep -v ".png" | grep -v "jpg" | grep -v ".pptx" | grep -v ".jar" |
while read in; do

	line_number_in_file=0
	is_printing_code=false;
	output=$(git --no-pager blame -M -C -w --line-porcelain "$in")

	echo "Analyzing $in ... ($current_file_counter/$total_number_of_files)"

	# append relative path for current file under processing
	echo "## $in" >> "$outfile"

	# append code start
	echo "\`\`\`" >> "$outfile"
	printf '%s\n' "$output" |

	# for each line of porcelain output, do something awesome
	while IFS= read -r line; do
		# skipping irrelevant metadata
		if [[ $line =~ previous.* ]]; then continue; fi
		if [[ $line =~ committer.* ]]; then continue; fi
		if [[ $line =~ author-.* ]]; then continue; fi
		if [[ $line =~ summary.* ]]; then continue; fi
		if [[ $line =~ filename.* ]]; then continue; fi
		if [[ $line =~ boundary.* ]]; then continue; fi

		# extract and store the current line number
		if [[ $line =~ [0-9a-f]{40}.* ]]; then
			 line_number_in_file=$(echo "$line" | grep -Po "[0-9a-f]{40}\s[0-9]+\s\K[0-9]+")
			 continue;
		fi

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
			# append line number and the actual code
			printf '%s\n' "$line_number_in_file$line" >> "$outfile"
			is_printing_code=false
		fi
		
	done 

	# append code end
	echo "\`\`\`" >> "$outfile"

	current_file_counter=$((current_file_counter+1))
done

running_time_end=$(date +%s)
net_running_time=$((running_time_end-running_time_start))

echo "Done! Script finished running in $net_running_time second(s)."