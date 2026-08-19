import 'package:mofa/src/core/resources/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetUserNameUseCase {
  final SharedPreferences sharedPreferences;

  GetUserNameUseCase(this.sharedPreferences);

  String call() {
    return sharedPreferences.getString(SharedPreferenceKeys.username) ?? "";
  }
}
