const mongoose = require('mongoose');

const videoSchema = new mongoose.Schema({
  title: {
    type: String,
    required: true,
    trim: true,
  },
  description: {
    type: String,
    required: true,
  },
  videoUrl: {
    type: String, // Local file path to the video file
    required: true,
  },
  course: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Course', // Reference to the Course model
    required: true,
  },
});

module.exports = mongoose.model('Video', videoSchema);