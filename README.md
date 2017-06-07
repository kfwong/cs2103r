# Extracting source code metadata from git version control

This repository contains the prototype program that illustrate the use of git blame. It extracts lines of code contributed by an author into a single file.

## Usage
Download `run.sh` and place it under your project root directory. Run the following command:
```
./run.sh <author_name> <output_filename>
```
Note that the project must be tracked by git, otherwise the script will not work.

Currently the script works only in Unix (Linux/Mac) platform. 
