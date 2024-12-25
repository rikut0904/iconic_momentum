import 'package:flutter/material.dart';
import 'package:iconic_momentum/BottomNavigationBar/home.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatelessWidget {
  final List<TodoItem> todoItems;

  const CalendarPage({super.key, required this.todoItems});

  @override
  Widget build(BuildContext context) {
    DateTime selectedDate = DateTime.now();

    // 選択した日付に対応するタスクをフィルタリング
    final List<TodoItem> filteredTasks = todoItems
        .where((todo) =>
            DateTime.parse(todo.schedule).year == selectedDate.year &&
            DateTime.parse(todo.schedule).month == selectedDate.month &&
            DateTime.parse(todo.schedule).day == selectedDate.day)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('カレンダー'),
        backgroundColor: Colors.purple[300],
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2000, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: DateTime.now(),
            selectedDayPredicate: (day) => isSameDay(day, selectedDate),
            onDaySelected: (selectedDay, focusedDay) {
              selectedDate = selectedDay;
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
