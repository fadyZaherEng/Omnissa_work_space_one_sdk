import 'package:mofa/src/core/resources/data_state.dart';
import 'package:mofa/src/domain/entities/home/task_enum.dart';
import 'package:mofa/src/domain/repositories/more_repository.dart';

class GetTaskPriorityUseCase {
  final MoreRepository _moreRepository;

  GetTaskPriorityUseCase(this._moreRepository);

  Future<DataState<List<TaskBoardEnum>>> call() async {
    return await _moreRepository.getTaskboardPriority();
  }
}
