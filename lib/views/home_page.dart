import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:todo_app/constants.dart';
import 'package:todo_app/database_helper.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/views/app_info.dart';

import 'package:todo_app/views/task_page.dart';
import 'package:todo_app/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseHelper _db = DatabaseHelper();

  bool listView = false;

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 22.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image(
                      image: const AssetImage("assets/images/logo.png"),
                      width: MediaQuery.of(context).size.width * 0.15,
                      height: MediaQuery.of(context).size.width * 0.15,
                    ),
                    PopupMenuButton(
                      child: Icon(
                        Icons.menu,
                        size: MediaQuery.of(context).size.width * 0.1,
                        color: kPurpleColor,
                      ),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("ListView"),
                              // const SizedBox(width: 10.0),
                              listView
                                  ? const Icon(Icons.check)
                                  : const Text(""),
                            ],
                          ),
                          value: 1,
                          onTap: () {
                            setState(() {
                              listView = true;
                            });
                          },
                        ),
                        PopupMenuItem(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("GridView"),
                                listView
                                    ? const Text("")
                                    : const Icon(Icons.check),
                              ],
                            ),
                            value: 2,
                            onTap: () {
                              setState(() {
                                listView = false;
                              });
                            }),
                        // PopupMenuItem(
                        //     child: const Text("App Info"),
                        //     value: 2,
                        //     onTap: () {
                        //       Navigator.push(
                        //           context,
                        //           MaterialPageRoute(
                        //               builder: (context) =>
                        //                   const AppInfo()));
                        //       setState(() {});
                        //     })
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  initialData: const [],
                  future: _db.getTask(),
                  builder: (context, snapshot) {
                    dynamic values = snapshot.data;
                    return listView
                        ? ScrollConfiguration(
                            behavior: NoGlowBehaviour(),
                            child: ListView.builder(
                              itemCount: values.length,
                              itemBuilder: (context, index) {
                                return Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => TaskPage(
                                            task: values[index],
                                          ),
                                        ),
                                      ).then((value) {
                                        setState(() {});
                                      });
                                    },
                                    child: TaskCard(
                                      title: values[index].title,
                                      description: values[index].description,
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : ScrollConfiguration(
                            behavior: NoGlowBehaviour(),
                            child: MasonryGridView.builder(
                                itemCount: values.length,
                                itemBuilder: (context, index) {
                                  return Dismissible(
                                    background: Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10.0),
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 24.0, vertical: 32.0),
                                      decoration: BoxDecoration(
                                        color:
                                            Colors.redAccent.withOpacity(0.9),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(
                                            Icons.delete_forever,
                                            color: Colors.white,
                                            size: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.1,
                                          ),
                                          Icon(
                                            Icons.delete_forever,
                                            color: Colors.white,
                                            size: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.1,
                                          ),
                                        ],
                                      ),
                                    ),
                                    key: UniqueKey(),
                                    onDismissed:
                                        (DismissDirection direction) async {
                                      await _db.deleteTask(values[index].id);
                                      setState(() {});
                                    },
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => TaskPage(
                                              task: values[index],
                                            ),
                                          ),
                                        ).then((value) {
                                          setState(() {});
                                        });
                                      },
                                      child: TaskCard(
                                        title: values[index].title,
                                        description: values[index].description,
                                      ),
                                    ),
                                  );
                                },
                                gridDelegate:
                                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2)),
                          );
                  },
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TaskPage(
                        task: Task(id: null, title: null, description: null),
                      ),
                    ),
                  ).then((value) {
                    setState(() {});
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 24.0),
                  width: MediaQuery.of(context).size.width * 0.16,
                  height: MediaQuery.of(context).size.width * 0.16,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xff7349fe), Color(0xff643fdb)],
                      begin: Alignment(0.0, -1.0),
                      end: Alignment(0.0, 1.0),
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  // child: const Image(
                  //   image: AssetImage("assets/images/add_icon.png"),
                  // ),
                  child: const Icon(
                    Icons.add_task_sharp,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
