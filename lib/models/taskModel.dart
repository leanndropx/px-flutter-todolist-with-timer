class TaskModel{

  TaskModel({required this.title, required this.datetime});

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


}