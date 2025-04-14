# Food Express - Online Food Ordering System

## Project Overview
Food Express is a Java EE web application that allows users to order food online from various restaurants. The system provides a user-friendly interface for customers to browse restaurants, view menus, place orders, and track deliveries.

## Technology Stack
- **Frontend**: JSP (JavaServer Pages), HTML, CSS, JavaScript
- **Backend**: Java Servlets, JDBC
- **Database**: MySQL
- **Build Tool**: Maven
- **Version Control**: Git

## Project Structure
The project follows the MVC (Model-View-Controller) architecture:
- **Model**: Contains data models and database interactions
- **View**: JSP pages for the user interface
- **Controller**: Servlets that handle HTTP requests and responses
- **Service**: Business logic layer
- **Util**: Utility classes for common functionality

## Setup Instructions
1. Clone the repository
2. Create a MySQL database named `foodexpress`
3. Update the database connection properties in `src/main/resources/db.properties` if needed
4. Build the project using Maven: `mvn clean install`
5. Deploy the WAR file to a servlet container like Tomcat

## Features
- User registration and authentication
- Restaurant browsing and searching
- Menu viewing and food item selection
- Shopping cart functionality
- Order placement and tracking
- Payment processing
- User profile management

## License
This project is licensed under the MIT License - see the LICENSE file for details.
