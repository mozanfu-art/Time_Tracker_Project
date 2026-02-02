import 'package:flutter/material.dart';

class GroupedEntriesScreen extends StatelessWidget {
  const GroupedEntriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF4A9084),
        title: const Text('Time Tracking', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Tab Bar Simulation
          Container(
            color: const Color(0xFF4A9084),
            child: Row(
              children: [
                const Expanded(child: Center(child: Text('All Entries', style: TextStyle(color: Colors.white70)))),
                Expanded(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text('Grouped by Projects', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                      Container(height: 4, color: const Color(0xFFFFD54F)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildGroupCard('Project Gamma', ['- Task A: 1 hours (Nov 23, 2024)']),
                _buildGroupCard('Project Alpha', [
                  '- Task 1: 12 hours (Nov 23, 2024)',
                  '- Task C: 3 hours (Nov 23, 2024)',
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupCard(String projectTitle, List<String> tasks) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(projectTitle, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF4A9084))),
          const SizedBox(height: 12),
          ...tasks.map((task) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(task, style: const TextStyle(fontSize: 15, color: Colors.black87)),
          )),
        ],
      ),
    );
  }
}
