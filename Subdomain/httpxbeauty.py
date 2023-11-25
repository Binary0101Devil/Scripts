# Read the input file
with open('live_subdomains.txt', 'r') as f:
    lines = f.readlines()

# Process the lines
processed_lines = []
for line in lines:
    line = line.split('[')[0].strip()
    processed_lines.append(line)

# Write the processed content to a new file
with open('subdomains.txt', 'w') as f:
    for line in processed_lines:
        f.write("%s\n" % line)
