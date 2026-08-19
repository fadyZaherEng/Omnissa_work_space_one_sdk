import 'package:mofa/src/core/resources/data_state.dart';
import 'package:mofa/src/domain/entities/home/risks.dart';
import 'package:mofa/src/domain/repositories/more_repository.dart';

class GetRisksUseCase {
  final MoreRepository _moreRepository;

  GetRisksUseCase(this._moreRepository);

  Future<DataState<List<Risks>>> call({
    required int pageSize,
    required int skip,
    required String departmentId,
    required int statusId,
    required int priorityId,
    required String searchFilterDefinition,
    required String searchValue,

    required String sortColumnDirection,
    required String columnDirection,
  }) async {
    return await _moreRepository.getRisks(
      pageSize: pageSize,
      skip: skip,
      departmentId: departmentId,
      statusId: statusId,
      priorityId: priorityId,
      searchFilterDefinition: searchFilterDefinition,
      searchValue: searchValue,
      sortColumnDirection: sortColumnDirection,
      columnDirection: columnDirection,
    );
  }
}
