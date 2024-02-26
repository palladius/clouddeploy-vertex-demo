#! /bin/bash


for INPUT_FILE in inputs/input-boston-*json ; do
    echo "== Testing 💾 $INPUT_FILE =="
    ./test-model.sh "$INPUT_FILE"
done
