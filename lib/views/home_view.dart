import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/task_viewmodel.dart';
import '../models/task.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
  void initState() {
    super.initState();

    // AUTO FETCH TASKS FROM REALTIME DB
    Future.microtask(() {
      Provider.of<TaskViewModel>(context, listen: false).fetchTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<TaskViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("ClutterZap Home")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          vm.addTask("New Task");
        },
        child: const Icon(Icons.add),
      ),

      body: Column(
        children: [
          const SizedBox(height: 20),
          Text("Tasks in DB: ${vm.tasks.length}"),

          Expanded(
            child: ListView.builder(
              itemCount: vm.tasks.length,
              itemBuilder: (_, index) {
                final Task task = vm.tasks[index];

                return ListTile(
                  leading: Checkbox(
                    value: task.completed,
                    onChanged: (_) => vm.toggleComplete(task),
                  ),
                  title: Text(task.title),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => vm.deleteTask(task.id),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
