import 'package:dio/dio.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/core/resources/data_state.dart';
import 'package:mofa/src/domain/entities/shared/language.dart';
import 'package:mofa/src/domain/repositories/settings_repository.dart';

class SettingsRepositoryImplementation extends SettingsRepository {
  @override
  Future<DataState<List<Language>>> getLanguage() async {
    try {
      return DataSuccess(
        data: [
          const Language(
            code: "en",
            name: "English",
          ),
          const Language(
            code: "ar",
            name: "Arabic",
          ),
        ],
        message: "",
      );
    } on DioException catch (e) {
      return DataFailed(
        error: e,
        message: S.current.badResponse,
      );
    }
  }
}
