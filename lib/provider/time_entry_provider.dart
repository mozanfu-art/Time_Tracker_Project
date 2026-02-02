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

  List<Project> get projects => _projects;
  List<Task> get tasks => _tasks;
  List<TimeEntry> get entries => _entries;

  TimeEntryProvider() {
    _loadData();
  }

  Future<void> _loadData() async {
    await storage.ready;
    final projectsJson = storage.getItem('projects');
    final tasksJson = storage.getItem('tasks');
    final entriesJson = storage.getItem('entries');

    if (projectsJson != null) {
      final List<dynamic> projectsList = json.decode(projectsJson);
      _projects = projectsList.map((json) => Project.fromJson(json)).toList();
    }

    if (tasksJson != null) {
      final List<dynamic> tasksList = json.decode(tasksJson);
      _tasks = tasksList.map((json) => Task.fromJson(json)).toList();
    }

    if (entriesJson != null) {
      final List<dynamic> entriesList = json.decode(entriesJson);
      _entries = entriesList.map((json) => TimeEntry.fromJson(json)).toList();
    }

    notifyListeners();
  }

  Future<void> _saveData() async {
    await storage.ready;
    await storage.setItem('projects', json.encode(_projects.map((p) => p.toJson()).toList()));
    await storage.setItem('tasks', json.encode(_tasks.map((t) => t.toJson()).toList()));
    await storage.setItem('entries', json.encode(_entries.map((e) => e.toJson()).toList()));
  }

  void addProject(Project project) {
    _projects.add(project);
    _saveData();
    notifyListeners();
  }

  void deleteProject(String id) {
    _projects.removeWhere((project) => project.id == id);
    _saveData();
    notifyListeners();
  }

  void addTask(Task task) {
    _tasks.add(task);
    _saveData();
    notifyListeners();
  }

  void deleteTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    _saveData();
    notifyListeners();
  }

  void addTimeEntry(TimeEntry entry) {
    _entries.add(entry);
    _saveData();
    notifyListeners();
  }

  void deleteTimeEntry(String id) {
    _entries.removeWhere((entry) => entry.id == id);
    _saveData();
    notifyListeners();
  }
}
