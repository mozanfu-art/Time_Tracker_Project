import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

import '../provider/time_entry_provider.dart';
import '../models/time_entry.dart';
import '../models/project.dart';
import '../models/task.dart';

class AddEntryScreen extends StatefulWidget {
  const AddEntryScreen({super.key});

  @override
  State<AddEntryScreen> createState() => _AddEntryScreenState();
}

class _AddEntryScreenState extends State<AddEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedProject;
  String? _selectedTask;
  final _projectController = TextEditingController();
  final _taskController = TextEditingController();
  final _hoursController = TextEditingController();
  final _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  void dispose() {
    _projectController.dispose();
    _taskController.dispose();
    _hoursController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _saveEntry(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final provider = Provider.of<TimeEntryProvider>(context, listen: false);
      final uuid = const Uuid();

      // Project
      Project project;
      if (_projectController.text.trim().isNotEmpty) {
        project = Project(
          id: uuid.v4(),
          name: _projectController.text.trim(),
          description: '',
          createdAt: DateTime.now(),
        );
        provider.addProject(project);
      } else {
        project = provider.projects.firstWhere(
          (p) => p.id == _selectedProject!,
          orElse: () => Project(
            id: uuid.v4(),
            name: 'Unknown Project',
            description: '',
            createdAt: DateTime.now(),
          ),
        );
      }

      // Task
      Task task;
      if (_taskController.text.trim().isNotEmpty) {
        task = Task(
          id: uuid.v4(),
          name: _taskController.text.trim(),
          description: '',
          createdAt: DateTime.now(),
        );
        provider.addTask(task);
      } else {
        task = provider.tasks.firstWhere(
          (t) => t.id == _selectedTask!,
          orElse: () => Task(
            id: uuid.v4(),
            name: 'Unknown Task',
            description: '',
            createdAt: DateTime.now(),
          ),
        );
      }

      final newEntry = TimeEntry(
        id: uuid.v4(),
        projectId: project.id,
        taskId: task.id, // ✅ always passed now
        project: project.name,
        task: task.name,
        date: _selectedDate,
        hours: double.tryParse(_hoursController.text.trim()) ?? 0,
        note: _noteController.text.trim(),
      );

      provider.addTimeEntry(newEntry);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TimeEntryProvider>(context);
    final projects = provider.projects;
    final tasks = provider.tasks;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4A9084),
        title: const Text('Add Time Entry'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _projectController,
                decoration: InputDecoration(
                  labelText: 'Project',
                  border: const OutlineInputBorder(),
                  suffixIcon: projects.isNotEmpty
                      ? PopupMenuButton<String>(
                          icon: const Icon(Icons.arrow_drop_down),
                          onSelected: (val) {
                            setState(() {
                              _selectedProject = val;
                              _projectController.text = projects
                                  .firstWhere((p) => p.id == val)
                                  .name;
                            });
                          },
                          itemBuilder: (context) => projects
                              .map((p) => PopupMenuItem<String>(
                                    value: p.id,
                                    child: Text(p.name),
                                  ))
                              .toList(),
                        )
                      : null,
                ),
                validator: (val) =>
                    val == null || val.trim().isEmpty ? 'Enter a project' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _taskController,
                decoration: InputDecoration(
                  labelText: 'Task',
                  border: const OutlineInputBorder(),
                  suffixIcon: tasks.isNotEmpty
                      ? PopupMenuButton<String>(
                          icon: const Icon(Icons.arrow_drop_down),
                          onSelected: (val) {
                            setState(() {
                              _selectedTask = val;
                              _taskController.text = tasks
                                  .firstWhere((t) => t.id == val)
                                  .name;
                            });
                          },
                          itemBuilder: (context) => tasks
                              .map((t) => PopupMenuItem<String>(
                                    value: t.id,
                                    child: Text(t.name),
                                  ))
                              .toList(),
                        )
                      : null,
                ),
                validator: (val) =>
                    val == null || val.trim().isEmpty ? 'Enter a task' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _hoursController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Hours',
                  border: OutlineInputBorder(),
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please enter hours';
                  }
                  if (double.tryParse(val) == null) {
                    return 'Enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _noteController,
                decoration: const InputDecoration(
                  labelText: 'Note',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                title: Text(
                  'Date: ${DateFormat('MMM dd, yyyy').format(_selectedDate)}',
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null) {
                      setState(() => _selectedDate = picked);
                    }
                  },
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => _saveEntry(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A9084),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text('Save Entry',
                    style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}