import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconic_momentum/Widget/load_del_function.dart';
import 'package:iconic_momentum/Widget/add_function.dart';
import 'package:iconic_momentum/dropdown_provider/dropdown_menu.dart';
import 'package:iconic_momentum/dropdown_provider/dropdown_riverpod.dart';
import 'package:iconic_momentum/main.dart';
import 'package:google_fonts/google_fonts.dart';

class CompletedToDoPage extends ConsumerStatefulWidget {
  const CompletedToDoPage({super.key, required List completeToDo});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<CompletedToDoPage> {
  int _currentIndex = 0;

  // Firestoreコレクション参照
  final CollectionReference _todoCollection =
      FirebaseFirestore.instance.collection('todo');

  @override
  void initState() {
    super.initState();
    loadTasks(context, ref, _todoCollection);
  }

  @override
  Widget build(BuildContext context) {
    loadTasks(context, ref, _todoCollection);
    final todoItems = ref.watch(infoTodoItems);
    final completedItems = ref.watch(infoCompletedItems);
    final currentList = _currentIndex == 0 ? todoItems : completedItems;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Iconic Momentum',
          style: GoogleFonts.playfairDisplay(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.purple[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _currentIndex == 0 ? 'ToDoリスト' : '完了済みタスク',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const DropdownMenuExample(),
            Expanded(
              child: currentList.isEmpty
                  ? Center(
                      child: Text(
                        _currentIndex == 0 ? 'タスクはまだありません' : '完了済みタスクはまだありません',
                        style:
                            const TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: currentList.length,
                      itemBuilder: (context, index) {
                        final item = currentList[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            leading: Icon(
                              item.done
                                  ? Icons.check_circle
                                  : Icons.circle_outlined,
                              color: item.done ? Colors.green : Colors.grey,
                            ),
                            title: Text(
                              '${item.title}${item.schedule.isNotEmpty ? " | ${item.schedule}" : ""}',
                            ),
                            trailing: _currentIndex == 0
                                ? Checkbox(
                                    value: item.done,
                                    onChanged: (value) {
                                      onCheckboxChanged(
                                          context,
                                          ref,
                                          item,
                                          value,
                                          _todoCollection); // チェックボックス押下時の処理
                                    },
                                  )
                                : null,
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addNewTask(context, ref, _todoCollection),
        backgroundColor: Colors.purple[300],
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'ToDo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done),
            label: '完了済み',
          ),
        ],
      ),
    );
  }
}
