import 'dart:convert';

import 'package:insta_poc/store/store_consts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoreUtils {
  const StoreUtils._();

  // MARK: - Public

  // Double

  static Future setDouble(
    StoreDoubleId id,
    double? value,
  ) async {
    final store = await _getStore();
    final status = await _removeIfNull(
      id.name,
      value,
    );
    if (status) {
      return;
    }
    store.setDouble(
      id.name,
      value!,
    );
  }

  static Future<double?> getDouble(
    StoreDoubleId id,
  ) async {
    final store = await _getStore();
    return store.getDouble(
      id.name,
    );
  }

  // MARK: - Bool

  static Future setBool(
    StoreBoolId id,
    bool? value,
  ) async {
    final store = await _getStore();
    final status = await _removeIfNull(
      id.name,
      value,
    );
    if (status) {
      return;
    }
    store.setBool(
      id.name,
      value!,
    );
  }

  static Future<bool?> getBool(
    StoreBoolId id,
  ) async {
    final store = await _getStore();
    return store.getBool(
      id.name,
    );
  }

  // MARK: - Int

  static Future setInt(
    StoreIntId id,
    int? value,
  ) async {
    final store = await _getStore();
    final status = await _removeIfNull(
      id.name,
      value,
    );
    if (status) {
      return;
    }
    store.setInt(
      id.name,
      value!,
    );
  }

  static Future<int?> getInt(
    StoreIntId id,
  ) async {
    final store = await _getStore();
    return store.getInt(
      id.name,
    );
  }

  // MARK: - String

  static Future setString(
    StoreStringId id,
    String? value,
  ) async {
    final store = await _getStore();
    final status = await _removeIfNull(
      id.name,
      value,
    );
    if (status) {
      return;
    }
    store.setString(
      id.name,
      value!,
    );
  }

  static Future<String?> getString(
    StoreStringId id,
  ) async {
    final store = await _getStore();
    return store.getString(
      id.name,
    );
  }

  // MARK: - StringList

  static Future setStringList(
    StoreStringListId id,
    List<String>? value,
  ) async {
    final store = await _getStore();
    final status = await _removeIfNull(
      id.name,
      value,
    );
    if (status) {
      return;
    }
    store.setStringList(
      id.name,
      value!,
    );
  }

  static Future<List<String>?> getStringList(
    StoreStringListId id,
  ) async {
    final store = await _getStore();
    return store.getStringList(
      id.name,
    );
  }

  // MARK: - Json

  static Future<bool> setJson(
    StoreJsonId id,
    Map<String, dynamic>? value,
  ) async {
    final store = await _getStore();
    final status = await _removeIfNull(
      id.name,
      value,
    );
    if (status) {
      return true; // removing case
    }
    final jsonString = jsonEncode(value);
    final writingStatus = await store.setString(
      id.name,
      jsonString,
    );
    return writingStatus;
  }

  static Future<Map<String, dynamic>?> getJson(
    StoreJsonId id,
  ) async {
    final store = await _getStore();
    final jsonString = store.getString(
      id.name,
    );
    if (jsonString == null) return null;
    final map = jsonDecode(jsonString);
    if (map is! Map<String, dynamic>) return null;
    return map;
  }

  // MARK: JsonList

  static Future<bool> setJsonList(
    StoreJsonListId id,
    List<Map<String, dynamic>>? value,
  ) async {
    final store = await _getStore();
    if (value == null) {
      // removing case
      final status = await _removeIfNull(
        id.name,
        value,
      );
      return status;
    }
    final List<String> stringList = value
        .map(
          (next) => jsonEncode(next),
        )
        .toList();
    final operationStatus = await store.setStringList(
      id.name,
      stringList,
    );
    return operationStatus;
  }

  static Future<List<Map<String, dynamic>>?> getJsonList(
    StoreJsonListId id,
  ) async {
    final store = await _getStore();
    final stringList = store.getStringList(
      id.name,
    );
    if (stringList == null) return null;
    final List<Map<String, dynamic>> jsonList = stringList
        .map((next) => jsonDecode(next) as Map<String, dynamic>)
        .toList();
    return jsonList;
  }

  // MARK: - Private

  static Future<SharedPreferences> _getStore() async =>
      await SharedPreferences.getInstance();

  static Future<bool> _removeIfNull(
    String id,
    dynamic value,
  ) async {
    if (value != null) {
      return false;
    }
    final store = await _getStore();
    store.remove(
      id,
    );
    return true;
  }
}
