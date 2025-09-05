# 📂 Mumbai Customers Filter API

A **Ruby on Rails API** to filter customers within a certain radius (default 100 km) of Mumbai office from a JSON file. Includes **service objects**, **distance calculations**, **RSpec tests**, and **Swagger/OpenAPI documentation**.

---

## 📝 Table of Contents

- [Features](#features)  
- [Tech Stack](#tech-stack)  
- [Installation](#installation)  
- [Usage](#usage)  
  - [API Endpoint](#api-endpoint)  
  - [File Format](#file-format)  
- [Testing](#testing)  
- [Swagger Documentation](#swagger-documentation)  
- [Project Structure](#project-structure)  
- [License](#license)  

---

## ✨ Features

- Upload a **JSONL (JSON lines)** file of customers.  
- Filter customers **within 100 km of Mumbai office**.  
- **Sorted results** by `user_id`.  
- Skips **invalid JSON lines** gracefully.  
- Fully **tested** with RSpec.  
- Includes **OpenAPI/Swagger documentation**.  
- Uses **service objects** for clean and maintainable code.  

---

## 💻 Tech Stack

- Ruby 3.0.0  
- Rails 7.1.5  
- PostgreSQL  
- RSpec & Swagger for testing & documentation  
- JSON for input/output  

---

## ⚡ Installation

1. Clone the repository:

git clone git@github.com:dilipcode01/mumbai_customers_filter_api.git
cd mumbai_customers_filter_api

---

## 🚀 Usage

### API Endpoint

- **POST** `/api/v1/customers/invite`
- Accepts a txt file upload containing customer records.
- Returns a list of customers within 100 km of Mumbai office, sorted by `user_id`.

### File Format

- Input file must be in **JSON Lines (JSONL)** format.
- Each line should be a valid JSON object with at least:
  - `user_id` (integer)
  - `name` (string)
  - `latitude` (float)
  - `longitude` (float)
- Example:
  ```json
  {"user_id": 1, "name": "John Doe", "latitude": 19.0760, "longitude": 72.8777}
  {"user_id": 2, "name": "Jane Smith", "latitude": 18.5204, "longitude": 73.8567}
  ```

---

## 🧪 Testing

- Run all tests with:
  ```bash
  bundle exec rspec
  ```
- RSpec covers service objects, controllers, and edge cases.

---

## 📖 Swagger Documentation

- Interactive API docs available at: http://localhost:3000/api-docs
- Describes all endpoints, parameters, and responses.

---

## 🗂 Project Structure

- `app/services/` – Service objects for filtering logic
- `app/controllers/` – API controllers
- `spec/` – RSpec tests
- `docs/` – Swagger/OpenAPI specs

---

## 📄 License

This project is licensed under the MIT License.