// // ignore: file_names
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'task_provider.dart';

// class TaskList extends ConsumerWidget {
//   const TaskList({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final todoItems = ref.watch(taskProvider); // タスクリストを取得

//     return todoItems.isEmpty
//         ? const Center(
//             child: Text(
//               'タスクはまだありません',
//               style: TextStyle(fontSize: 18, color: Colors.grey),
//             ),
//           )
//         : ListView.builder(
//             itemCount: todoItems.length,
//             itemBuilder: (context, index) {
//               final item = todoItems[index];
//               return Card(
//                 margin: const EdgeInsets.symmetric(vertical: 8.0),
//                 child: ListTile(
//                   title: Text(item.title),
//                   subtitle: Text('${item.content} - ${item.schedule}'),
//                   trailing: Checkbox(
//                     value: item.done,
//                     onChanged: (value) {
//                       ref.read(taskProvider.notifier).toggleTaskDone(index);
//                     },
//                   ),
//                   onLongPress: () {
//                     ref.read(taskProvider.notifier).removeTask(index);
//                   },
//                 ),
//               );
//             },
//           );
//   }
// }
