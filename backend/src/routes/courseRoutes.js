const express = require('express');
const mongoose = require('mongoose');
const Course = require('../models/course');
const Video = require('../models/video');
const Category = require('../models/category');
const fs = require('fs');
const path = require('path');
const mime = require('mime-types'); // install this with: npm install mime
//const cloudinary = require('../utils/cloudinary');


const baseUrl = 'http://127.0.0.1:5000';
const router = express.Router();

const slugify = (text) =>
  text
    .toString()
    .toLowerCase()
    .trim()
    .replace(/[^\w\s-]/g, '')
    .replace(/\s+/g, '-')
    .replace(/--+/g, '-');


router.get('/', async (req, res) => {
  try {
    const { category } = req.query;
    console.log('Category:', category);
    // If category name is provided, find its _id
    let categoryFilter = {};
    if (category && category.toLowerCase() !== 'all') {
      console.log(`Filtering courses by category: ${category}`);
      const cat = await Category.findOne({ name: { $regex: `^${category.trim()}$`, $options: 'i' } });
      if (cat) {
        categoryFilter.category = cat._id;
      } else {
        console.log(`Category not found: ${category}`);
        return res.status(404).json({ error: 'Category not found' });
      }
    }
    
    const courses = await Course.find(categoryFilter).populate('category').lean();
    console.log('Courses found:', courses.length);
    console.log('Courses:', courses);
    const result = courses.map(course => ({
      _id: course._id,
      title: course.title,
      description: course.description,
      slug: slugify(course.title),
      thumbnail: course.thumbnail,
    }));

    res.status(200).json(result);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch courses' });
  }
});




// GET /api/categories
router.get('/categories', async (req, res) => {
  try {
    const categories = await Category.find().select('name -_id'); // just the name field
    res.json(categories);
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Server error' });
  }
});
// route to get course related to the search
// 
router.get('/search', async (req, res) => {
  const { q } = req.query;  // get search query from ?q=
  console.log('req query : ',req.query)
  if (!q) {
    return res.status(400).json({ message: 'Query parameter q is required' });
  }

  try {
    // Case-insensitive search on name or description fields
    const courses = await Course.find({
      $or: [
        { title: { $regex: q, $options: 'i' } },
        { description: { $regex: q, $options: 'i' } }
      ]
    });

    res.json(courses);
  } catch (error) {
    console.error('Search error:', error);
    res.status(500).json({ message: 'Server error' });
  }
});

// Route: Get course details by slug
router.get('/:slug', async (req, res) => {
  try {
    const { slug } = req.params;
    console.log('Slug:', slug);
    const courses = await Course.find().lean();
    const matched = courses.find(c => slugify(c.title) === slug);

    if (!matched) {
      return res.status(404).json({ error: 'Course not found' });
    }

    const base64Thumbnail = matched.thumbnail;

    // res.status(200).json({
    //   title: matched.title,
    //   description: matched.description,
    //   thumbnail: base64Thumbnail,
    // });
    res.status(200).json({
      title: matched.title,
      description: matched.description,
      thumbnail: matched.thumbnail,
    });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch course details' });
  }
});
router.get('/categories', async (req, res) => {
  // Get all categories
  try {
    const categories = await Category.find().lean();
    const simplified = categories.map(c => ({
      _id: c._id,
      name: c.name,
      //description: c.description,
    }));
    res.status(200).json(simplified);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch categories' });
  }
});


// Route: Get videos for a course by slug
router.get('/:slug/videos', async (req, res) => {
  try {
    const { slug } = req.params;
    console.log('Request paramas to videos:',req.params);
    const courses = await Course.find().lean();
    const matched = courses.find(c => slugify(c.title) === slug);

    if (!matched) {
      return res.status(404).json({ error: 'Course not found' });
    }

    const videos = await Video.find({ course: matched._id }).lean();
    // const simplified = videos.map(v => {
    //   // Extract just the course folder and video file name
    //   const pathParts = v.videoUrl.split('/');
    //   const courseFolder = pathParts.slice(2, -1).join('/'); // skip "public/videos"
    //   const fileName = pathParts[pathParts.length - 1];
    //   const simplified = videos.map(v => ({
    //     title: v.title,
    //     videoUrl: v.videoUrl, // Already a Cloudinary URL
    //     description: v.description,
    //   }));
      
    //   return {
    //     title: v.title,
    //     videoUrl: `http://127.0.0.1:5000/api/videos/${encodeURIComponent(courseFolder)}/${encodeURIComponent(fileName)}`,
    //     description: v.description,
    //   };
    // });
    const simplified = videos.map(v => ({
      title: v.title,
      videoUrl: v.videoUrl, // Already a Cloudinary URL
      description: v.description,
    }));
    
    console.log('Videos:', simplified);
    res.status(200).json(simplified);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch course videos' });
  }
});
module.exports = router;
