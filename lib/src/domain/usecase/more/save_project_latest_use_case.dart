import 'package:mofa/src/core/resources/data_state.dart';
import 'package:mofa/src/data/sources/remote/mofa/more/request/request_save_project_latest.dart';

import 'package:mofa/src/domain/repositories/more_repository.dart';

class SaveProjectLatestUseCase {
  final MoreRepository _moreRepository;

  SaveProjectLatestUseCase(this._moreRepository);

  Future<DataState> call({
    required RequestSaveProjectLatest requestSaveProjectLatest,
  }) async {
    return await _moreRepository.saveProjectLatest(
        requestSaveProjectLatest: requestSaveProjectLatest);
  }
}
