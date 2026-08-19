import 'package:mofa/src/core/resources/data_state.dart';
import 'package:mofa/src/domain/entities/home/risks.dart';
import 'package:mofa/src/domain/repositories/more_repository.dart';

class GetRisksInfoUseCase {
  final MoreRepository _moreRepository;

  GetRisksInfoUseCase(this._moreRepository);

  Future<DataState<Risks>> call({
    required String id,
  }) async {
    return await _moreRepository.getRiskInfo(id: id);
  }
}
