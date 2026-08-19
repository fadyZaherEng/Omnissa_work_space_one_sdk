import 'dart:convert';

import 'package:mofa/src/core/resources/shared_preferences_keys.dart';
import 'package:mofa/src/domain/entities/shared/sort.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetSortMilstonesUseCase {
  final SharedPreferences _sharedPreferences;

  SetSortMilstonesUseCase(this._sharedPreferences);

  Future<void> call(Sort sort) async {
    await _sharedPreferences.setString(
      SharedPreferenceKeys.sortMilestones,
      jsonEncode(sort.toMap()),
    );
  }
}
