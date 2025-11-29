import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/task_viewmodel.dart';
import '../../models/task.dart';
import 'add_task_modal.dart';

import '../../viewmodels/distraction_viewmodel.dart';

class DailyTaskScreen extends StatefulWidget {
  const DailyTaskScreen({super.key});

  @override
  State<DailyTaskScreen> createState() => _DailyTaskScreenState();
}

class _DailyTaskScreenState extends State<DailyTaskScreen> {
  late DistractionViewModel distractionVM;

  @override
  void initState() {
    super.initState();

    // Fetch Tasks
    Future.delayed(Duration.zero, () {
      Provider.of<TaskViewModel>(context, listen: false).fetchTasks();
    });

    // Init Distraction ViewModel
    distractionVM = Provider.of<DistractionViewModel>(context, listen: false);

    // Start idle timer
    distractionVM.startIdleTimer(_showAlert);
  }

  @override
  void dispose() {
    distractionVM.cancelTimer(); // Stop timer on exit
    super.dispose();
  }

  // Alert Dialog
  void _showAlert() {
    if (!mounted) return;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Feeling Distracted?"),
        content: const Text(
          "Take a deep breath and refocus on your tasks 💪",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              distractionVM.resetIdleTimer(_showAlert);
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  // Any touch → reset timer
  void _onUserAction() {
    distractionVM.resetIdleTimer(_showAlert);
  }

  @override
  Widget build(BuildContext context) {
    final taskVM = Provider.of<TaskViewModel>(context);

    return GestureDetector(
      onTap: _onUserAction,
      onPanDown: (_) => _onUserAction(),

      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: const Text(
            "Today's Tasks",
            style: TextStyle(color: Colors.white),
          ),
        ),

        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepPurple,
          onPressed: () {
            _onUserAction();
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (BuildContext context) {
                return Builder(
                  builder: (context) => AddTaskModal(),
                );
              },
            );
          },
          child: const Icon(Icons.add, color: Colors.white),
        ),

        body: taskVM.tasks.isEmpty
            ? const Center(
                child: Text(
                  "No tasks yet.\nClick + to add new task.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
              )

            : ListView.builder(
                padding: const EdgeInsets.all(15),
                itemCount: taskVM.tasks.length,
                itemBuilder: (context, index) {
                  _onUserAction(); // Reset timer when scrolling

                  Task task = taskVM.tasks[index];

                  return Card(
                    child: ListTile(
                      leading: Checkbox(
                        value: task.completed,
                        onChanged: (value) {
                          _onUserAction();
                          taskVM.toggleTask(task);
                        },
                        activeColor: Colors.deepPurple,
                      ),
                      title: Text(
                        task.title,
                        style: TextStyle(
                          fontSize: 17,
                          decoration: task.completed
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          color: task.completed ? Colors.grey : Colors.black,
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _onUserAction();
                          taskVM.deleteTask(task.id);
                        },
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
