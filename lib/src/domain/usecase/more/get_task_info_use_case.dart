import 'package:mofa/src/core/resources/data_state.dart';
import 'package:mofa/src/data/sources/remote/mofa/more/entity/remore_milstone_details.dart';
import 'package:mofa/src/domain/repositories/more_repository.dart';

class GetTaskInfoUseCase {
  final MoreRepository _moreRepository;

  GetTaskInfoUseCase(this._moreRepository);

  Future<DataState<RemoteMilstoneDetails>> call({
    required String id,
    required int pageSize,
    required int skip,
    required String sortColumnDirection,
    required String columnDirection,
  }) async {
    return await _moreRepository.getTaskInfo(
      id: id,
      pageSize: pageSize,
      skip: skip,
      sortColumnDirection: sortColumnDirection,
      columnDirection: columnDirection,
    );
  }
}
