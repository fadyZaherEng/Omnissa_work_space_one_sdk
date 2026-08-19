import 'dart:convert';

import 'package:mofa/src/core/resources/shared_preferences_keys.dart';
import 'package:mofa/src/domain/entities/shared/sort.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetSortDeliverablesUseCase {
  final SharedPreferences _sharedPreferences;

  SetSortDeliverablesUseCase(this._sharedPreferences);

  Future<void> call(Sort sort) async {
    await _sharedPreferences.setString(
      SharedPreferenceKeys.sortDeliverables,
      jsonEncode(sort.toMap()),
    );
  }
}
