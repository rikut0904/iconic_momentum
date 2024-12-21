import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';

typedef TodoItem = ({String title, bool done});

class CalendarPage extends HookWidget {
const CalendarPage({super.key});

@override
Widget build(BuildContext context) {
	// 状態を管理する
	final focusedDayState = useState(DateTime.now());
	final selectedDayState = useState(DateTime.now());

	// イベントリストのサンプルデータ
	final events = {
	DateTime.utc(2024, 2, 15): [
		Event(title: 'イベント1'),
		Event(title: 'イベント2', description: '詳細な説明'),
	],
	DateTime.utc(2024, 2, 16): [
		Event(title: 'イベント3'),
	],
	};

	// イベント取得メソッド
	List<Event> getEventsForDay(DateTime day) {
	return events[day] ?? [];
	}

	return Scaffold(
		appBar: AppBar(
		title: Text(
			'Iconic Momentum',
			style: GoogleFonts.playfairDisplay(fontWeight: FontWeight.bold),
		),
		backgroundColor: Colors.purple[300], // AppBarの色
		),
		body: Padding(
		padding: const EdgeInsets.all(16.0),
		child: Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
			const Text(
				'カレンダー',
				style: TextStyle(
				fontSize: 24,
				fontWeight: FontWeight.bold,
				),
			),
			TableCalendar<Event>(
				firstDay: DateTime.utc(2020, 1, 1),
				lastDay: DateTime.utc(2040, 1, 1),
				focusedDay: focusedDayState.value,
				locale: 'ja_JP',
				selectedDayPredicate: (day) {
				return isSameDay(selectedDayState.value, day);
				},
				onDaySelected: (selectedDay, focusedDay) {
				selectedDayState.value = selectedDay;
				focusedDayState.value = focusedDay;
				},
				eventLoader: getEventsForDay, // イベントを表示
			),
			// 選択した日のイベントを表示
			const SizedBox(height: 8),
			Expanded(
				child: ListView(
				children: getEventsForDay(selectedDayState.value)
					.map((event) => ListTile(
							title: Text(event.title),
							subtitle: event.description != null
								? Text(event.description!)
								: null,
						))
					.toList(),
				),
			),
			],
		),
		));
}
}

class Event {
final String title;
final String? description;

Event({required this.title, this.description});
}
