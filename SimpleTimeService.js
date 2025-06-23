require("dotenv").config();

const express = require("express");
const app = express();

// Enable pretty-printing for all JSON responses (2 spaces indentation)
app.set('json spaces', 2);


const port = process.env.port || 3000;

// Define a GET endpoint at root "/"
app.get("/", async (req, res) => {
  // Get the client's IP address
  const ipAddress = req.headers['x-forwarded-for'] || req.socket.remoteAddress;

  // Get current date and time
  const currentDate = new Date();

  // Format the date and time
  const formattedDate = currentDate.toLocaleDateString();
  const formattedTime = currentDate.toLocaleTimeString();

  // Combine date and time into one string
  const varDateTime = `${formattedDate} ${formattedTime}`;

  // Prepare response data object
  const data = {
    timestamp: varDateTime,
    ip: ipAddress
  };

  // Send JSON response with pretty-print enabled
  res.json(data);
});

// Start the server and listen on the specified port
app.listen(port, () => {
  console.log(`Server is running on port: ${port}`);
});
