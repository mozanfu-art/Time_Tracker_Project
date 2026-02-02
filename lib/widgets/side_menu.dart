import 'package:flutter/material.dart';
import '../screens/project_management_screen.dart';
import '../screens/manage_tasks_screen.dart';
import '../screens/local_storage_debug_screen.dart';
import '../screens/local_storage_empty_screen.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Teal Header
          Container(
            width: double.infinity,
            height: 200,
            color: const Color(0xFF4A9084),
            alignment: Alignment.center,
            child: const Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w400),
            ),
          ),
          // Navigation Items
          ListTile(
            leading: const Icon(Icons.folder, color: Colors.black),
            title: const Text('Projects', style: TextStyle(fontSize: 18)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ManageProjectsScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.assignment, color: Colors.black),
            title: const Text('Tasks', style: TextStyle(fontSize: 18)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ManageTasksScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.storage, color: Colors.black),
            title: const Text('Local Storage Filled', style: TextStyle(fontSize: 18)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LocalStorageFilledScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.storage, color: Colors.black),
            title: const Text('Local Storage Empty', style: TextStyle(fontSize: 18)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LocalStorageEmptyScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
