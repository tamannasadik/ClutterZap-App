import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/task_viewmodel.dart';
import '../../models/task.dart';
import 'add_task_modal.dart'; 

class DailyTaskScreen extends StatefulWidget {
  const DailyTaskScreen({super.key});

  @override
  State<DailyTaskScreen> createState() => _DailyTaskScreenState();
}

class _DailyTaskScreenState extends State<DailyTaskScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<TaskViewModel>(context, listen: false).fetchTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final taskVM = Provider.of<TaskViewModel>(context);

    return Scaffold(
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
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        // use a Builder to provide new context
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
                Task task = taskVM.tasks[index];

                return Card(
                  child: ListTile(
                    leading: Checkbox(
                      value: task.completed,
                      onChanged: (value) {
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
                        taskVM.deleteTask(task.id);
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
