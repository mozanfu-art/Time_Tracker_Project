import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../provider/time_entry_provider.dart';
import '../models/project.dart';

class AddProjectDialog extends StatefulWidget {
  const AddProjectDialog({super.key});

  @override
  State<AddProjectDialog> createState() => _AddProjectDialogState();
}

class _AddProjectDialogState extends State<AddProjectDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _saveProject(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final provider = Provider.of<TimeEntryProvider>(context, listen: false);
      final newProject = Project(
        id: const Uuid().v4(),
        name: _nameController.text.trim(),
        description: _descController.text.trim(),
        createdAt: DateTime.now(),
      );
      provider.addProject(newProject);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Project'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Project Name'),
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
          onPressed: () => _saveProject(context),
          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4A9084)),
          child: const Text('Save'),
        ),
      ],
    );
  }
}