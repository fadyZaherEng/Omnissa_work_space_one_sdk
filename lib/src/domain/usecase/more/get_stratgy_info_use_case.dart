import 'package:mofa/src/core/resources/data_state.dart';
import 'package:mofa/src/domain/entities/home/stratgy.dart';
import 'package:mofa/src/domain/repositories/more_repository.dart';

class GetStratgyInfoUseCase {
  final MoreRepository _moreRepository;

  GetStratgyInfoUseCase(this._moreRepository);

  Future<DataState<Strategy>> call({
    required String id,
  }) async {
    return await _moreRepository.getStrategyInfo(id: id);
  }
}
