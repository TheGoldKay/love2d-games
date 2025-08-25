#!/usr/bin/bash

for file in *.moon; do 
    moonc "$file"
done
love .