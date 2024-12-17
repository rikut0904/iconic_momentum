// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'task_provider.dart';

// class AddTaskDialog extends StatelessWidget {
//   const AddTaskDialog({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final TextEditingController todoName = TextEditingController();
//     final TextEditingController todoContent = TextEditingController();
//     final TextEditingController todoSchedule = TextEditingController();

//     return AlertDialog(
//       title: const Text(
//         'やったことリスト',
//         style: TextStyle(fontSize: 24),
//       ),
//       content: SingleChildScrollView(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text('やったこと追加', style: TextStyle(fontSize: 13)),
//             const SizedBox(height: 10),
//             const Text('やったこと名：', style: TextStyle(fontSize: 13)),
//             TextField(
//               controller: todoName,
//               decoration: const InputDecoration(hintText: 'タスク名を入力'),
//             ),
//             const SizedBox(height: 10),
//             const Text('内容：', style: TextStyle(fontSize: 13)),
//             TextField(
//               controller: todoContent,
//               decoration: const InputDecoration(hintText: '内容を入力'),
//             ),
//             const SizedBox(height: 10),
//             const Text('日程(任意)：', style: TextStyle(fontSize: 13)),
//             TextField(
//               controller: todoSchedule,
//               decoration: const InputDecoration(hintText: '日時を入力'),
//             ),
//           ],
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.of(context).pop(),
//           child: const Text('キャンセル', style: TextStyle(color: Colors.red)),
//         ),
//         Consumer(
//           builder: (context, ref, _) {
//             return TextButton(
//               onPressed: () {
//                 final taskName = todoName.text.trim();
//                 final taskContent = todoContent.text.trim();
//                 final taskSchedule = todoSchedule.text.trim();

//                 if (taskName.isNotEmpty) {
//                   ref.read(taskProvider.notifier).addTask(
//                         taskName,
//                         taskContent,
//                         taskSchedule,
//                       );
//                   Navigator.of(context).pop();
//                 }
//               },
//               child: const Text('追加', style: TextStyle(color: Colors.blue)),
//             );
//           },
//         ),
//       ],
//     );
//   }
// }
