// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:to_do_list/utils/todo_tile.dart';
import 'package:to_do_list/utils/dialog_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = TextEditingController();
  List tasks = [
    ["Lerne Flutter", false],
    ["Mache sport", false],
    ["Mache Haushalt", false]
  ];
  @override
  void initState() {
    super.initState();
  }

  // checkbox was tapped
  void onCheckBoxChanged(bool? value, int index) {
    setState(() {
      tasks[index][1] = !tasks[index][1];
    });
  }

  void deleteTask(int index) {
    setState(() {
     tasks.removeAt(index);
    });
  }

  void onSaveTask() {
    if(controller.text.length > 0) {
      setState(() {
      tasks.add([controller.text, false]);
      controller.clear();
    });
    Navigator.of(context).pop();
    }
  }

  void onCancel() {}

  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: controller,
            onSave: onSaveTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text("TO DO"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.yellow,
          onPressed: createNewTask,
          child: Icon(Icons.add)),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return TodoTile(
            taskName: tasks[index][0],
            isTaskCompleted: tasks[index][1],
            onChanged: (value) => onCheckBoxChanged(value, index),
            deleteTask: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
