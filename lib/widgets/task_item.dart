import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/models/task.dart';
import 'package:todo_list/providers/task_provider.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key, required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);

    return Card(
      child: ListTile(
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text(task.category),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: task.isCompleted,
              onChanged: (value) {
                taskProvider.toggleTaskStatus(task.id);
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              color: Colors.redAccent,
              onPressed: () {
                _confirmDelete(context, taskProvider, task.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}

void _confirmDelete(BuildContext context, TaskProvider taskProvider, String taskId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Confirm Delete Task'),
        content: Text('Are you sure you want to remove this task?'),
        actions: [
          // Cancel Button
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          // Confirm Button
          TextButton(
            onPressed: () {
              taskProvider.deleteTask(taskId);
              Navigator.of(context).pop();
            },
            child: Text('Delete'),
          ),
        ],
      );
    },
  );
}
