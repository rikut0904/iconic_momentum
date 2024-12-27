import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconic_momentum/main.dart';
import 'package:iconic_momentum/dropdown_provider/dropdown_riverpod.dart';

class DropdownMenuExample extends ConsumerWidget {
  const DropdownMenuExample({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 現在のリストと選択された値を取得
    final dropdownList = ref.watch(dropdownListProvider);
    final dropdownValue = ref.watch(dropdownValueProvider);

    /// ダイアログを表示し、新しい項目を追加
    Future<void> showAddItemDialog() async {
      String newItem = '';
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('新しい項目を追加'),
          content: TextField(
            decoration: const InputDecoration(hintText: '項目名を入力してください'),
            onChanged: (value) {
              newItem = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('キャンセル', style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () {
                if (newItem.isNotEmpty) {
                  ref
                      .read(dropdownListProvider.notifier)
                      .addItem(newItem); // リストを更新
                  ref.read(groupTagProvider.notifier).state =
                      newItem; // 新しいタグをセット
                  ref.read(dropdownValueProvider.notifier).state =
                      newItem; // ドロップダウンの選択状態を更新
                  Navigator.of(context).pop();
                }
              },
              child: const Text('追加', style: TextStyle(color: Colors.blue)),
            ),
          ],
        ),
      );
    }

    return SizedBox(
      width: 200,
      child: DropdownButton<String>(
        value: dropdownValue.isNotEmpty ? dropdownValue : dropdownList.first ,
        onChanged: (String? value) {
          if (value != null) {
            if (value == "追加") {
              showAddItemDialog();
              final groupTag = ref.watch(groupTagProvider);
              ref.read(dropdownValueProvider.notifier).state = groupTag;
            } else {
              ref.read(dropdownValueProvider.notifier).state = value; // 選択値を更新
            }
          }
        },
        items: dropdownList.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList(),
    isExpanded: true,
    underline: Container(height: 2, color: Colors.purple[300]),
    ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final String title;

  const DetailPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$title の詳細ページ'),
      ),
      body: Center(
        child: Text(
          '$title に関するコンテンツ',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
