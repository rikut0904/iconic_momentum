// import 'package:flutter/material.dart';
// import 'package:iconic_momentum/BottomNavigatinBar/task_UI.dart';
// import 'package:iconic_momentum/BottomNavigatinBar/task_add_bottom.dart';
//
// class CompletedTasksPage extends StatelessWidget {
//   const CompletedTasksPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Iconic Momentum'),
//         backgroundColor: Colors.purple[300],
//       ),
//       body: const Padding(
//         padding: EdgeInsets.all(16.0),
//         child: TaskList(),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           showDialog(
//             context: context,
//             builder: (context) => const AddTaskDialog(),
//           );
//         },
//         backgroundColor: Colors.purple[300],
//         child: const Icon(Icons.add, color: Colors.white),
//       ),
//       bottomNavigationBar: BottomAppBar(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             IconButton(
//               icon: const Icon(Icons.list),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const AnotherTasksPage()),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
