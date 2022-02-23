class TodoClass{
  final int? id;
  final int? taskId;
  String? title;
  int? isDone;

  TodoClass({this.id,this.taskId,this.title,this.isDone});

  Map<String, dynamic> toMap(){
    return{
      'id': id,
      'taskId': taskId,
      'title': title,
      'isDone': isDone
    };
  }
}
