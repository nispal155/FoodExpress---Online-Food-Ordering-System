#!/bin/bash

# Find all JSP files in the delivery directory with jakarta.tags.core and replace with the correct URI
find src/main/webapp/WEB-INF/views/delivery -name "*.jsp" -exec sed -i '' 's|uri="jakarta.tags.core"|uri="http://java.sun.com/jsp/jstl/core"|g' {} \;

# Find all JSP files in the delivery directory with jakarta.tags.fmt and replace with the correct URI
find src/main/webapp/WEB-INF/views/delivery -name "*.jsp" -exec sed -i '' 's|uri="jakarta.tags.fmt"|uri="http://java.sun.com/jsp/jstl/fmt"|g' {} \;

# Find all JSP files in the delivery directory with jakarta.tags.functions and replace with the correct URI
find src/main/webapp/WEB-INF/views/delivery -name "*.jsp" -exec sed -i '' 's|uri="jakarta.tags.functions"|uri="http://java.sun.com/jsp/jstl/functions"|g' {} \;

echo "All taglib URIs in delivery JSP files have been updated."
