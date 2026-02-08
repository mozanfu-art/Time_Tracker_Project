import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../provider/time_entry_provider.dart';
import '../models/time_entry.dart';
import '../models/project.dart';
import '../models/task.dart';

class GroupedEntriesScreen extends StatelessWidget {
  const GroupedEntriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TimeEntryProvider>(
      builder: (context, provider, child) {
        final entries = provider.entries;

        if (entries.isEmpty) {
          return const Center(
            child: Text(
              'No time entries yet!',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        // Group entries by projectId
        final Map<String, List<TimeEntry>> grouped = {};
        for (var e in entries) {
          grouped.putIfAbsent(e.projectId, () => []).add(e);
        }

        return ListView(
          padding: const EdgeInsets.all(12),
          children: grouped.entries.map((group) {
            // Look up project by ID, return dummy if not found
            final project = provider.projects.firstWhere(
              (p) => p.id == group.key,
              orElse: () => Project(
                id: 'unknown',
                name: 'Unknown Project',
                description: '',
                createdAt: DateTime.now(),
              ),
            );

            return Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4A9084),
                      ),
                    ),
                    ...group.value.map((e) {
                      // Look up task by ID, return dummy if not found
                      final task = provider.tasks.firstWhere(
                        (t) => t.id == e.taskId,
                        orElse: () => Task(
                          id: 'unknown',
                          name: 'Unknown Task',
                          description: '',
                          createdAt: DateTime.now(),
                        ),
                      );

                      return Text(
                        '- ${task.name}: ${e.hours.toStringAsFixed(1)} hours '
                        '(${DateFormat('MMM dd, yyyy').format(e.date)})\nNote: ${e.note}',
                      );
                    }),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}