#!/bin/bash
#-----------------------------
# Title: Create a directory with 25 empty files in a batch
# Description: This script creates a directory with 25 empty files in a batch with filename : yourname+1, yourname+2 etc..
# Author: Vimala 
# usage: ./create_files.sh param1
# param1 : "YourName"
#-----------------------------
# Script body
#
# Set the directory to be created
DIR="/home/ec2-user/companyA/filedirectory"

# Check if the directory exists, if not create it
if [ ! -d "$DIR" ]; then
    echo "Directory does not exist. Creating: $DIR"
    mkdir -p "$DIR"    
else
    echo "Directory already exists: $DIR"    
fi
# create a batch of 25 files every time when it is run
cd "$DIR"
name=$1
last_file=$(ls | sort -V | tail -n 1)
if [ -z "$last_file" ]; then
  for ((i=1; i<=25; i++))
  do
   filename="${name}${i}.txt"
   touch "$filename"
  done
else
  last_number=$(echo $last_file | sed 's/[^0-9]*\([0-9]*\).*/\1/')
  for ((i=last_number+1; i<=(last_number+25); i++))
  do
   filename="${name}${i}.txt"
   touch "$filename"
  done
fi
ls | sort -V
echo "Total number of files created : "$(find . -maxdepth 1 -type f | wc -l)
