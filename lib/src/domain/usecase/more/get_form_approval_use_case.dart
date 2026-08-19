import 'package:mofa/src/core/resources/data_state.dart';
import 'package:mofa/src/domain/entities/home/form_approval.dart';
import 'package:mofa/src/domain/repositories/more_repository.dart';

class GetFormApprovalUseCase {
  final MoreRepository _moreRepository;

  GetFormApprovalUseCase(this._moreRepository);

  Future<DataState<List<FormApproval>>> call({
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
    return await _moreRepository.getFormsApprovals(
      skip: skip,
      pageSize: pageSize,
      departmentId: departmentId,
      statusId: statusId,
      // priorityId: priorityId,
      searchFilterDefinition: searchFilterDefinition,
      searchValue: searchValue,
      sortColumnDirection: sortColumnDirection,
      columnDirection: columnDirection,
    );
  }
}
