#!/bin/bash 

# This line above tells Linux to run this with bash
# Lines starting with # are comments

# Variables
NAME="Aisha"
DATE=$(date)

# Print to screen
echo "Hello $NAME!" 
echo "Today is: $DATE"

# If statement 
if [ "# If statement
if [ "$NAME" = "Aisha" ]; then
    echo "Welcome back Aisha!"
else
    echo "Who are you?"
fi

# Loop
echo "Counting to 5:"
for i in 1 2 3 4 5; do
    echo "Number: $i"
done


