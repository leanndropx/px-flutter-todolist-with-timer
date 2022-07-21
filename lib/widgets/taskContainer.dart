import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import '../models/taskModel.dart';

class TaskContainer extends StatelessWidget {
  TaskContainer({
    Key? key,
    required this.task,
    required this.deleteTask,
    required this.timerDialog,
    required this.timerDialogReverse,
  }) : super(key: key);

  TaskModel task;
  Function(TaskModel) deleteTask;
  Function() timerDialog;
  Function() timerDialogReverse;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Slidable(
        child: Container(
          padding: const EdgeInsets.all(16),
          //margin: EdgeInsets.symmetric(vertical: 2),
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(8)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                DateFormat('dd/MMM/yyyy - EE - HH:mm').format(task.datetime),
                style: const TextStyle(fontSize: 9),
              ),
              Text(
                task.title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
        actionExtentRatio: 0.29,
        actionPane: const SlidableDrawerActionPane(),
        secondaryActions: [
          IconSlideAction(
            icon: Icons.delete,
            color: Colors.red,
            caption: 'Deletar',
            onTap: () {
              deleteTask(task);
            },
          ),
        ],
        actions: [
          IconSlideAction(
            icon: Icons.access_alarm,
            color: Colors.red,
            caption: 'Temporizar',
            onTap: timerDialogReverse,
          ),
          IconSlideAction(
            icon: Icons.access_alarm,
            color: Colors.green,
            caption: 'Cronometrar',
            onTap: timerDialog,
          )
        ],
      ),
    );
  }
}
