import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/time_entry_provider.dart';
import '../widgets/add_task_dialog.dart';

class TaskManagementScreen extends StatelessWidget {
  const TaskManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TimeEntryProvider>(context);
    final tasks = provider.tasks;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF512DA8),
        title: const Text('Manage Tasks'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: tasks.isEmpty
          ? const Center(
              child: Text(
                'No tasks yet',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return ListTile(
                  title: Text(task.name,
                      style: const TextStyle(fontSize: 18)),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Color(0xFFE57373)),
                    onPressed: () => provider.deleteTask(task.id),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const AddTaskDialog(),
          );
        },
        backgroundColor: const Color(0xFFFFD54F),
        child: const Icon(Icons.add, color: Colors.black54),
        tooltip: 'Add Task',
      ),
    );
  }
}