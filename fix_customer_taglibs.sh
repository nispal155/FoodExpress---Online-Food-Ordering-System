#!/bin/bash

# Fix the taglib URIs in all customer JSP files
for file in src/main/webapp/WEB-INF/views/customer/*.jsp; do
  echo "Fixing $file"
  sed -i '' 's|uri="jakarta.tags.core"|uri="http://java.sun.com/jsp/jstl/core"|g' "$file"
  sed -i '' 's|uri="jakarta.tags.fmt"|uri="http://java.sun.com/jsp/jstl/fmt"|g' "$file"
  sed -i '' 's|uri="jakarta.tags.functions"|uri="http://java.sun.com/jsp/jstl/functions"|g' "$file"
done

echo "All customer JSP files have been fixed."
