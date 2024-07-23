# Users Login Register JWT API

The "Users Login Register JWT API" project provides an API for user registration, login, and profile management using JWT for authentication.

## Endpoints

### User Registration and Login

- `POST /api/v1/register`
  - Registers a new user.
  - Request body: ` {"user": {
        "email": "test.email@sub.domain.com",
        "password": "123456"
    }}`

    Example:
    ```sh
    curl "http://localhost:3000/api/v1/register" --header "Content-Type: application/json" --data-raw "{\"user\": {\"email\": \"test.email@sub.domain.com\", \"password\": \"123456\"}}"
    ```

- `POST /api/v1/login`
  - Logs in an existing user.
  - Request body: `{ "email": "user@example.com", "password": "password123" }`

  Example: 
  ```sh
    curl "http://localhost:3000/api/v1/login" --header "Content-Type: application/json" --data-raw "{\"email\": \"test.email@sub.domain.com\", \"password\": \"123456\"}"
  ```

### Profile Management

- `PUT /api/v1/profile`
  - Updates the user profile.
  - Request body: `{ "email": "newemail@example.com", "password": "newpassword123" }`

  Example: /Don't forget to change user[email], user[password] and user[avatar] and token /You can get such from the successful login response/ with your own
  ```sh
      curl --request PUT "http://localhost:3000/api/v1/profile" --header "Authorization: Bearer YOUR_TOKEN" --form "user[email]=test1@abv.bg" --form "user[password]=123456" --form     "user[avatar]=@\"C:/Users/User/Pictures/MTEDOsdYQt63V6sym9dErg.webp\""
  ``` 

- `DELETE /api/v1/profile`
  - Deletes the user profile.
 
  Example: /Don't forget to put your token here. You can get such from the successful login response/
  ```sh
  curl --request DELETE "http://localhost:3000/api/v1/profile" --header "Authorization: Bearer YOUR_TOKEN"
  ```

- `DELETE /api/v1/profile/avatar`
  - Deletes the user's avatar.
 
  Example: /Don't forget to put your token here. You can get such from the successful login response/
  ```sh
    curl --request DELETE "http://localhost:3000/api/v1/profile/avatar" --header "Authorization: Bearer YOUR_TOKEN"
  ```

### User List

- `GET /api/v1/users/list`
  - Returns a list of all users.

    Example: /Don't forget to put your token here. You can get such from the successful login response/
    ```sh
      curl "http://localhost:3000/api/v1/users/list" --header "Authorization: Bearer YOUR_TOKEN"
    ```

## Installation

1. Clone the repository:
   ```sh
   git clone https://github.com/<username>/users-login-register-jwt-api.git
   cd users-login-register-jwt-api

2. Install dependencies:
   ```sh
     bundle install
   ```

3. Create and migrate the database:
  ```sh
    rails db:create
    rails db:migrate
  ```

4. Start the server:
   ```sh
     rails server
    ```

