import 'package:flutter/material.dart';
import 'package:todo_app/constants.dart';
import 'package:todo_app/widgets.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
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
                            image: AssetImage('assets/images/back_arrow_icon.png'),
                          ),
                        ),
                      ),
                      const Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Enter Task title",
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                            fontSize: 26.0,
                            fontWeight: FontWeight.bold,
                            color: kDarkTextColor,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    bottom: 8.0,
                    left: 20.0
                  ),
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
                Todo(todo: "Complete todo",isDone: true)
              ],
            ),
            Positioned(
              bottom: 24.0,
              right: 20.0,
              child: InkWell(
                onTap: (){},
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
