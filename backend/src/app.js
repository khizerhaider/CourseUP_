const express = require('express');
const mongoose = require('mongoose');
const videoRoutes = require('./routes/videoRoutes');
const courseRoutes = require('./routes/courseRoutes');
const cloudinary = require('./routes/cloud.js'); // Ensure this is correctly set up
const cors = require('cors');
require('dotenv').config();
const app = express();
app.use(cors());
// Middleware
app.use(express.json());



mongoose
  .connect(process.env.MONGODB_URI, {
    dbName: 'course_app',
    useNewUrlParser: true,
    useUnifiedTopology: true
  })
  .then(() => {
    console.log('MongoDB Atlas connected successfully');
    console.log('Database:', mongoose.connection.name);
  })
  .catch((err) => {
    console.error('MongoDB connection error:', err);
    process.exit(1);
  });
// Connect to MongoDB
// mongoose
//   .connect('mongodb://localhost:27017/course_app', { useNewUrlParser: true, useUnifiedTopology: true })
//   .then(() => console.log('Connected to MongoDB'))
//   .catch((err) => console.error('Failed to connect to MongoDB:', err));

// Routes
app.use('/api/videos', videoRoutes);
app.use('/api/courses', courseRoutes); // Register the course routes
app.use('api/cloud', cloudinary)
app.get('/health', (req, res) => {
  res.status(200).json({ 
    status: 'OK', 
    database: mongoose.connection.readyState === 1 ? 'Connected' : 'Disconnected',
    timestamp: new Date().toISOString()
  });
});
// Start the server
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
  console.log(`Health check available at http://localhost:${PORT}/health`);
});