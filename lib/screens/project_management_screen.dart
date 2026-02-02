import 'package:flutter/material.dart';

class ManageProjectsScreen extends StatelessWidget {
  const ManageProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF512DA8), // Deep purple as seen in sample
        title: const Text('Manage Projects'),
        leading: const Icon(Icons.arrow_back),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 10),
        children: [
          _buildManageItem('Project Alpha'),
          _buildManageItem('Project Beta'),
          _buildManageItem('Project Gamma'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddProjectDialog(context),
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

  void _showAddProjectDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Add Project', style: TextStyle(fontSize: 24)),
        content: const TextField(
          decoration: InputDecoration(
            labelText: 'Project Name',
            hintText: 'Project 123',
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
