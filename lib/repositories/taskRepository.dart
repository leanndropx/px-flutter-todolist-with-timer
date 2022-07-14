import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:teste/models/taskModel.dart';

class TaskRepository{
  late SharedPreferences repository;

  Future <List<TaskModel>> getTasksList() async {
    repository = await SharedPreferences.getInstance();
    final String taskJson = repository.getString('tasks') ?? '[]';
    final List taskDecoded = json.decode(taskJson) as List;
    return taskDecoded.map((e) => TaskModel.fromJson(e)).toList();
  }

  void saveTasks(List<TaskModel> tasks) async{
    String taskEnconded = json.encode(tasks);
    repository.setString('tasks', taskEnconded);
  }
}