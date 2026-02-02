import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/time_entry.dart';

class AddEntryScreen extends StatefulWidget {
  const AddEntryScreen({super.key});

  @override
  State<AddEntryScreen> createState() => _AddEntryScreenState();
}

class _AddEntryScreenState extends State<AddEntryScreen> {
  String selProject = 'Project Gamma';
  String selTask = 'Task A';
  DateTime selDate = DateTime(2024, 11, 23);
  final TextEditingController _hours = TextEditingController(text: '1');
  final TextEditingController _note = TextEditingController(text: 'new work');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4A9084),
        title: const Text('Add Time Entry'),
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Project'),
            DropdownButton<String>(
              isExpanded: true,
              value: selProject,
              items: ['Project Alpha', 'Project Beta', 'Project Gamma', 'Project 123']
                  .map((val) => DropdownMenuItem(value: val, child: Text(val))).toList(),
              onChanged: (val) => setState(() => selProject = val!),
            ),
            const SizedBox(height: 20),
            const Text('Task'),
            DropdownButton<String>(
              isExpanded: true,
              value: selTask,
              items: ['Task A', 'Task B', 'Task C', 'Task 1', 'Task 2']
                  .map((val) => DropdownMenuItem(value: val, child: Text(val))).toList(),
              onChanged: (val) => setState(() => selTask = val!),
            ),
            const SizedBox(height: 20),
            Text('Date: ${DateFormat('yyyy-MM-dd').format(selDate)}'),
            OutlinedButton(
              onPressed: () async {
                final date = await showDatePicker(context: context, initialDate: selDate, firstDate: DateTime(2020), lastDate: DateTime(2030));
                if (date != null) setState(() => selDate = date);
              },
              child: const Text('Select Date'),
            ),
            const SizedBox(height: 20),
            const Text('Total Time (in hours)'),
            TextField(controller: _hours, keyboardType: TextInputType.number),
            const SizedBox(height: 20),
            const Text('Note'),
            TextField(controller: _note),
            const SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                onPressed: () {
                  final entry = TimeEntry(
                    id: DateTime.now().toString(),
                    projectId: '3',
                    project: selProject,
                    task: selTask,
                    date: selDate,
                    hours: double.tryParse(_hours.text) ?? 0,
                    note: _note.text,
                  );
                  Navigator.pop(context, entry);
                },
                child: const Text('Save Time Entry'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
