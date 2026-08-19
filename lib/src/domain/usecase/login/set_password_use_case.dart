import 'package:mofa/src/core/resources/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetPasswordUseCase {
  final SharedPreferences sharedPreferences;

  SetPasswordUseCase(this.sharedPreferences);

  Future<bool> call(String password) async {
    return await sharedPreferences.setString(
      SharedPreferenceKeys.password,
      password,
    );
  }
}
