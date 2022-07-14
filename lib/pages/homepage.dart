import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teste/repositories/taskRepository.dart';
import 'package:teste/widgets/taskContainer.dart';

import '../models/taskModel.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TaskRepository taskRepository = TaskRepository();
  TextEditingController tasksController = TextEditingController();
  List<TaskModel> allTasks = [];
  String? errorText;
  int count = 0;
  late Timer timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    taskRepository.getTasksList().then((value) => {
          setState(() {
            allTasks = value;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: tasksController,
                        decoration: InputDecoration(
                            errorText: errorText,
                            labelText: 'Adicione uma tarefa',
                            labelStyle: TextStyle(color: Color(0xff00d7f3)),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xff00d7f3), width: 2)),
                            hintText: 'Estudar Fluter',
                            border: OutlineInputBorder()),
                      ),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        String text = tasksController.text;

                        if (text.isEmpty) {
                          setState(() {
                            errorText = 'O título não pode ser vazio';
                          });
                          return;
                        }

                        setState(() {
                          TaskModel newTask = TaskModel(
                              title: tasksController.text,
                              datetime: DateTime.now());
                          allTasks.add(newTask);
                          errorText = null;
                        });
                        tasksController.clear();
                        taskRepository.saveTasks(allTasks);
                      },
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(19),
                          primary: Color(0xff00d7f3)),
                      child: Icon(Icons.add),
                    )
                  ],
                ),
                SizedBox(height: 8),
                Flexible(
                    child: ListView(
                  shrinkWrap: true,
                  children: [
                    for (TaskModel eachTask in allTasks)
                      TaskContainer(
                          task: eachTask,
                          DeleteTask: deleteTask,
                          TimerDialog: TimerDialog)
                  ],
                )),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                        child: Text(
                            'Você tem ${allTasks.length} tarefas pendentes')),
                    ElevatedButton(
                      onPressed: () {
                        deleteAllTasks();
                      },
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(16),
                          primary: Color(0xff00d7f3)),
                      child: const Text('Limpar tudo'),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void deleteTask(TaskModel task) {
    setState(() {
      TaskModel taskDeleted = task;
      int indexTaskDeleted = allTasks.indexOf(task);
      allTasks.remove(task);
      errorText = null;
      taskRepository.saveTasks(allTasks);

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(seconds: 3),
          content: Text(
            'Tarefa ${task.title} deletada com sucesso',
            style: TextStyle(color: Color(0xff060708)),
          ),
          backgroundColor: Colors.white,
          action: SnackBarAction(
            label: 'Desfazer',
            textColor: const Color(0xff00d7f3),
            onPressed: () {
              setState(() {
                allTasks.insert(indexTaskDeleted, taskDeleted);
              });
              taskRepository.saveTasks(allTasks);
            },
          )));
    });
  }

  void deleteAllTasks() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Limpar tudos?'),
              content:
                  const Text('Tem certeza que deseja limpar todas as tarefas?'),
              backgroundColor: Colors.white,
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancelar',
                      style: TextStyle(color: Color(0xff00d7f3))),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      Navigator.of(context).pop();
                      allTasks.clear();
                      errorText = null;
                    });
                    taskRepository.saveTasks(allTasks);
                  },
                  child: const Text('Limpar tudo',
                      style: TextStyle(color: Color(0xff00d7f3))),
                )
              ],
            ));
  }

  void StartTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (count >= 0) {
          count++;
          Navigator.of(context).pop();
          TimerDialog();
        } else {
          timer.cancel();
        }
      });
    });
  }

  void TimerDialog() {
    Navigator.of(context);
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                '${count}',
                style: const TextStyle(
                  fontSize: 100,
                  color: Color(0xff00d7f3)
                ),
              ),
              backgroundColor: Colors.black.withAlpha(800),
              actions: [
                TextButton(
                  onPressed: () {
                    timer.cancel();
                    count = 0;
                    Navigator.of(context).pop();
                  },
                  child: const Text('Fechar'),
                ),
                TextButton(
                    onPressed: () {
                      setState(() {
                        timer.cancel();
                        //Navigator.of(context).pop();
                      });
                    },
                    child: const Text('Parar')),
                TextButton(
                    onPressed: () {
                      StartTimer();
                    },
                    child: const Text('Iniciar'))
              ],
            ));
  }
}
