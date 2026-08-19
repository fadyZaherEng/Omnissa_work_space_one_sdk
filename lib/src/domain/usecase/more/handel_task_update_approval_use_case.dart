import 'package:mofa/src/core/resources/data_state.dart';
import 'package:mofa/src/data/sources/remote/mofa/more/request/request_task_update.dart';
import 'package:mofa/src/domain/repositories/more_repository.dart';

class HandleTaskUpdateApprovalUseCase {
  final MoreRepository _moreRepository;

  HandleTaskUpdateApprovalUseCase(this._moreRepository);

  Future<DataState<String>> call({
    required RequestTaskUpdate request,
    required String actionType,
  }) async {
    return await _moreRepository.handleTaskUpdates(
      request: request,
      actionType: actionType,
    );
  }
}
