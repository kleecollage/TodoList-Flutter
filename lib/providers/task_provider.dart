import 'package:flutter/material.dart';
import 'package:todo_list/models/task.dart';

enum TaskFilter { all, completed, pending }

class TaskProvider extends ChangeNotifier {
  // properties
  final List<Task> _tasks = [];
  TaskFilter _filter = TaskFilter.all;

  // getters
  // List<Task> get tasks => _tasks;
  List<Task> get tasks {
    switch (_filter) {
      case TaskFilter.completed:
        return _tasks.where((task) => task.isCompleted).toList();
      case TaskFilter.pending:
        return _tasks.where((task) => !task.isCompleted).toList();
      default:
        return _tasks;
    }
  }

  TaskFilter get filter => _filter;

  // setters
  void setFilter(TaskFilter filter) {
    _filter = filter;
    notifyListeners();
  }

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
      title: newTitle,
      category: newCategory,
      isCompleted: _tasks[taskIndex].isCompleted,
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
