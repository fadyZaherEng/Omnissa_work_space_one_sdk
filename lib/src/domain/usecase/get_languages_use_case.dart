import 'package:mofa/src/core/resources/data_state.dart';
import 'package:mofa/src/domain/entities/shared/language.dart';
import 'package:mofa/src/domain/repositories/settings_repository.dart';

class GetLanguagesUseCase {
  final SettingsRepository _helperRepository;

  GetLanguagesUseCase(this._helperRepository);

  Future<DataState<List<Language>>> call() async {
    return await _helperRepository.getLanguage();
  }
}
