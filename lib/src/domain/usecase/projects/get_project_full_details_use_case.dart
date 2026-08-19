import 'package:mofa/src/core/resources/data_state.dart';
import 'package:mofa/src/domain/entities/home/project_details.dart';
import 'package:mofa/src/domain/repositories/get_all_projects_repository.dart';

class GetProjectFullDetailsUseCase {
  final GetAllProjectsRepository _getAllProjectsRepository;

  GetProjectFullDetailsUseCase(this._getAllProjectsRepository);

  Future<DataState<ProjectDetails>> call({
    required String projectId,
    required String searchValue,
    required String draw,
    required int pageSize,
    required int skip,
  }) async {
    return await _getAllProjectsRepository.getProjectFullDetials(
      projectId: projectId,
      searchValue: searchValue,
      draw: draw,
      skip: skip,
      pageSize: pageSize,
    );
  }
}
