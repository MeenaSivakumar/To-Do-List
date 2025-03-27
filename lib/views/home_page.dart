import 'package:flutter/material.dart';
import 'package:to_do_list/models/task.dart';
import 'package:to_do_list/utils.dart/theme.dart';
import 'package:to_do_list/views/add_task.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Task> tasks = [];

  void addTask(Task task) {
    setState(() {
      tasks.add(task);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blue,
        centerTitle: true,
        title: Text(
          'To Do',
          style: TextStyle(
            fontSize: 26,
            color: white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Icon(
          Icons.account_circle,
          size: 25,
          color: white,
        ),
      ),
      body: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];

            return Container(
              height: 100,
              width: 200,
              child: ListTile(
                title: Text(task.name),
                subtitle: Text(
                  'Start: ${task.startDate.toString().split(" ")[0]}, ${task.starttime.format(context)}\n'
                  'End: ${task.endDate.toString().split(" ")[0]}, ${task.endtime.format(context)}',
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  AddTask(addTask: addTask,),),
          );
        },
        child: Icon(
          Icons.add,
          size: 28,
          color: white,
        ),
        backgroundColor: blue,
        tooltip: 'Add New Task',
      ),
    );
  }
}
