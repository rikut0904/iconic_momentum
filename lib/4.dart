import 'package:flutter/material.dart';

import 'package:flutter_praxtice/main.dart';


class DropdownMenuExample extends StatefulWidget {
  const DropdownMenuExample({super.key});

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

typedef MenuEntry = DropdownMenuEntry<String>;

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  static final List<String> list = [
    "選択肢 1",
    "選択肢 2",
    "選択肢 3",
    "選択肢 4",
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
