#!/bin/bash

# Find all Java files with javax imports
FILES=$(find src -type f -name "*.java" -exec grep -l "import javax" {} \;)

# Loop through each file and replace javax with jakarta
for file in $FILES; do
  echo "Processing $file..."
  
  # Replace javax.servlet with jakarta.servlet
  sed -i '' 's/import javax\.servlet/import jakarta.servlet/g' "$file"
  
  # Replace javax.annotation with jakarta.annotation
  sed -i '' 's/import javax\.annotation/import jakarta.annotation/g' "$file"
  
  # Replace javax.mail with jakarta.mail
  sed -i '' 's/import javax\.mail/import jakarta.mail/g' "$file"
  
  # Replace javax.activation with jakarta.activation
  sed -i '' 's/import javax\.activation/import jakarta.activation/g' "$file"
  
  echo "Completed processing $file"
done

echo "Conversion complete!"
