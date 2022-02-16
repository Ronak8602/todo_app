import 'package:flutter/material.dart';
import 'package:todo_app/constants.dart';
import 'package:todo_app/database_helper.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/widgets.dart';

class TaskPage extends StatefulWidget {
  final Task task;
  const TaskPage({Key? key, required this.task}) : super(key: key);

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {

  String _taskTitle="";

  @override
  void initState() {
    if(widget.task.id!=null) {
      _taskTitle=widget.task.title!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                          child: Image(
                            image:
                                AssetImage('assets/images/back_arrow_icon.png'),
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: "Enter Task title",
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                            fontSize: 26.0,
                            fontWeight: FontWeight.bold,
                            color: kDarkTextColor,
                          ),
                          controller: TextEditingController()..text=_taskTitle,
                          onSubmitted: (String value) async {
                            if (value != "") {
                              if (widget.task.id == null) {
                                DatabaseHelper _db = DatabaseHelper();
                                Task task = Task(
                                    title: value,
                                    description: "Automatic Description");
                                _db.insertTask(task);
                              }
                              else{
                                widget.task.title=value;
                              }
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 8.0, left: 20.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Enter task description",
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      color: kLightTextColor,
                    ),
                  ),
                ),
                Todo(todo: "Incomplete todo", isDone: false),
                Todo(todo: "Complete todo", isDone: true)
              ],
            ),
            Positioned(
              bottom: 24.0,
              right: 20.0,
              child: InkWell(
                onTap: () {},
                child: Container(
                  height: 60.0,
                  width: 60.0,
                  decoration: BoxDecoration(
                    color: kPinkColor,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: const Image(
                    image: AssetImage("assets/images/delete_icon.png"),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
