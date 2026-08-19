import 'package:mofa/src/core/resources/data_state.dart';
import 'package:mofa/src/domain/entities/home/department.dart';
import 'package:mofa/src/domain/repositories/get_all_projects_repository.dart';

class GetProjectDepartmentsUseCase {
  final GetAllProjectsRepository _getAllProjectsRepository;

  GetProjectDepartmentsUseCase(this._getAllProjectsRepository);

  Future<DataState<List<Department>>> call() async {
    return await _getAllProjectsRepository.getProjectDepartments();
  }
}
