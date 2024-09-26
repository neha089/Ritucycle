import 'package:flutter/material.dart';

class RoutineTracker extends StatefulWidget {
  @override
  _RoutineTrackerState createState() => _RoutineTrackerState();
}

class _RoutineTrackerState extends State<RoutineTracker> {
  double _dietProgress = 0.0;
  double _exerciseProgress = 0.0;

  List<String> dietTasks = [];
  List<bool> dietTaskCompletion = [];

  List<String> exerciseTasks = [];
  List<bool> exerciseTaskCompletion = [];

  // Method to update progress when a task is completed
  void _updateProgress() {
    setState(() {
      _dietProgress = dietTaskCompletion.where((item) => item).length / dietTasks.length;
      _exerciseProgress = exerciseTaskCompletion.where((item) => item).length / exerciseTasks.length;
    });
  }

  // Method to add a new task (either diet or exercise)
  void _addTask(String taskType) {
    TextEditingController _controller = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add $taskType Task'),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: 'Enter your $taskType task'),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (taskType == 'Diet') {
                    dietTasks.add(_controller.text);
                    dietTaskCompletion.add(false);
                  } else if (taskType == 'Exercise') {
                    exerciseTasks.add(_controller.text);
                    exerciseTaskCompletion.add(false);
                  }
                });
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Routine Tracker'),
        backgroundColor: Colors.pink[200],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Progress Bars for Diet & Exercise
            _buildProgressCard('Diet Progress', _dietProgress),
            _buildProgressCard('Exercise Progress', _exerciseProgress),

            SizedBox(height: 20),
            Text(
              'Your Daily Routine',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Buttons to add tasks
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _addTask('Diet'),
                  child: Text('Add Diet Task'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    foregroundColor: Colors.white,

                  ),
                ),
                ElevatedButton(
                  onPressed: () => _addTask('Exercise'),
                  child: Text('Add Exercise Task'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
            // List of tasks and checkboxes
            Expanded(
              child: ListView(
                children: [
                  // Diet Task List
                  _buildTaskList('Diet Tasks', dietTasks, dietTaskCompletion),
                  SizedBox(height: 20),
                  // Exercise Task List
                  _buildTaskList('Exercise Tasks', exerciseTasks, exerciseTaskCompletion),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget for showing progress bar
  Widget _buildProgressCard(String title, double progress) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[200],
              color: Colors.pink,
            ),
            SizedBox(height: 5),
            Text('${(progress * 100).toStringAsFixed(0)}% completed'),
          ],
        ),
      ),
    );
  }

  // Widget to build the task list with checkboxes
  Widget _buildTaskList(String title, List<String> tasks, List<bool> taskCompletion) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        ...tasks.asMap().entries.map((entry) {
          int index = entry.key;
          String task = entry.value;
          return CheckboxListTile(
            title: Text(task),
            value: taskCompletion[index],
            onChanged: (bool? value) {
              setState(() {
                taskCompletion[index] = value!;
                _updateProgress();
              });
            },
          );
        }).toList(),
      ],
    );
  }
}
