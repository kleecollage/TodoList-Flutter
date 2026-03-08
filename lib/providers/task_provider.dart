import 'package:flutter/material.dart';
import 'package:todo_list/models/task.dart';

class TaskProvider extends ChangeNotifier {
  // properties
  final List<Task> _tasks = [];

  // getters
  List<Task> get tasks => _tasks;

  // methods
  void addTask(String title, String category) {
    final newTask = Task(
      id: DateTime.now().toString(),
      title: title,
      category: category,
    );

    _tasks.add(newTask);
    notifyListeners();
  }

  void editTask(String id, String newTitle, String newCategory) {
    final taskIndex = _tasks.indexWhere((task) => task.id == id);
    final updatedTask = Task(
      id: id,
      title : newTitle,
      category : newCategory,
      isCompleted: _tasks[taskIndex].isCompleted
    );

    if (taskIndex != -1) {
      _tasks[taskIndex] = updatedTask;
      notifyListeners();
    }
  }

  void toggleTaskStatus(String id) {
    final taskIndex = _tasks.indexWhere((task) => task.id == id);
    if (taskIndex != -1) {
      _tasks[taskIndex].isCompleted = !_tasks[taskIndex].isCompleted;
      notifyListeners();
    }
  }
}
