const express = require('express');
const logger = require('./logger');

const app = express();
const PORT = process.env.PORT || 10000;

app.get('/', (req, res) => {
  logger.info('Home route accessed', { path: req.path });
  res.send('Hello from NodeJS!');
});

app.get('/error', (req, res) => {
  logger.error('An error occurred!', { path: req.path });
  res.status(500).send('Error occurred!');
});

app.listen(PORT, '0.0.0.0', () => {
  logger.info(`Server is running on port ${PORT}`);
});
