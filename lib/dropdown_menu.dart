import 'package:flutter/material.dart';

class DropdownMenuExample extends StatefulWidget {
  const DropdownMenuExample({super.key});
  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

typedef MenuEntry = DropdownMenuEntry<String>;

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  static final List<String> list = [
    "選択する",
    "個人",
    "金沢工業大学",
    "その他",
    "追加",
  ];

  static final List<MenuEntry> menuEntries = list
      .map<MenuEntry>((String name) => MenuEntry(value: name, label: name))
      .toList();

  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      initialSelection: dropdownValue,
      onSelected: (String? value) {
        if (value != null) {
          setState(() {
            dropdownValue = value;
          });
        }
      },
      dropdownMenuEntries: menuEntries,
    );
  }
}
