const express = require('express');
const mongoose = require('mongoose');
const http = require('http');
const socketIo = require('socket.io');
const cors = require('cors');
const app = express();
const server = http.createServer(app);
const io = socketIo(server);
const port = 3000;
const mongoURI = 'mongodb://localhost:27017/chat-backend';

// MongoDB connection
mongoose.connect(mongoURI, { useNewUrlParser: true, useUnifiedTopology: true })
  .then(() => console.log('MongoDB connected'))
  .catch(err => console.log('MongoDB connection error:', err));

// Middleware
app.use(cors());
app.use(express.json());

// Routes
const messageRoutes = require('./routes/messages');
const authRoutes = require('./routes/auth'); // Import auth routes
app.use('/api/messages', messageRoutes);
app.use('/api/auth', authRoutes); // Use auth routes

// Socket.IO connection
io.on('connection', (socket) => {
  console.log('New client connected');
  socket.emit('message', { text: 'Welcome to the chat!' });

  socket.on('message', (msg) => {
    io.emit('message', msg);
  });

  socket.on('disconnect', () => {
    console.log('Client disconnected');
  });
});

// Basic route
app.get('/', (req, res) => {
  res.send('Chat backend server is running');
});

// Listen on all interfaces
server.listen(port, '0.0.0.0', () => {
  console.log(`Server is running on http://0.0.0.0:${port}`);
});
