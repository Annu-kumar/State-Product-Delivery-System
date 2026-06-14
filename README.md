# State Product Promotions and Delivery System

## Overview

The **State Product Promotions and Delivery System** is a web-based platform designed to promote and sell products made within a state. The system helps local producers, artisans, and small businesses showcase their products to customers while providing efficient order and delivery management.

Customers can browse products, place orders, and track deliveries. Sellers can manage their products, while administrators can manage users, products, orders, and promotional activities.

---

## Features

### Customer Features

* User Registration and Login
* Browse State Products
* Search Products
* View Product Details
* Add Products to Cart
* Place Orders
* Track Order Status

### Seller Features

* Add New Products
* Update Product Information
* Manage Inventory
* View Customer Orders

### Admin Features

* Manage Users
* Manage Products
* Manage Sellers
* Manage Promotions
* Monitor Orders and Deliveries

### Delivery Features

* Order Tracking
* Delivery Status Updates
* Shipment Monitoring

---

## Technology Stack

### Frontend

* HTML
* CSS
* JavaScript

### Backend

* Java
* Spring Boot

### Database

* MySQL

### Development Tools

* Visual Studio Code
* MySQL Workbench
* Git
* GitHub

---

## Project Structure

```text
state-product-promotion-system
│
├── src
│   └── main
│       ├── java
│       │   └── com
│       │       └── stateproduct
│       │           ├── controller
│       │           ├── model
│       │           ├── repository
│       │           ├── service
│       │           └── StateProductApplication.java
│       │
│       └── resources
│           ├── static
│           ├── templates
│           └── application.properties
│
└── pom.xml
```

---

## System Architecture

```text
User
  │
  ▼
Frontend (HTML, CSS, JavaScript)
  │
  ▼
Spring Boot Backend
  │
  ▼
MySQL Database
```

---

## Database Tables

### Users

| Field    | Description               |
| -------- | ------------------------- |
| id       | Unique User ID            |
| name     | User Name                 |
| email    | User Email                |
| password | User Password             |
| role     | Customer / Seller / Admin |

### Products

| Field       | Description         |
| ----------- | ------------------- |
| id          | Product ID          |
| name        | Product Name        |
| category    | Product Category    |
| price       | Product Price       |
| description | Product Description |

### Orders

| Field      | Description      |
| ---------- | ---------------- |
| id         | Order ID         |
| user_id    | Customer ID      |
| product_id | Product ID       |
| quantity   | Quantity Ordered |
| status     | Order Status     |

### Sellers

| Field           | Description         |
| --------------- | ------------------- |
| seller_id       | Seller ID           |
| seller_name     | Seller Name         |
| contact_details | Contact Information |

---

## Installation

### Prerequisites

* JDK 17 or above
* MySQL Server
* Maven
* Visual Studio Code

### Setup Steps

1. Clone the repository:

```bash
git clone https://github.com/your-username/state-product-promotion-system.git
```

2. Open the project in Visual Studio Code.

3. Configure database settings in:

```text
src/main/resources/application.properties
```

Example:

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/state_products
spring.datasource.username=root
spring.datasource.password=your_password

spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true
```

4. Run the application:

```bash
mvn spring-boot:run
```

5. Open the application in your browser:

```text
http://localhost:8080
```

---

## Future Enhancements

* Online Payment Gateway Integration
* Mobile Application Support
* AI-Based Product Recommendations
* Delivery Partner API Integration
* Real-Time Notifications
* Product Review and Rating System

---

## Author

**Annu Kumar**
B.Tech Computer Science & Engineering
Software Engineering Project

---

## License

This project is developed for educational and academic purposes.
