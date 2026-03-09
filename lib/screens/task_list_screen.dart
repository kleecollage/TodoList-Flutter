import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/providers/task_provider.dart';
import 'package:todo_list/widgets/elevation_button.dart';
import 'package:todo_list/widgets/task_item.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Todo List')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                FilterButton(
                  label: 'All',
                  isSelected: taskProvider.filter == TaskFilter.all,
                  onPressed: () => taskProvider.setFilter(TaskFilter.all),
                ),
                FilterButton(
                  label: 'Completed',
                  isSelected: taskProvider.filter == TaskFilter.completed,
                  onPressed: () => taskProvider.setFilter(TaskFilter.completed),
                ),
                FilterButton(
                  label: 'Pending',
                  isSelected: taskProvider.filter == TaskFilter.pending,
                  onPressed: () => taskProvider.setFilter(TaskFilter.pending),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: taskProvider.tasks.length,
              itemBuilder: (ccontext, index) {
                final task = taskProvider.tasks[index];
                return TaskItem(task: task);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add-task');
        },
        child: const Icon(Icons.add),
      ),

      // body: ListView.builder(
      //   itemCount: taskProvider.tasks.length,
      //   itemBuilder: (context, index) {
      //     final task = taskProvider.tasks[index];
      //     return GestureDetector(
      //       onTap: (() {
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //             builder: (context) => TaskFormScreen(task: task),
      //           ),
      //         );
      //       }),
      //       child: TaskItem(task: task),
      //     );
      //   },
      // ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => TaskFormScreen()),
      //     );
      //   },
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
