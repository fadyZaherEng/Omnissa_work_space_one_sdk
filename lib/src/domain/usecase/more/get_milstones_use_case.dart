import 'package:mofa/src/core/resources/data_state.dart';
import 'package:mofa/src/domain/entities/home/milstones.dart';
import 'package:mofa/src/domain/repositories/more_repository.dart';

class GetMilstonesUseCase {
  final MoreRepository _moreRepository;

  GetMilstonesUseCase(this._moreRepository);

  Future<DataState<List<Milstones>>> call({
    required int pageSize,
    required int skip,
    required String sortColumnDirection,
    required String columnDirection,
  }) async {
    return await _moreRepository.getProjectMilestones(
      pageSize: pageSize,
      skip: skip,
      sortColumnDirection: sortColumnDirection,
      columnDirection: columnDirection,
    );
  }
}
