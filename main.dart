import 'package:flutter/material.dart';

void main() {
  runApp(const ToDoListApp());
}

class ToDoListApp extends StatelessWidget {
  const ToDoListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter To-Do List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ToDoListScreen(),
    );
  }
}

class ToDoListScreen extends StatefulWidget {
  const ToDoListScreen({super.key});

  @override
  State<ToDoListScreen> createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  final List<Map<String, String>> _tasks = [];
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  // Function to add a new task
  void _addTask() {
    if (_titleController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty) {
      setState(() {
        _tasks.add({
          'title': _titleController.text,
          'description': _descriptionController.text,
        });
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Task "${_titleController.text}" added successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      _titleController.clear();
      _descriptionController.clear();
      Navigator.of(context).pop(); 
    }
  }

  // Function to delete a task
  void _deleteTask(int index) {
    setState(() {
      String deletedTaskTitle = _tasks[index]['title']!;
      _tasks.removeAt(index);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Task "$deletedTaskTitle" deleted!'),
          backgroundColor: Colors.red,
        ),
      );
    });
  }

  // Show the dialog to add a new task
  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Add New Task'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Task Title'),
                ),
                TextField(
                  controller: _descriptionController,
                  decoration:
                      const InputDecoration(labelText: 'Task Description'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: _addTask,
              child: const Text('Add Task'),
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
        title: const Text("To-Do List"),
      ),
      body: _tasks.isEmpty
          ? const Center(
              child: Text('No tasks available. Add a new task.'),
            )
          : ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: InkWell(
                    onTap: () {
                      // Additional functionality can be added here on tap
                    },
                    onHover: (isHovering) {
                      setState(() {});
                    },
                    child: Card(
                      elevation: 5,
                      child: ListTile(
                        title: Text(_tasks[index]['title']!),
                        subtitle: Text(_tasks[index]['description']!),
                        trailing: IconButton(
                          onPressed: () {
                            _deleteTask(index);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
