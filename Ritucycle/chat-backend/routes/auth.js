const express = require('express');
const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const router = express.Router();

// User model
const User = require('../models/User'); // Adjust the path according to your project structure

// Register
router.post('/register', async (req, res) => {
    // Log the incoming request body
    console.log(req.body);
  
    const { username, password, email, firstName, lastName, cycleLength, periodLength } = req.body;
  
    // Input validation
    if (!username || !password || !email) {
      return res.status(400).json({ message: 'Username, password, and email are required' });
    }
  
    try {
      const hashedPassword = await bcrypt.hash(password, 10);
      
      const user = new User({ 
        username, 
        password: hashedPassword, 
        email, 
        firstName, 
        lastName, 
        cycleLength, 
        periodLength 
      });
  
      await user.save();
      res.status(201).json({ message: 'User registered', user });
    } catch (err) {
      // Log the error for debugging
      console.error('Error during registration:', err);
      res.status(400).json({ message: 'Registration failed', error: err.message });
    }
  });
  

// Login
router.post('/login', async (req, res) => {
  const { username, password } = req.body;

  const user = await User.findOne({ username });
  if (!user || !(await bcrypt.compare(password, user.password))) {
    return res.status(401).send('Invalid credentials');
  }

  const token = jwt.sign({ id: user._id }, 'your_jwt_secret'); 
  res.json({ token, user: { username: user.username, email: user.email, firstName: user.firstName, lastName: user.lastName } });
});

module.exports = router;
