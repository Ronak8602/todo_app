import 'package:flutter/material.dart';
import 'package:todo_app/constants.dart';

class TaskCard extends StatelessWidget {
  final String? title;
  final String? desc;
  const TaskCard({Key? key, this.title, this.desc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
      decoration: BoxDecoration(
        color: kPureWhiteColor,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? "No Title!",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22.0,
              color: kDarkTextColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              desc ?? "No Description!",
              style: const TextStyle(
                fontSize: 16.0,
                color: kLightTextColor,
                height: 1.5,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Todo extends StatelessWidget {
  String todo;
  bool isDone;
  Todo({Key? key, required this.todo, required this.isDone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Row(
        children: [
          Container(
            height: 20.0,
            width: 20.0,
            margin: EdgeInsets.only(right: 12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
              border: isDone
                  ? null
                  : Border.all(
                      width: 1.0,
                      style: BorderStyle.solid,
                      color: kLightTextColor,
                    ),
              color: isDone ? kPurpleColor : kPureWhiteColor,
            ),
            child: Image(
              image: AssetImage("assets/images/check_icon.png"),
            ),
          ),
          Text(
            todo,
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: isDone ? kDarkTextColor : kLightTextColor),
          ),
        ],
      ),
    );
  }
}

// Used to remove glow when sliding screen
class NoGlowBehaviour extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
