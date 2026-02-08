import 'package:flutter/material.dart';

import '../screens/manage_projects_screen.dart';
import '../screens/manage_tasks_screen.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF4A9084),
            ),
            child: Center(
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.folder, color: Colors.black),
            title: const Text('Projects', style: TextStyle(fontSize: 18)),
            onTap: () {
              Navigator.pop(context); // close drawer
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ManageProjectsScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.assignment, color: Colors.black),
            title: const Text('Tasks', style: TextStyle(fontSize: 18)),
            onTap: () {
              Navigator.pop(context); // close drawer
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ManageTasksScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}