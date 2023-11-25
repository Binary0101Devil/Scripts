#!/bin/bash

# Define the input and output files
INPUT_FILE="ffuf_output.txt"
OUTPUT_FILE_URL="extracted_urls.txt"
OUTPUT_FILE_ARROW="extracted_arrows.txt"
FFUF_OUTPUT_FILE="final_ffuf_output.txt"

# Extract URLs from the file using awk
awk -F'|' '/URL/ {print $3}' "$INPUT_FILE" > "$OUTPUT_FILE_URL"

# Extract values after --> from the file using awk
awk -F'|' '/-->/ {print $3}' "$INPUT_FILE" > "$OUTPUT_FILE_ARROW"

# Combine and sort extracted files
sort "$OUTPUT_FILE_URL" "$OUTPUT_FILE_ARROW" > "$FFUF_OUTPUT_FILE"

sleep 10
rm -rf "$OUTPUT_FILE_URL" "$OUTPUT_FILE_ARROW"

echo "Extraction and sorting complete. Check $FFUF_OUTPUT_FILE for the sorted output."
