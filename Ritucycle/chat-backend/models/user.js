const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
  username: { type: String, required: true, unique: true },
  password: { type: String, required: true },
  email: { type: String, required: true, unique: true },
  firstName: { type: String },
  lastName: { type: String },
  createdAt: { type: Date, default: Date.now },
  profilePicture: { type: String },
  bio: { type: String },
  
  // Fields specific to period tracking
  cycleLength: { type: Number, default: 28 }, // Average cycle length in days
  periodLength: { type: Number, default: 5 }, // Average period length in days
  lastPeriodDate: { type: Date }, // Date of the last period
  ovulationDate: { type: Date }, // Estimated ovulation date
  notes: [{ // User can store notes related to their cycle
    date: { type: Date },
    content: { type: String }
  }],
});

// Indexing for faster searching by username or email
userSchema.index({ username: 1, email: 1 });

module.exports = mongoose.model('User', userSchema);
