import 'package:mofa/src/core/resources/data_state.dart';
import 'package:mofa/src/domain/entities/home/deliverables.dart';
import 'package:mofa/src/domain/repositories/more_repository.dart';

class GetDeliverableInfoUseCase {
  final MoreRepository _moreRepository;

  GetDeliverableInfoUseCase(this._moreRepository);

  Future<DataState<Deliverbles>> call({
    required String id,
  }) async {
    return await _moreRepository.getDeliverableInfo(id: id);
  }
}
