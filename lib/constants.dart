
import 'package:flutter/material.dart';

//FLAT COLORS

const Color kBackgroundWhiteColor = Color(0xfff6f6f6);
const Color kPureWhiteColor = Colors.white;
const Color kPurpleColor = Color(0xff7349fe);
const Color kPinkColor = Color(0xfffe3577);
const Color kGreenColor = Color.fromRGBO(122,252,214,1);




//TEXT COLORS

const Color kDarkTextColor = Color(0xff211551);
const Color kLightTextColor = Color(0xff86829d);
// Positioned(
//   bottom: 24,
//   right: 0,
//   child: InkWell(
//     onTap: () {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => TaskPage(
//             task: Task(id: null, title: null, description: null),
//           ),
//         ),
//       ).then((value) {
//         setState(() {});
//       });
//     },
//     child: Container(
//       width: MediaQuery.of(context).size.width * 0.16,
//       height: MediaQuery.of(context).size.width * 0.16,
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           colors: [Color(0xff7349fe), Color(0xff643fdb)],
//           begin: Alignment(0.0, -1.0),
//           end: Alignment(0.0, 1.0),
//         ),
//         borderRadius: BorderRadius.circular(20.0),
//       ),
//       // child: const Image(
//       //   image: AssetImage("assets/images/add_icon.png"),
//       // ),
//       child: const Icon(
//         Icons.add_task_sharp,
//         color: Colors.white,
//       ),
//     ),
//   ),
// )