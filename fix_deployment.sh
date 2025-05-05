#!/bin/bash

# Clean and rebuild the project
echo "Cleaning and rebuilding the project..."
mvn clean package -DskipTests

# Check if the target directory exists
if [ -d "target" ]; then
  echo "Build successful. WAR file created."
else
  echo "Build failed. Please check Maven output for errors."
  exit 1
fi

# Print instructions for manual deployment
echo ""
echo "=== MANUAL DEPLOYMENT INSTRUCTIONS ==="
echo "1. In IntelliJ IDEA, go to Run > Edit Configurations"
echo "2. Delete any existing Tomcat configurations"
echo "3. Click the + button and select Tomcat Server > Local"
echo "4. Configure the Tomcat installation directory to point to your Tomcat 11 installation"
echo "5. In the Deployment tab, click + and select Artifact"
echo "6. Select 'FoodExpressOnlineFoodOrderingSystem:war exploded'"
echo "7. Set the Application context to '/FoodExpressOnlineFoodOrderingSystem'"
echo "8. Click Apply and OK"
echo "9. Restart IntelliJ IDEA"
echo ""
echo "Alternatively, you can manually deploy the WAR file:"
echo "1. Copy target/FoodExpressOnlineFoodOrderingSystem-1.0-SNAPSHOT.war to your Tomcat webapps directory"
echo "2. Rename it to FoodExpressOnlineFoodOrderingSystem.war"
echo "3. Start or restart Tomcat"
echo ""
echo "Script completed."
