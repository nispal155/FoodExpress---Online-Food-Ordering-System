#!/bin/bash

# Find all JSP files with jakarta.tags.core and update them
find ./src/main/webapp -name "*.jsp" -type f -exec sed -i '' 's/uri="jakarta.tags.core"/uri="http:\/\/java.sun.com\/jsp\/jstl\/core"/g' {} \;

# Find all JSP files with jakarta.tags.fmt and update them
find ./src/main/webapp -name "*.jsp" -type f -exec sed -i '' 's/uri="jakarta.tags.fmt"/uri="http:\/\/java.sun.com\/jsp\/jstl\/fmt"/g' {} \;

echo "All taglib URIs have been updated."
