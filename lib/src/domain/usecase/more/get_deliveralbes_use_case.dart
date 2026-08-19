import 'package:mofa/src/core/resources/data_state.dart';
import 'package:mofa/src/domain/entities/home/deliverables.dart';
import 'package:mofa/src/domain/repositories/more_repository.dart';

class GetDeliverablesUseCase {
  final MoreRepository _moreRepository;

  GetDeliverablesUseCase(this._moreRepository);

  Future<DataState<List<Deliverbles>>> call({
    required int pageSize,
    required int skip,
    required String departmentId,
    required int statusId,
    required String assignTo,
    required String searchFilterDefinition,
    required String searchValue,
    required String sortColumnDirection,
    required String columnDirection,
  }) async {
    return await _moreRepository.getDeliverables(
      pageSize: pageSize,
      skip: skip,
      departmentId: departmentId,
      statusId: statusId,
      assignTo: assignTo,
      searchFilterDefinition: searchFilterDefinition,
      searchValue: searchValue,
      sortColumnDirection: sortColumnDirection,
      columnDirection: columnDirection,
    );
  }
}
