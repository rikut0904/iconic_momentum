import 'package:iconic_momentum/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// ドロップダウンメニューのリストを管理する StateNotifier
class DropdownListNotifier extends StateNotifier<List<String>> {
  DropdownListNotifier() : super(["追加", "全て", "個人"]); // 初期値は「追加」「全て」「個人」

  /// 新しい項目を追加するメソッド
  void addItem(String newItem) async {
    state = [...state, newItem]; // 新しいリストを生成して更新
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'group': state,
    });
  }
}

/// ドロップダウンメニューのリストを管理するプロバイダー
final dropdownListProvider =
    StateNotifierProvider<DropdownListNotifier, List<String>>(
        (ref) => DropdownListNotifier());

/// 現在選択されている値を管理するプロバイダー
final dropdownValueProvider = StateProvider<String>((ref) => "個人");
