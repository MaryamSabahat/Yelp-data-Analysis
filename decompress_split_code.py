#in case if you issues in direct decompressing of yelpdataset
import tarfile
import os

# Path to your .tar file
tar_file_path = 'your_file.tar'

# Destination folder to extract contents
extract_path = 'extracted_files'

# Create the destination folder if it doesn't exist
os.makedirs(extract_path, exist_ok=True)

# Open and extract the tar file
with tarfile.open(tar_file_path, 'r') as tar:
    tar.extractall(path=extract_path)
    print(f"Extracted all files to '{extract_path}'")








#splitting code


import json

input_file = "yelp_academic_dataset_review.json"  # Your 5GB JSON file
output_prefix = "split_file_"  # Prefix for output files
num_files = 10  # Number of files to split into

# Count total lines (objects) in the file
with open(input_file, "r" , encoding="utf8") as f:
    total_lines = sum(1 for _ in f)  

lines_per_file = total_lines // num_files  # Lines per split file

print(f"Total lines: {total_lines}, Lines per file: {lines_per_file}")

# Now split into multiple smaller files
with open(input_file, "r" , encoding="utf8") as f:
    for i in range(num_files):
        output_filename = f"{output_prefix}{i+1}.json"
        
        with open(output_filename, "w", encoding="utf8" ) as out_file:
            for j in range(lines_per_file):
                line = f.readline()
                if not line:
                    break  # Stop if file ends early
                out_file.write(line)

print("✅ JSON file successfully split into smaller parts!")
