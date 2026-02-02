import 'package:flutter/material.dart';

class AllEntriesScreen extends StatelessWidget {
  const AllEntriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF4A9084),
        elevation: 0,
        leading: const Icon(Icons.menu, color: Colors.black),
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
                Expanded(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text('All Entries', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                      Container(height: 4, color: const Color(0xFFFFD54F)), // Active Indicator
                    ],
                  ),
                ),
                const Expanded(
                  child: Center(
                    child: Text('Grouped by Projects', style: TextStyle(color: Colors.white70)),
                  ),
                ),
              ],
            ),
          ),
          // Hardcoded List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildEntryCard('Project Gamma - Task A', '1 hours', 'Nov 23, 2024', 'new work'),
                _buildEntryCard('Project Alpha - Task 1', '12 hours', 'Nov 23, 2024', 'more work'),
                _buildEntryCard('Project Alpha - Task C', '3 hours', 'Nov 23, 2024', 'final lab'),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFFFFD54F),
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }

  Widget _buildEntryCard(String title, String hours, String date, String note) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF4A9084))),
                const SizedBox(height: 8),
                Text('Total Time: $hours', style: const TextStyle(fontSize: 15, color: Colors.black87)),
                Text('Date: $date', style: const TextStyle(fontSize: 15, color: Colors.grey)),
                Text('Note: $note', style: const TextStyle(fontSize: 15, color: Colors.black87)),
              ],
            ),
          ),
          const Icon(Icons.delete, color: Color(0xFFE57373)), // Specific red from sample
        ],
      ),
    );
  }
}
