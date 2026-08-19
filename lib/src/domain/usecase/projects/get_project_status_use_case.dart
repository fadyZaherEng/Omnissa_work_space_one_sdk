import 'package:mofa/src/core/resources/data_state.dart';
import 'package:mofa/src/domain/entities/home/status_model.dart';
import 'package:mofa/src/domain/repositories/get_all_projects_repository.dart';

class GetProjectStatusUseCase {
  final GetAllProjectsRepository _getAllProjectsRepository;

  GetProjectStatusUseCase(this._getAllProjectsRepository);

  Future<DataState<List<StatusModel>>> call() async {
    return await _getAllProjectsRepository.getProjectStatus();
  }
}
