import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../provider/time_entry_provider.dart';
import '../models/task.dart';

class AddTaskDialog extends StatefulWidget {
  const AddTaskDialog({super.key});

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _saveTask(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final provider = Provider.of<TimeEntryProvider>(context, listen: false);
      final newTask = Task(
        id: const Uuid().v4(),
        name: _nameController.text.trim(),
        description: _descController.text.trim(),
        createdAt: DateTime.now(),
      );
      provider.addTask(newTask);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Task'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Task Name'),
              validator: (val) =>
                  val == null || val.trim().isEmpty ? 'Enter a name' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _descController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () => _saveTask(context),
          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4A9084)),
          child: const Text('Save'),
        ),
      ],
    );
  }
}