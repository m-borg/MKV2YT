#!/bin/bash

# Path to the static image
image="image.png"

# Check if the image file exists
if [[ ! -f "$image" ]]; then
  echo "Error: Static image '$image' not found."
  exit 1
fi

# Loop through all .mkv files in the current directory
for audio_file in *.mkv; do
  # Check if there are any .mkv files
  if [[ ! -e "$audio_file" ]]; then
    echo "No .mkv files found in the current directory."
    exit 1
  fi

  # Extract the base name without extension
  base_name="${audio_file%.*}"

  # Define the output file name
  output_file="${base_name}_youtube.mkv"

  # Execute ffmpeg command to combine audio and static image
  ffmpeg -loop 1 -framerate 1 -i "$image" -i "$audio_file" \
    -c:v libx264 -preset medium -crf 23 -c:a copy \
    -shortest "$output_file"
done
