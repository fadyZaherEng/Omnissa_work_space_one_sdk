import 'package:mofa/src/core/resources/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetUserNameUseCase {
  final SharedPreferences sharedPreferences;

  SetUserNameUseCase(this.sharedPreferences);

  Future<bool> call(String username) async {
    return await sharedPreferences.setString(
      SharedPreferenceKeys.username,
      username,
    );
  }
}
