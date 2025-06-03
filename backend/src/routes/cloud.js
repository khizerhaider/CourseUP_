const express = require('express');
const mongoose = require('mongoose');
const Course = require('../models/course');
const Video = require('../models/video');
const Category = require('../models/category');
const fs = require('fs');
const path = require('path');
const multer = require('multer');
//const { 
//   uploadVideo, 
//   uploadImage, 
//   deleteResource, 
//   extractPublicId,
//   getOptimizedVideoUrl 
// } = require('../utils/cloudinary');

const router = express.Router();




// Utility: Convert title to slug
const slugify = (text) =>
  text
    .toString()
    .toLowerCase()
    .trim()
    .replace(/[^\w\s-]/g, '')
    .replace(/\s+/g, '-')
    .replace(/--+/g, '-');

// Helper function to check if string is Cloudinary URL
const isCloudinaryUrl = (url) => {
  return url && url.includes('cloudinary.com');
};



// Get all courses with optional category filter
router.get('/', async (req, res) => {
  try {
    const { category } = req.query;
    
    let categoryFilter = {};
    if (category && category.toLowerCase() !== 'all') {
      const cat = await Category.findOne({ name: { $regex: `^${category.trim()}$`, $options: 'i' } });
      if (cat) {
        categoryFilter.category = cat._id;
      } else {
        return res.status(404).json({ error: 'Category not found' });
      }
    }
    
    const courses = await Course.find(categoryFilter).populate('category').lean();
    const result = courses.map(course => ({
      _id: course._id,
      title: course.title,
      description: course.description,
      slug: slugify(course.title),
      thumbnail: course.thumbnail, // Now contains Cloudinary URL
    }));

    res.status(200).json(result);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch courses' });
  }
});






// Get all categories






module.exports = router;