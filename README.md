![Mockups](https://github.com/user-attachments/assets/fbe9f39b-4471-4fd0-a9c0-fdecbb6c6f95)# 📚 CourseUp - Online Learning Platform

A **full-stack online learning platform** built with Flutter (frontend) and Node.js (backend). It enables users to browse, stream, and learn from a variety of courses in an intuitive mobile interface.

---

## 📽️ Demo

https://userdomain.com/path/to/demo-video.mp4 <!-- Replace with actual video URL or GitHub video file link -->

![Mockups](https://github.com/user-attachments/assets/946938d4-993e-4f23-adf4-7bf213887c9e)
!-- Replace with actual image URL -->

---

## 🏗️ Project Architecture

This project follows a **client-server architecture**:

- **Frontend**: Flutter mobile application
- **Backend**: Node.js + Express.js REST API

---

## 📁 Directory Structure
courseup/
├── backend/
│ ├── src/
│ │ ├── app.js # Express app configuration
│ │ ├── controllers/ # Business logic
│ │ ├── models/ # Database models
│ │ ├── routes/ # API routes
│ │ └── utils/ # Helper functions
│ └── public/
│ ├── thumbnails/ # Course thumbnails
│ └── videos/ # Course videos
└── frontend/
├── lib/ # Flutter source code
├── assets/ # App assets
└── test/ # Unit tests

---

## ✨ Features

- 📚 Course browsing and filtering by category
- 📺 Video streaming with custom controls
- 🖼️ Thumbnail management and base64 handling
- 🔌 RESTful API integration

---

## 🔗 Backend API Endpoints

### 📘 Courses
- `GET /` — Get all courses (optional category filter)
- `GET /:slug` — Get course details by slug
- `GET /:slug/videos` — Get videos for a specific course

### 📂 Categories
- `GET /categories` — Retrieve all course categories

---

## 🚀 Setup Instructions

### 🔧 Backend

```bash
# Navigate to backend folder
cd backend

# Install dependencies
npm install

# Create a .env file and add:
PORT=5000
MONGODB_URI=your_mongodb_uri

# Start server
npm start
```
📱 Frontend
# Navigate to frontend folder
cd frontend

# Install Flutter dependencies
flutter pub get

# Run the app on device or emulator
flutter run
🧰 Technologies Used
Backend

    Node.js

    Express.js

    MongoDB + Mongoose (MongoDB Atlas)

    Cloudinary (media hosting)

Frontend

    Flutter

    Dart

    media_kit + other Flutter plugins for video playback

🤝 Contributing

    Fork this repository

    Create a feature branch: git checkout -b feature/YourFeature

    Commit your changes: git commit -m "Add your feature"

    Push to the branch: git push origin feature/YourFeature

    Create a Pull Request

📝 License

MIT © 2025 — [YourName or Organization]

---

### ✅ To Finish:

- Upload your **video** and **image** to:
  - GitHub (use Git LFS if >100 MB),
  - or a public file host (like Cloudinary, Vimeo, or your own server),
- Replace the placeholder URLs in the `README`.
