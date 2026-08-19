import 'package:mofa/src/core/resources/data_state.dart';
import 'package:mofa/src/domain/entities/home/challenges.dart';
import 'package:mofa/src/domain/repositories/more_repository.dart';

class GetChallengesUseCase {
  final MoreRepository _moreRepository;

  GetChallengesUseCase(this._moreRepository);

  Future<DataState<List<Challenges>>> call({
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
    return await _moreRepository.getIssues(
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
