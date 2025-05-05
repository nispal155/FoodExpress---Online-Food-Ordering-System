#!/bin/bash

# Find all JSP files with jakarta.tags.core and replace with the correct URI
find src/main/webapp/WEB-INF/views -name "*.jsp" | xargs grep -l "jakarta.tags.core" | while read file; do
  echo "Fixing $file"
  sed -i '' 's|uri="jakarta.tags.core"|uri="http://java.sun.com/jsp/jstl/core"|g' "$file"
done

# Find all JSP files with jakarta.tags.fmt and replace with the correct URI
find src/main/webapp/WEB-INF/views -name "*.jsp" | xargs grep -l "jakarta.tags.fmt" | while read file; do
  echo "Fixing $file (fmt)"
  sed -i '' 's|uri="jakarta.tags.fmt"|uri="http://java.sun.com/jsp/jstl/fmt"|g' "$file"
done

# Find all JSP files with jakarta.tags.functions and replace with the correct URI
find src/main/webapp/WEB-INF/views -name "*.jsp" | xargs grep -l "jakarta.tags.functions" | while read file; do
  echo "Fixing $file (functions)"
  sed -i '' 's|uri="jakarta.tags.functions"|uri="http://java.sun.com/jsp/jstl/functions"|g' "$file"
done

echo "All taglib URIs have been updated."
