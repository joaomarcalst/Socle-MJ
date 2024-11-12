#!/bin/bash

# Function to replace spaces with underscores and remove non-alphanumeric characters
sanitize_filename() {
    echo "$1" | tr ' ' '_' | tr -cd '[:alnum:]_'
}

# Check if a book number is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <Gutenberg ebook number>"
    exit 1
fi

# Fetch the ebook content from Gutenberg, following redirects with -L
BOOK_NUM=$1
URL="https://www.gutenberg.org/ebooks/${BOOK_NUM}.txt.utf-8"
TEXT=$(curl -sL "$URL")  # Use -L to follow redirects

# Check if the download was successful
if [ $? -ne 0 ] || [ -z "$TEXT" ]; then
    echo "Failed to fetch the ebook. Please check the book number."
    exit 1
fi

# Display the first few lines of the text for debugging purposes
echo "First few lines of the fetched text:"
echo "$TEXT" | head -n 20  # Display the first 20 lines to check the structure

# Extract the title using multiple patterns (for flexibility)
TITLE=$(echo "$TEXT" | grep -m 1 -E '^Title: ' | sed 's/^Title: //')

# If no title is found, use a default filename
if [ -z "$TITLE" ]; then
    echo "Failed to find the title in the ebook."
    TITLE="gutenberg_book_${BOOK_NUM}"
fi

# Sanitize the title to use as the filename
FILENAME=$(sanitize_filename "$TITLE")
FILENAME="${FILENAME}.txt"

# Customizable text boundary markers
START_MARKER="START OF THIS PROJECT GUTENBERG EBOOK"
END_MARKER="END OF THIS PROJECT GUTENBERG EBOOK"

# Find the lines that indicate the start and end of the main content
START_LINE=$(echo "$TEXT" | grep -n "$START_MARKER" | cut -d: -f1)
END_LINE=$(echo "$TEXT" | grep -n "$END_MARKER" | cut -d: -f1)

if [ -z "$START_LINE" ] || [ -z "$END_LINE" ]; then
    echo "Failed to find the text boundaries. Saving the full text."
    echo "$TEXT" > "$FILENAME"
else
    # Prune the text and save it to a file
    echo "$TEXT" | sed -n "${START_LINE},${END_LINE}p" > "$FILENAME"
fi

echo "Text saved to $FILENAME."

# Count the number of sentences and words in the pruned text
NUM_SENTENCES=$(grep -o '\.' "$FILENAME" | wc -l)
NUM_WORDS=$(wc -w < "$FILENAME")
echo "Number of sentences: $NUM_SENTENCES"
echo "Number of words: $NUM_WORDS"

# Create a histogram of the word occurrences
echo "Generating word histogram..."
grep -oE '\w+' "$FILENAME" | tr '[:upper:]' '[:lower:]' | sort | uniq -c | sort -nr > "${FILENAME%.txt}_histogram.txt"
echo "Word histogram saved to ${FILENAME%.txt}_histogram.txt."