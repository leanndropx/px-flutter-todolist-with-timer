import 'dart:ffi';

class TaskModel{

  TaskModel({required this.title, required this.datetime, this.contagem});

  TaskModel.fromJson(Map<String,dynamic>json):
      title = json['title'],
      datetime = DateTime.parse(json['datetime']);

  Map<String,dynamic> toJson(){
    return{
      'title' : title,
      'datetime' : datetime.toIso8601String()
    };
  }

  late String title;
  late DateTime datetime;
  double? contagem;


}