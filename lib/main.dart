import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'models/time_entry.dart';
import 'screens/add_time_entry_screen.dart';
import 'widgets/side_menu.dart';

void main() => runApp(const TimeTrackingApp());

class TimeTrackingApp extends StatelessWidget {
  const TimeTrackingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: const Color(0xFF4A9084)),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<TimeEntry> _entries = []; // Start empty to see empty state

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4A9084),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.black87),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: const Text('Time Tracking', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFFFFD54F),
          indicatorWeight: 4,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          tabs: const [Tab(text: 'All Entries'), Tab(text: 'Grouped by Projects')],
        ),
      ),
      drawer: const SideMenu(),
      body: TabBarView(
        controller: _tabController,
        children: [_buildAllEntries(), _buildGroupedEntries()],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddEntryScreen()),
          );
          if (result != null) setState(() => _entries.add(result));
        },
        backgroundColor: const Color(0xFFFFD54F),
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }

  Widget _buildAllEntries() {
    if (_entries.isEmpty) return _buildEmptyState();
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: _entries.length,
      itemBuilder: (context, index) {
        final entry = _entries[index];
        return Card(
          child: ListTile(
            title: Text('${entry.project} - ${entry.task}', style: const TextStyle(color: Color(0xFF4A9084), fontWeight: FontWeight.bold)),
            subtitle: Text('Total Time: ${entry.hours.toInt()} hours\nDate: ${DateFormat('MMM dd, yyyy').format(entry.date)}\nNote: ${entry.note}'),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.redAccent),
              onPressed: () => setState(() => _entries.removeAt(index)),
            ),
          ),
        );
      },
    );
  }

  Widget _buildGroupedEntries() {
    if (_entries.isEmpty) return _buildEmptyState();
    Map<String, List<TimeEntry>> grouped = {};
    for (var e in _entries) { grouped.putIfAbsent(e.project, () => []).add(e); }

    return ListView(
      padding: const EdgeInsets.all(12),
      children: grouped.entries.map((group) => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(group.key, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF4A9084))),
              ...group.value.map((e) => Text('- ${e.task}: ${e.hours.toInt()} hours (${DateFormat('MMM dd, yyyy').format(e.date)})'))
            ],
          ),
        ),
      )).toList(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.hourglass_empty, size: 80, color: Colors.black26),
          Text('No time entries yet!', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black54)),
          Text('Tap the + button to add your first entry.', style: TextStyle(color: Colors.black38)),
        ],
      ),
    );
  }
}
