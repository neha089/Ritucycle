import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PeriodCard extends StatefulWidget {
  final Function(DateTime) onDateSelected;  // Callback to pass the selected date

  PeriodCard({required this.onDateSelected});

  @override
  _PeriodCardState createState() => _PeriodCardState();
}

class _PeriodCardState extends State<PeriodCard> {
  DateTime? _selectedDate;
  String? _formattedDate;
  final TextEditingController _nameController = TextEditingController();

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate!);
      });
    }
  }

  void _showInputPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Your Name'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => _selectDate(context),
                child: Text(_formattedDate ?? 'Select Last Period Date'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_nameController.text.isNotEmpty && _selectedDate != null) {
                  widget.onDateSelected(_selectedDate!);  // Pass the date back to HomeScreen
                  Navigator.of(context).pop();
                }
              },
              child: Text('Start Tracking'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showInputPopup(context);
      },
      child: Container(
        width: 200,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.pink[100],
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.calendar_today, size: 48, color: Colors.pink[700]),
            SizedBox(height: 10),
            Text(
              'Period Tracker',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.pink[900],
              ),
            ),
          ],
        ),
      ),
    );
  }
}