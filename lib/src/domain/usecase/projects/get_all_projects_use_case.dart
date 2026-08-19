import 'package:mofa/src/core/resources/data_state.dart';
import 'package:mofa/src/domain/entities/home/project.dart';
import 'package:mofa/src/domain/repositories/get_all_projects_repository.dart';

class GetAllProjectsUseCase {
  final GetAllProjectsRepository _getAllProjectsRepository;

  GetAllProjectsUseCase(this._getAllProjectsRepository);

  Future<DataState<List<Project>>> call({
    required int pageSize,
    required int skip,
    required int status,
    required String departmentId,
    required String owner,
    required String searchValue,
    required String searchFilterDefinition,
    required String sortColumnDirection,
    required String columnDirection,
  }) async {
    return await _getAllProjectsRepository.getAllProjects(
      pageSize: pageSize,
      skip: skip,
      status: status,
      departmentId: departmentId,
      owner: owner,
      searchValue: searchValue,
      searchFilterDefinition: searchFilterDefinition,
      sortColumnDirection: sortColumnDirection,
      columnDirection: columnDirection,
    );
  }
}
