#!/bin/bash

# Fix the taglib URIs in all admin JSP files
for file in src/main/webapp/WEB-INF/views/admin/*.jsp; do
  echo "Fixing $file"
  perl -i -pe 's|uri="jakarta.tags.core"|uri="http://java.sun.com/jsp/jstl/core"|g' "$file"
  perl -i -pe 's|uri="jakarta.tags.fmt"|uri="http://java.sun.com/jsp/jstl/fmt"|g' "$file"
  perl -i -pe 's|uri="jakarta.tags.functions"|uri="http://java.sun.com/jsp/jstl/functions"|g' "$file"
done

echo "All admin JSP files have been fixed."
