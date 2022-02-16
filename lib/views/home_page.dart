import 'package:flutter/material.dart';
import 'package:todo_app/constants.dart';
import 'package:todo_app/database_helper.dart';
import 'package:todo_app/model/task.dart';

import 'package:todo_app/views/task_page.dart';
import 'package:todo_app/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseHelper _db = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          color: kBackgroundWhiteColor,
          padding: const EdgeInsets.only(
            top: 32.0,
            left: 18.0,
            right: 18.0,
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 22.0),
                    child: const Image(
                      image: AssetImage("assets/images/logo.png"),
                    ),
                  ),
                  Expanded(
                      child: FutureBuilder(
                    initialData: const [],
                    future: _db.getTask(),
                    builder: (context, snapshot) {
                      dynamic values = snapshot.data;
                      return ScrollConfiguration(
                        behavior: NoGlowBehaviour(),
                        child: ListView.builder(
                          itemCount: values.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            TaskPage(task: values[index])));
                              },
                              child: TaskCard(
                                task: values[index],
                              ),
                            );
                          },
                        ),
                      );
                    },
                  )),
                ],
              ),
              Positioned(
                bottom: 24,
                right: 0,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TaskPage(
                          task: Task(),
                        ),
                      ),
                    ).then((value) {
                      setState(() {});
                    });
                  },
                  child: Container(
                    height: 60.0,
                    width: 60.0,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xff7349fe), Color(0xff643fdb)],
                        begin: Alignment(0.0, -1.0),
                        end: Alignment(0.0, 1.0),
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: const Image(
                      image: AssetImage("assets/images/add_icon.png"),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
