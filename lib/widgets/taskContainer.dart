import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import '../models/taskModel.dart';

class TaskContainer extends StatelessWidget {
  TaskContainer({
    Key? key,
    required this.task,
    required this.DeleteTask,
    required this.TimerDialog,
    required this.TimerDialogReverse,
  }) : super(key: key);

  TaskModel task;
  Function(TaskModel) DeleteTask;
  Function() TimerDialog;
  Function() TimerDialogReverse;


  @override
  Widget build(BuildContext context) {
    return Slidable(
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(vertical: 2),
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              DateFormat('dd/MMM/yyyy - EE - HH:mm').format(task.datetime),
              style: TextStyle(fontSize: 9),
            ),
            Text(
              task.title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
      actionExtentRatio: 0.27,
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: [
        IconSlideAction(
          icon: Icons.delete,
          color: Colors.red,
          caption: 'Deletar',
          onTap: () {
            DeleteTask(task);
          },
        ),
        IconSlideAction(
          icon: Icons.chat,
          color: Colors.green,
          caption: 'Iniciar',
          onTap: TimerDialog,
        )
      ],
      actions: [
        IconSlideAction(
          icon: Icons.chat,
          color: Colors.green,
          caption: 'Temporizador',
          onTap: TimerDialogReverse,
        ),
      ],
    );
  }
}
