import 'package:flutter/material.dart';
import 'package:todo_app/constants.dart';

class TaskCard extends StatelessWidget {
  final String? title;
  final String? description;
  const TaskCard({Key? key, this.title, this.description}) : super(key: key);

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
              description ?? "No Description!",
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
  final String text;
  final bool isDone;
  const Todo({Key? key, required this.text, required this.isDone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 8.0,
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
                color: isDone ? kPurpleColor : Colors.transparent,
                borderRadius: BorderRadius.circular(6.0),
                border: isDone ? null : Border.all(
                    color: const Color(0xFF86829D),
                    width: 1.5
                )
            ),
            child: const Image(
              image: AssetImage('assets/images/check_icon.png'),
            ),
          ),
          Flexible(
            child: Text(
              text ,
              style: TextStyle(
                color: isDone ? kDarkTextColor : kLightTextColor,
                fontSize: 16.0,
                fontWeight: isDone ? FontWeight.bold : FontWeight.w500,
              ),
            ),
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
