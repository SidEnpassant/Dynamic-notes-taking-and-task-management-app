import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];
  bool _isLoading = false;

  List<Task> get tasks => _tasks;
  bool get isLoading => _isLoading;

  List<Task> get completedTasks =>
      _tasks.where((task) => task.isCompleted).toList();
  List<Task> get pendingTasks =>
      _tasks.where((task) => !task.isCompleted).toList();

  TaskProvider() {
    loadTasks();
  }

  Future<void> loadTasks() async {
    _isLoading = true;
    notifyListeners();

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? tasksJson = prefs.getString('tasks');

      if (tasksJson != null) {
        List<dynamic> tasksList = json.decode(tasksJson);
        _tasks = tasksList.map((taskJson) => Task.fromJson(taskJson)).toList();
      }
    } catch (e) {
      print('Error loading tasks: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> saveTasks() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<Map<String, dynamic>> tasksJson = _tasks
          .map((task) => task.toJson())
          .toList();
      await prefs.setString('tasks', json.encode(tasksJson));
    } catch (e) {
      print('Error saving tasks: $e');
    }
  }

  void addTask(Task task) {
    _tasks.insert(0, task);
    saveTasks();
    notifyListeners();
  }

  void updateTask(Task updatedTask) {
    int index = _tasks.indexWhere((task) => task.id == updatedTask.id);
    if (index != -1) {
      _tasks[index] = updatedTask;
      saveTasks();
      notifyListeners();
    }
  }

  void deleteTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    saveTasks();
    notifyListeners();
  }

  void toggleTaskCompletion(String id) {
    int index = _tasks.indexWhere((task) => task.id == id);
    if (index != -1) {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
      saveTasks();
      notifyListeners();
    }
  }

  Future<void> refreshTasks() async {
    await Future.delayed(Duration(milliseconds: 500));
    await loadTasks();
  }
}
