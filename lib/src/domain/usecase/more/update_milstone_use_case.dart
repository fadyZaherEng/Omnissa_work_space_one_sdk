import 'package:mofa/src/core/resources/data_state.dart';
import 'package:mofa/src/data/sources/remote/mofa/more/request/request_update_milstone.dart';

import 'package:mofa/src/domain/repositories/more_repository.dart';

class UpdateMilstoneUseCase {
  final MoreRepository _moreRepository;

  UpdateMilstoneUseCase(this._moreRepository);

  Future<DataState> call({
    required RequestUpdateMilstone requestUpdateMilstone,
  }) async {
    return await _moreRepository.updateMilstone(
        requestUpdateMilstone: requestUpdateMilstone);
  }
}
