import 'package:mofa/src/core/resources/data_state.dart';
import 'package:mofa/src/data/sources/remote/mofa/more/request/request_update_tasks.dart';
import 'package:mofa/src/domain/repositories/more_repository.dart';

class GetTaskUpdatesUseCase {
  final MoreRepository _moreRepository;

  GetTaskUpdatesUseCase(this._moreRepository);

  Future<DataState<dynamic>> call({
    required RequestUpdateTasks requestUpdateTasks,
  }) async {
    return await _moreRepository.getTaskUpdates(
      requestUpdateTasks: requestUpdateTasks,
    );
  }
}
