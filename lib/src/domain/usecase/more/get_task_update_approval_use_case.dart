import 'package:mofa/src/core/resources/data_state.dart';
import 'package:mofa/src/domain/entities/home/task_update_approval.dart';
import 'package:mofa/src/domain/repositories/more_repository.dart';

class GetTaskUpdateApprovalUseCase {
  final MoreRepository _moreRepository;

  GetTaskUpdateApprovalUseCase(this._moreRepository);

  Future<DataState<List<TaskUpdateApproval>>> call({
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
    return await _moreRepository.getTaskUpdatesApprovals(
      pageSize: pageSize,
      skip: skip,
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
