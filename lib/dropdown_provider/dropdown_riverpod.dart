import 'package:flutter_riverpod/flutter_riverpod.dart';

/// ドロップダウンメニューのリストを管理する StateNotifier
class DropdownListNotifier extends StateNotifier<List<String>> {
  DropdownListNotifier() : super(["個人", "追加"]); // 初期値は「個人」「追加」

  /// 新しい項目を追加するメソッド
  void addItem(String newItem) {
    state = [...state, newItem]; // 新しいリストを生成して更新
  }
}

/// ドロップダウンメニューのリストを管理するプロバイダー
final dropdownListProvider =
    StateNotifierProvider<DropdownListNotifier, List<String>>(
        (ref) => DropdownListNotifier());

/// 現在選択されている値を管理するプロバイダー
final dropdownValueProvider = StateProvider<String>((ref) => "個人");

/// カスタムドロップダウンのリストを管理する StateNotifier
class CustomDropdownNotifier extends StateNotifier<List<String>> {
  CustomDropdownNotifier() : super(["項目追加"]); // 初期値を変更

  /// 新しい項目を追加
  void addCustomItem(String newItem) {
    state = [...state, newItem]; // 新しいリストを生成して更新
  }
}

/// カスタムドロップダウンのリストプロバイダー
final customDropdownProvider =
    StateNotifierProvider<CustomDropdownNotifier, List<String>>(
        (ref) => CustomDropdownNotifier());

/// 現在選択されている値を管理するプロバイダー
final selectedDropdownValueProvider = StateProvider<String>((ref) => "項目追加");
