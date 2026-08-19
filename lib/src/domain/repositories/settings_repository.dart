import 'package:mofa/src/core/resources/data_state.dart';
import 'package:mofa/src/domain/entities/shared/language.dart';

abstract class SettingsRepository {
  Future<DataState<List<Language>>> getLanguage();
}
