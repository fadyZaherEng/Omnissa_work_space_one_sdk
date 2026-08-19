import 'dart:convert';
import 'package:mofa/src/core/resources/shared_preferences_keys.dart';
import 'package:mofa/src/domain/entities/shared/sort.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetSortPointersUseCase {
  final SharedPreferences _sharedPreferences;

  GetSortPointersUseCase(this._sharedPreferences);

  Future<Sort?> call() async {
    final jsonString =
        _sharedPreferences.getString(SharedPreferenceKeys.sortPointers);

    final Map<String, dynamic> jsonMap = json.decode(jsonString ?? '{}');
    return Sort.fromMap(jsonMap);
  }
}
