const express = require('express');
const fs = require('fs');
const path = require('path');

const router = express.Router();

router.get('/*', (req, res) => {
  console.log('Received request for video:', req.path);
  const filePath = path.join(__dirname, '../../public/videos', decodeURIComponent(req.path));
  console.log('Resolved file path:', filePath);

  fs.stat(filePath, (err, stats) => {
    if (err || !stats.isFile()) {
      console.error('Video file error:', err?.message || 'Not a file');
      return res.status(404).send('Video file not found');
    }

    const range = req.headers.range;
    const fileSize = stats.size;

    if (!range) {
      // Send full video with partial content headers
      const head = {
        'Content-Length': fileSize,
        'Content-Type': 'video/mp4',
        'Accept-Ranges': 'bytes',
      };
      res.writeHead(200, head);
      fs.createReadStream(filePath).pipe(res);
    } else {
      const parts = range.replace(/bytes=/, "").split("-");
      const start = parseInt(parts[0], 10);
      const end = parts[1] ? parseInt(parts[1], 10) : fileSize - 1;
      const chunkSize = (end - start) + 1;

      const file = fs.createReadStream(filePath, { start, end });
      const head = {
        'Content-Range': `bytes ${start}-${end}/${fileSize}`,
        'Accept-Ranges': 'bytes',
        'Content-Length': chunkSize,
        'Content-Type': 'video/mp4',
      };
      

      res.writeHead(206, head);
      file.pipe(res);
    }
  });
});

module.exports = router;
