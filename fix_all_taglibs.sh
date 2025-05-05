#!/bin/bash

# Find all JSP files with jakarta.tags.core and replace with the correct URI
find src/main/webapp/WEB-INF/views -name "*.jsp" -exec perl -i -pe 's|uri="jakarta.tags.core"|uri="http://java.sun.com/jsp/jstl/core"|g' {} \;

# Find all JSP files with jakarta.tags.fmt and replace with the correct URI
find src/main/webapp/WEB-INF/views -name "*.jsp" -exec perl -i -pe 's|uri="jakarta.tags.fmt"|uri="http://java.sun.com/jsp/jstl/fmt"|g' {} \;

# Find all JSP files with jakarta.tags.functions and replace with the correct URI
find src/main/webapp/WEB-INF/views -name "*.jsp" -exec perl -i -pe 's|uri="jakarta.tags.functions"|uri="http://java.sun.com/jsp/jstl/functions"|g' {} \;

echo "All taglib URIs have been updated."
