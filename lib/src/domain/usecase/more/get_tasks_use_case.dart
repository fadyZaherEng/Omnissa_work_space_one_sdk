import 'package:mofa/src/core/resources/data_state.dart';
import 'package:mofa/src/domain/entities/home/task.dart';
import 'package:mofa/src/domain/repositories/more_repository.dart';

class GetTasksUseCase {
  final MoreRepository _moreRepository;

  GetTasksUseCase(this._moreRepository);

  Future<DataState<List<Task>>> call({
    required int pageSize,
    required int skip,
    required String searchValue,
    required String searchFilterDefinition,
    required String sortColumnDirection,
    required String columnDirection,
  }) async {
    return await _moreRepository.getTasks(
      pageSize: pageSize,
      skip: skip,
      searchValue: searchValue,
      searchFilterDefinition: searchFilterDefinition,
      sortColumnDirection: sortColumnDirection,
      columnDirection: columnDirection,
    );
  }
}
