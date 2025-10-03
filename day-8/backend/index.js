const express = require('express');
const app = express();
const port = process.env.PORT || 5000;

app.get('/api/hello', (req, res) => {
  res.json({ message: 'Hello from backend!', dbHost: process.env.DB_HOST });
});

app.listen(port, () => console.log(`Backend running on ${port}`));
