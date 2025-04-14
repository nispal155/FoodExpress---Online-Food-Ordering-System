# Database Normalization for Food Express Online Food Ordering System

This document outlines the normalization process for the Food Express Online Food Ordering System database, from Unnormalized Form (UNF) to Third Normal Form (3NF).

## Unnormalized Form (UNF)

In the unnormalized form, we might have a single table containing all the data for an order:

**Orders_UNF**
| OrderID | CustomerName | CustomerEmail | CustomerPhone | CustomerAddress | RestaurantName | RestaurantAddress | MenuItemName | MenuItemPrice | MenuItemCategory | Quantity | OrderDate | DeliveryPersonName | DeliveryPersonPhone | OrderStatus | PaymentMethod | PaymentStatus | TotalAmount |
|---------|--------------|---------------|---------------|-----------------|----------------|-------------------|--------------|---------------|------------------|----------|-----------|-------------------|-------------------|-------------|---------------|---------------|-------------|

This table has several issues:
- Redundant data (customer details repeated for each order)
- Multi-valued attributes (multiple menu items per order)
- Functional dependencies that aren't dependent on the primary key

## First Normal Form (1NF)

To achieve 1NF, we need to:
1. Eliminate repeating groups
2. Create separate tables for each set of related data
3. Identify each set of related data with a primary key

**Customers**
| CustomerID | Name | Email | Phone | Address |
|------------|------|-------|-------|---------|

**Restaurants**
| RestaurantID | Name | Address | Rating |
|--------------|------|---------|--------|

**MenuItems**
| MenuItemID | Name | Price | CategoryName | RestaurantID | IsSpecial | DiscountPrice | Description | ImageUrl |
|------------|------|-------|--------------|--------------|-----------|---------------|-------------|----------|

**Orders**
| OrderID | CustomerID | RestaurantID | OrderDate | DeliveryPersonID | OrderStatus | PaymentMethod | PaymentStatus | TotalAmount | DeliveryAddress |
|---------|------------|--------------|-----------|------------------|-------------|---------------|---------------|-------------|-----------------|

**OrderItems**
| OrderItemID | OrderID | MenuItemID | Quantity | Price |
|-------------|---------|------------|----------|-------|

**Users**
| UserID | Username | Password | FullName | Email | Phone | Role | IsActive | LastLogin |
|--------|----------|----------|---------|-------|-------|------|----------|-----------|

## Second Normal Form (2NF)

To achieve 2NF, we need to:
1. Meet all requirements of 1NF
2. Remove subsets of data that apply to multiple rows and place them in separate tables
3. Create relationships between these new tables and their predecessors through foreign keys

Our database is already mostly in 2NF, but we need to extract the category information:

**Categories**
| CategoryID | Name | Description |
|------------|------|-------------|

**MenuItems** (updated)
| MenuItemID | Name | Price | CategoryID | RestaurantID | IsSpecial | DiscountPrice | Description | ImageUrl |
|------------|------|-------|------------|--------------|-----------|---------------|-------------|----------|

## Third Normal Form (3NF)

To achieve 3NF, we need to:
1. Meet all requirements of 2NF
2. Remove columns that are not dependent on the primary key

Let's refine our schema further:

**Customers**
| CustomerID | UserID | Address | DefaultPaymentMethod |
|------------|--------|---------|----------------------|

**Restaurants**
| RestaurantID | Name | Address | Rating | Description | ImageUrl | IsActive | OpeningTime | ClosingTime |
|--------------|------|---------|--------|-------------|----------|----------|-------------|-------------|

**Categories**
| CategoryID | Name | Description |
|------------|------|-------------|

**MenuItems**
| MenuItemID | Name | Price | CategoryID | RestaurantID | IsSpecial | DiscountPrice | Description | ImageUrl | IsAvailable |
|------------|------|-------|------------|--------------|-----------|---------------|-------------|----------|-------------|

**Orders**
| OrderID | CustomerID | RestaurantID | OrderDate | DeliveryPersonID | OrderStatus | PaymentMethod | PaymentStatus | TotalAmount | DeliveryAddress | DeliveryFee | Tax |
|---------|------------|--------------|-----------|------------------|-------------|---------------|---------------|-------------|-----------------|-------------|-----|

**OrderItems**
| OrderItemID | OrderID | MenuItemID | Quantity | Price | SpecialInstructions |
|-------------|---------|------------|----------|-------|---------------------|

**Users**
| UserID | Username | Password | FullName | Email | Phone | Role | IsActive | LastLogin | ProfileImage |
|--------|----------|----------|---------|-------|-------|------|----------|-----------|--------------|

**DeliveryPersons**
| DeliveryPersonID | UserID | VehicleType | LicensePlate | IsAvailable |
|------------------|--------|-------------|--------------|-------------|

**SystemSettings**
| SettingID | SettingName | SettingValue | Description |
|-----------|-------------|--------------|-------------|

## Final Database Schema with Relationships

### Users Table
- Primary Key: UserID
- Contains all user authentication and common profile information
- Used by customers, restaurant staff, delivery personnel, and administrators

### Customers Table
- Primary Key: CustomerID
- Foreign Key: UserID references Users(UserID)
- Contains customer-specific information

### DeliveryPersons Table
- Primary Key: DeliveryPersonID
- Foreign Key: UserID references Users(UserID)
- Contains delivery person-specific information

### Restaurants Table
- Primary Key: RestaurantID
- Contains restaurant information

### Categories Table
- Primary Key: CategoryID
- Contains food categories

### MenuItems Table
- Primary Key: MenuItemID
- Foreign Key: CategoryID references Categories(CategoryID)
- Foreign Key: RestaurantID references Restaurants(RestaurantID)
- Contains menu item information

### Orders Table
- Primary Key: OrderID
- Foreign Key: CustomerID references Customers(CustomerID)
- Foreign Key: RestaurantID references Restaurants(RestaurantID)
- Foreign Key: DeliveryPersonID references DeliveryPersons(DeliveryPersonID)
- Contains order header information

### OrderItems Table
- Primary Key: OrderItemID
- Foreign Key: OrderID references Orders(OrderID)
- Foreign Key: MenuItemID references MenuItems(MenuItemID)
- Contains order line items

### SystemSettings Table
- Primary Key: SettingID
- Contains application configuration settings

## Benefits of This Normalized Schema

1. **Reduced Data Redundancy**: Each piece of information is stored in only one place.
2. **Improved Data Integrity**: Constraints and relationships ensure data consistency.
3. **Smaller Database Size**: Less redundancy means less storage space required.
4. **Better Performance**: Smaller, more focused tables often lead to faster queries.
5. **Easier Maintenance**: Changes to one type of data can be made in just one table.

This normalized database design provides a solid foundation for the Food Express Online Food Ordering System, allowing for efficient data storage and retrieval while maintaining data integrity.
