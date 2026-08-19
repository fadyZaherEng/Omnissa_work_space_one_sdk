import 'dart:convert';

import 'package:mofa/src/core/resources/shared_preferences_keys.dart';
import 'package:mofa/src/domain/entities/shared/sort.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetSortRisksUseCase {
  final SharedPreferences _sharedPreferences;

  SetSortRisksUseCase(this._sharedPreferences);

  Future<void> call(Sort sort) async {
    await _sharedPreferences.setString(
      SharedPreferenceKeys.sortRisks,
      jsonEncode(sort.toMap()),
    );
  }
}
