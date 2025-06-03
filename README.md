# Mobile App Project

This project is a mobile application built with a Flutter frontend and a Node.js backend. The application is designed to provide a seamless user experience and efficient data handling.

## Project Structure

The project is organized into two main directories: `backend` and `frontend`.

### Backend

The backend is built using Node.js and Express. It handles API requests and manages data interactions.

- `src/app.js`: The main entry point for the backend application.
- `src/controllers/index.js`: Contains the logic for handling requests.
- `src/routes/index.js`: Defines the API routes.
- `src/models/index.js`: Contains the data models.

### Frontend

The frontend is developed using Flutter, providing a rich user interface for the mobile application.

- `lib/main.dart`: The main entry point for the Flutter application.
- `lib/screens/home_screen.dart`: The home screen of the application.
- `lib/widgets/custom_widget.dart`: Custom widgets used throughout the app.

## Getting Started

### Prerequisites

- Node.js and npm installed for the backend.
- Flutter SDK installed for the frontend.

### Installation

1. Clone the repository:
   ```
   git clone <repository-url>
   ```

2. Navigate to the backend directory and install dependencies:
   ```
   cd backend
   npm install
   ```

3. Navigate to the frontend directory and install dependencies:
   ```
   cd frontend
   flutter pub get
   ```

### Running the Application

- To start the backend server, run:
  ```
  cd backend
  node src/app.js
  ```

- To run the Flutter application, use:
  ```
  cd frontend
  flutter run
  ```

## Contributing

Contributions are welcome! Please open an issue or submit a pull request for any improvements or bug fixes.

## License

This project is licensed under the MIT License. See the LICENSE file for details.