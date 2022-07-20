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
  late Timer timer;

  //timer
  int seconds = 0;
  int minutes = 0;
  int hours = 0;
  bool isTimerRunning = false;
  bool isTimerPaused = false;

  bool get isTenSeconds => seconds >= 10 || secondsReverse >= 10;
  bool get isTenMinutes => minutes >= 10 || minutesReverse >= 10;
  bool get isTenHours => hours >= 10 || hoursReverse >= 10;


  int secondsReverse = 0;
  int minutesReverse = 2;
  int hoursReverse = 1;
  int minutesReversePaused = 0;
  int secondsReversedPaused = 0;
  int hoursReversedPaused = 0;

  void initState() {
    // TODO: implement initState
    super.initState();
    taskRepository.getTasksList().then((value) =>
    {
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
                            TimerDialog: ShowTimerDialog,
                            TimerDialogReverse: ShowReverseTimerDialog,
                          )
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
        builder: (context) =>
            AlertDialog(
              title: const Text('Limpar tudo?'),
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




  //actions in Timer Dialog
  void ShowTimerDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Center(
                child: Text(
                  '${isTenHours ? hours : '0${hours}'}:${isTenMinutes
                      ? minutes
                      : '0${minutes}'}:${isTenSeconds
                      ? seconds
                      : '0${seconds}'}',
                  style:
                  const TextStyle(fontSize: 40, color: Color(0xff00d7f3)),
                ),
              ),
              insetPadding: EdgeInsets.all(12),
              backgroundColor: Colors.black.withAlpha(800),
              actions: [
                TextButton(
                  onPressed: QuitTimerDialogAndResetTimer,
                  child: const Text(
                    'Fechar',
                    style: TextStyle(color: Colors.redAccent),
                  ),
                ),
                TextButton(
                    onPressed: ResetTimer,
                    child: const Text(
                      'Zerar',
                      style: TextStyle(color: Color(0xff00d7f3)),
                    )),
                TextButton(
                    onPressed: StopTimer,
                    child: const Text(
                      'Parar',
                      style: TextStyle(color: Color(0xff00d7f3)),
                    )),
                TextButton(
                    onPressed: isTimerRunning ? null : StartTimer,
                    child: const Text(
                      'Iniciar',
                      style: TextStyle(color: Colors.greenAccent),
                    ))
              ],
            ));
  }

  void StartTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        isTimerRunning = true;
        if (seconds >= 0) {
          if (seconds == 59 && minutes == 59) {
            hours++;
            minutes = 0;
            seconds = -1;
          }

          if (seconds == 59) {
            minutes++;
            seconds = -1;
          }

          seconds++;
          Navigator.of(context).pop();
          ShowTimerDialog();
        } else {
          timer.cancel();
        }
      });
    });
  }

  void ResetTimer() {
    setState(() {
      isTimerRunning = false;
      timer.cancel();
      seconds = 0;
      minutes = 0;
      hours = 0;
      Navigator.pop(context);
      ShowTimerDialog();
    });
  }

  void StopTimer() {
    setState(() {
      timer.cancel();
      isTimerRunning = false;
      Navigator.of(context).pop();
      ShowTimerDialog();
    });
  }

  void QuitTimerDialogAndResetTimer() {
    setState(() {
      isTimerRunning = false;
      timer.cancel();
      Navigator.of(context).pop();
      seconds = 0;
      minutes = 0;
      hours = 0;
    });
  }




  //Actions in Reverse Timer Dialog

  void ShowReverseTimerDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Center(
                child: Text(
                  '${isTenHours
                      ? hoursReverse
                      : '0${hoursReverse}'}:${isTenMinutes
                      ? minutesReverse
                      : '0${minutesReverse}'}:${isTenSeconds
                      ? secondsReverse
                      : '0${secondsReverse}'}',
                  style:
                  const TextStyle(fontSize: 40, color: Color(0xff00d7f3)),
                ),
              ),
              insetPadding: EdgeInsets.all(12),
              backgroundColor: Colors.black.withAlpha(800),
              actions: [
                TextButton(
                  onPressed: QuitReverseTimerDialogAndResetTimer,
                  child: const Text(
                    'Fechar',
                    style: TextStyle(color: Colors.redAccent),
                  ),
                ),
                TextButton(
                    onPressed: ResetReverseTimer,
                    child: const Text(
                      'Zerar',
                      style: TextStyle(color: Color(0xff00d7f3)),
                    )),
                TextButton(
                    onPressed: StopReverseTimer,
                    child: const Text(
                      'Parar',
                      style: TextStyle(color: Color(0xff00d7f3)),
                    )),
                TextButton(
                    onPressed: isTimerRunning ? null : StartReverseTimer,
                    child: const Text(
                      'Iniciar',
                      style: TextStyle(color: Colors.greenAccent),
                    ))
              ],
            ));

  }

  void StartReverseTimer() {
    if (isTimerPaused){
      secondsReverse = secondsReversedPaused;
      minutesReverse = minutesReversePaused;
      hoursReverse = hoursReversedPaused;
    } else{
      secondsReverse=60;
      minutesReverse--;
    }

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        isTimerRunning = true;
        if(hoursReverse==0 && minutesReverse==0 && secondsReverse==0){
          timer.cancel();
        } else {
          secondsReverse--;
          if(secondsReverse==-1){
            if(minutesReverse==0){
              hoursReverse--;
              minutesReverse=60;
              secondsReverse=59;
            }
            secondsReverse=59;
            minutesReverse--;
          }
        }
        Navigator.pop(context);
        ShowReverseTimerDialog();
      });
    });
  }

  void ResetReverseTimer() {
    setState(() {
      isTimerRunning = false;
      timer.cancel();
      secondsReverse = 0;
      minutesReverse = 2;
      hoursReverse = 1;
      secondsReversedPaused = secondsReverse;
      minutesReversePaused = minutesReverse;
      hoursReversedPaused = hoursReverse;
      Navigator.pop(context);
      ShowReverseTimerDialog();
    });
  }

  void StopReverseTimer() {
    setState(() {
      isTimerPaused = true;
      minutesReversePaused = minutesReverse;
      secondsReversedPaused = secondsReverse;
      hoursReversedPaused = hoursReverse;
      timer.cancel();
      isTimerRunning = false;
      Navigator.of(context).pop();
      ShowReverseTimerDialog();
    });
  }

  void QuitReverseTimerDialogAndResetTimer() {
    setState(() {
      isTimerRunning = false;
      timer.cancel();
      Navigator.of(context).pop();
      secondsReverse = 0;
      minutesReverse = 2;
      hoursReverse = 1;
      secondsReversedPaused = secondsReverse;
      minutesReversePaused = minutesReverse;
      hoursReversedPaused = hoursReverse;
    });
  }

}
