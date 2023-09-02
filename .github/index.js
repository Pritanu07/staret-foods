// index.js (Express app)

const express = require('express');

const app = express();

// Endpoint 1: /
app.get('/', (req, res) => {
  res.statusCode = 200;
  const msg = 'Hello from staret foods! Demo';
  res.send(msg);
  access_key : process.env.ACCESS_KEY
});

/* // Endpoint 2: /test
app.get('/test', (req, res) => {
  res.statusCode = 200;
  const msg = 'Hello from /test Node!';
  res.send(msg);
});
 */
// Start the server
const server = app.listen(8080, () => {
  console.log('Server started on http://localhost:8080');
});

module.exports = server; // Export server instance for testi