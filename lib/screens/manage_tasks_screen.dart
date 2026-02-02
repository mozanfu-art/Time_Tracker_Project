import 'package:flutter/material.dart';

class ManageTasksScreen extends StatelessWidget {
  const ManageTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF512DA8),
        title: const Text('Manage Tasks'),
        leading: const Icon(Icons.arrow_back),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 10),
        children: [
          _buildManageItem('Task A'),
          _buildManageItem('Task B'),
          _buildManageItem('Task C'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context),
        backgroundColor: const Color(0xFFFFD54F),
        child: const Icon(Icons.add, color: Colors.black54),
      ),
    );
  }

  Widget _buildManageItem(String name) {
    return ListTile(
      title: Text(name, style: const TextStyle(fontSize: 18)),
      trailing: const Icon(Icons.delete, color: Color(0xFFE57373)),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Add Task', style: TextStyle(fontSize: 24)),
        content: const TextField(
          decoration: InputDecoration(
            labelText: 'Task Name',
            hintText: 'Task 1',
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Add')),
        ],
      ),
    );
  }
}
