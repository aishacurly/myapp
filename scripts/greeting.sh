#!/bin/bash
NAME="Bob"
DATE=$(date)
echo "Hello $NAME!"
echo "Today is: $DATE"
if [ "$NAME" = "Bob" ]; then
    echo "Welcome back Bob"
else
    echo "Who are you?"
fi
echo "Counting to 5:"
for i in 1 2 3 4 5; do
    echo "  Number: $i"
done
