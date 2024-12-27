import 'package:iconic_momentum/main.dart';
import 'package:iconic_momentum/BottomNavigationBar/home.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends ConsumerStatefulWidget {
  const CalendarPage({super.key, required todoItems});

  @override
  _CalendarPage createState() => _CalendarPage();
}

class _CalendarPage extends ConsumerState<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    DateTime selectedDate = DateTime.now();
    final todoItems = ref.watch(infoTodoItems);
    List<TodoItem> filteredTasks = [];
    String infoText = "";
    try {
      filteredTasks = todoItems.where((todo) {
        try {
          // 選択した日付に対応するタスクをフィルタリング
          return DateTime.parse(todo.schedule).year == selectedDate.year &&
              DateTime.parse(todo.schedule).month == selectedDate.month &&
              DateTime.parse(todo.schedule).day == selectedDate.day;
        } catch (e) {
          return false;
        }
      }).toList();
    } catch (e) {
      infoText = 'Invalid date format: $e';
      filteredTasks = [];
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('カレンダー'),
        backgroundColor: Colors.purple[300],
      ),
      body: Column(
        children: [
          const SizedBox(height: 5),
          Text(infoText),
          const SizedBox(height: 5),
          TableCalendar(
            firstDay: DateTime.utc(2000, 1, 1),
            lastDay: DateTime.utc(2040, 12, 31),
            focusedDay: DateTime.now(),
            selectedDayPredicate: (day) => isSameDay(day, selectedDate),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                selectedDate = selectedDay;
              });
            },
          ),
          const SizedBox(height: 16),
          Expanded(
            child: filteredTasks.isEmpty
                ? const Center(
                    child: Text(
                      'この日にタスクはありません',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredTasks.length,
                    itemBuilder: (context, index) {
                      final task = filteredTasks[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          title: Text(task.title),
                          subtitle: Text(task.content),
                          trailing: Icon(
                            task.done
                                ? Icons.check_circle
                                : Icons.circle_outlined,
                            color: task.done ? Colors.green : Colors.grey,
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
