import 'package:flutter/material.dart';
import 'package:todo_app/constants.dart';
import 'package:todo_app/database_helper.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/widgets.dart';

class TaskPage extends StatefulWidget {
  final Task task;
  const TaskPage({Key? key, required this.task}) : super(key: key);

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  int _taskId = 0;
  String _taskTitle = "";
  String _taskDescription = "";

  late FocusNode _titleFocus;
  late FocusNode _descriptionFocus;
  late FocusNode _todoFocus;

  bool _contentVisile = false;

  @override
  void initState() {
    if (widget.task.id != null) {
      // Set visibility to true
      _contentVisile = true;

      _taskTitle = widget.task.title!;
      _taskDescription = (widget.task.description ?? "No Description");
      _taskId = widget.task.id!;
    }

    _titleFocus = FocusNode();
    _descriptionFocus = FocusNode();
    _todoFocus = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _titleFocus.dispose();
    _descriptionFocus.dispose();
    _todoFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 24.0,
                    bottom: 6.0,
                  ),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(24.0),
                          child:  Image(
                            image: AssetImage(
                                'assets/images/back_arrow_icon.png'),
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          focusNode: _titleFocus,
                          onSubmitted: (value) async {
                            // Check if the field is not empty
                            if (value != "") {
                              // Check if the task is null
                              if (widget.task.id == null) {
                                Task _newTask = Task(title: value);
                                _taskId = await _dbHelper.insertTask(_newTask);
                                setState(() {
                                  _contentVisile = true;
                                  _taskTitle = value;
                                });
                              } else {
                                await _dbHelper.updateTaskTitle(_taskId, value);
                                print("Task Updated");
                              }
                              _descriptionFocus.requestFocus();
                            }
                          },
                          controller: TextEditingController()
                            ..text = _taskTitle,
                          decoration: const InputDecoration(
                            hintText: "Enter Task Title",
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                            fontSize: 26.0,
                            fontWeight: FontWeight.bold,
                            color: kDarkTextColor,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Visibility(
                  visible: _contentVisile,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      bottom: 12.0,
                    ),
                    child: TextField(
                      focusNode: _descriptionFocus,
                      onSubmitted: (value) async {
                        if(value != ""){
                          if(_taskId != 0){
                            await _dbHelper.updateTaskDescription(_taskId, value);
                            _taskDescription = value;
                          }
                        }
                        _todoFocus.requestFocus();
                      },
                      controller: TextEditingController()..text = _taskDescription,
                      decoration: const InputDecoration(
                        hintText: "Enter Description for the task...",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 24.0,
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: _contentVisile,
                  child: FutureBuilder(
                    initialData: const [],
                    future: _dbHelper.getTodo(_taskId),
                    builder: (context, snapshot) {
                      dynamic values = snapshot.data;
                      return Expanded(
                        child: ListView.builder(
                          itemCount: values.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () async {
                                if(values[index].isDone == 0){
                                  await _dbHelper.updateTodoDone(values[index].id, 1);
                                } else {
                                  await _dbHelper.updateTodoDone(values[index].id, 0);
                                }
                                setState(() {});
                              },
                              child: Todo(
                                text: values[index].title,
                                isDone: values[index].isDone == 0
                                    ? false
                                    : true,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
                Visibility(
                  visible: _contentVisile,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 20.0,
                          height: 20.0,
                          margin: const EdgeInsets.only(
                            right: 12.0,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(6.0),
                              border: Border.all(
                                  color: kLightTextColor, width: 1.5)),
                          child: const Image(
                            image: AssetImage('assets/images/check_icon.png'),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            focusNode: _todoFocus,
                            controller: TextEditingController()..text = "",
                            onSubmitted: (value) async {
                              // Check if the field is not empty
                              if (value != "") {
                                if (_taskId != 0) {
                                  DatabaseHelper _dbHelper = DatabaseHelper();
                                  TodoClass _newTodo = TodoClass(
                                    title : value,
                                    isDone: 0,
                                    taskId: _taskId,
                                  );
                                  await _dbHelper.insertToDo(_newTodo);
                                  setState(() {});
                                  _todoFocus.requestFocus();
                                } else {
                                  print("Task doesn't exist");
                                }
                              }
                            },
                            decoration: const InputDecoration(
                              hintText: "Enter Todo item...",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Visibility(
              visible: _contentVisile,
              child: Positioned(
                bottom: 24.0,
                right: 24.0,
                child: GestureDetector(
                  onTap: () async {
                    if(_taskId != 0) {
                      await _dbHelper.deleteTask(_taskId);
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      color: kPinkColor,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: const Image(
                      image: AssetImage(
                        "assets/images/delete_icon.png",
                      ),
                    ),
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
