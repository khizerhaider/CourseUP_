const express = require('express');
const router = express.Router();

// Import controllers
const someController = require('../controllers/index');

// Define routes
router.get('/', (req, res) => {
    res.send('Welcome to the API');
});

// Example route
//router.get('/example', someController.exampleFunction);

module.exports = router;