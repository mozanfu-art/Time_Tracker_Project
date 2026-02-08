import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../provider/time_entry_provider.dart';
import '../widgets/add_project_dialog.dart';

class ManageProjectsScreen extends StatelessWidget {
  const ManageProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TimeEntryProvider>(context);
    final projects = provider.projects;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF512DA8),
        title: const Text('Manage Projects'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: projects.isEmpty
          ? const Center(
              child: Text(
                'No projects yet',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: projects.length,
              itemBuilder: (context, index) {
                final project = projects[index];
                return ListTile(
                  title: Text(project.name,
                      style: const TextStyle(fontSize: 18)),
                  subtitle: Text(
                    '${project.description}\nCreated: ${DateFormat('MMM dd, yyyy').format(project.createdAt)}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Color(0xFFE57373)),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Delete Project'),
                          content: Text(
                              'Are you sure you want to delete "${project.name}"?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancel'),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                              ),
                              onPressed: () {
                                provider.deleteProject(project.id);
                                Navigator.pop(context);
                              },
                              child: const Text('Delete'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const AddProjectDialog(),
          );
        },
        backgroundColor: const Color(0xFFFFD54F),
        child: const Icon(Icons.add, color: Colors.black54),
        tooltip: 'Add Project',
      ),
    );
  }
}