const express = require('express');
const router = express.Router();
const Message = require('../models/Message');


// Get all messages
router.get('/', async (req, res) => {
  try {
    console.log('GET /messages');
    const messages = await Message.find();
    res.json(messages);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

// Post a new message
router.post('/', async (req, res) => {
  console.log('POST /messages');  
  const { user, text } = req.body;
  const newMessage = new Message({ user, text });

  try {
    const savedMessage = await newMessage.save();
    res.status(201).json(savedMessage);
  } catch (err) {
    res.status(400).json({ message: err.message });
  }
});

module.exports = router;
