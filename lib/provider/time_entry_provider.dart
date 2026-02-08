import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'dart:convert';

import '../models/project.dart';
import '../models/task.dart';
import '../models/time_entry.dart';

class TimeEntryProvider with ChangeNotifier {
  final LocalStorage storage = LocalStorage('time_tracker');

  List<Project> _projects = [];
  List<Task> _tasks = [];
  List<TimeEntry> _entries = [];

  List<Project> get projects => List.unmodifiable(_projects);
  List<Task> get tasks => List.unmodifiable(_tasks);
  List<TimeEntry> get entries => List.unmodifiable(_entries);

  TimeEntryProvider() {
    _loadData();
  }

  Future<void> _loadData() async {
    await storage.ready;
    try {
      final projectsJson = storage.getItem('projects');
      final tasksJson = storage.getItem('tasks');
      final entriesJson = storage.getItem('entries');

      if (projectsJson != null) {
        final List<dynamic> projectsList = json.decode(projectsJson);
        _projects = projectsList
            .map((json) => Project.fromJson(json as Map<String, dynamic>))
            .toList();
      }

      if (tasksJson != null) {
        final List<dynamic> tasksList = json.decode(tasksJson);
        _tasks = tasksList
            .map((json) => Task.fromJson(json as Map<String, dynamic>))
            .toList();
      }

      if (entriesJson != null) {
        final List<dynamic> entriesList = json.decode(entriesJson);
        _entries = entriesList
            .map((json) => TimeEntry.fromJson(json as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      debugPrint('Error loading data: $e');
    }
    notifyListeners();
  }

  Future<void> _saveData() async {
    await storage.ready;
    await storage.setItem(
        'projects', json.encode(_projects.map((p) => p.toJson()).toList()));
    await storage.setItem(
        'tasks', json.encode(_tasks.map((t) => t.toJson()).toList()));
    await storage.setItem(
        'entries', json.encode(_entries.map((e) => e.toJson()).toList()));
  }

  Future<void> _updateState() async {
    await _saveData();
    notifyListeners();
  }

  // ------------------ Project Methods ------------------
  void addProject(Project project) {
    if (_projects.any((p) => p.id == project.id)) return;
    _projects.add(project);
    _updateState();
  }

  void updateProject(Project updated) {
    final index = _projects.indexWhere((p) => p.id == updated.id);
    if (index != -1) {
      _projects[index] = updated;
      _updateState();
    }
  }

  void deleteProject(String id) {
    _projects.removeWhere((project) => project.id == id);
    _entries.removeWhere((entry) => entry.projectId == id); // cascade delete
    _updateState();
  }

  // ------------------ Task Methods ------------------
  void addTask(Task task) {
    if (_tasks.any((t) => t.id == task.id)) return;
    _tasks.add(task);
    _updateState();
  }

  void updateTask(Task updated) {
    final index = _tasks.indexWhere((t) => t.id == updated.id);
    if (index != -1) {
      _tasks[index] = updated;
      _updateState();
    }
  }

  void deleteTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    _entries.removeWhere((entry) => entry.taskId == id); // cascade delete
    _updateState();
  }

  // ------------------ TimeEntry Methods ------------------
  void addTimeEntry(TimeEntry entry) {
    if (_entries.any((e) => e.id == entry.id)) return;
    _entries.add(entry);
    _updateState();
  }

  void updateTimeEntry(TimeEntry updated) {
    final index = _entries.indexWhere((e) => e.id == updated.id);
    if (index != -1) {
      _entries[index] = updated;
      _updateState();
    }
  }

  void deleteTimeEntry(String id) {
    _entries.removeWhere((entry) => entry.id == id);
    _updateState();
  }
}