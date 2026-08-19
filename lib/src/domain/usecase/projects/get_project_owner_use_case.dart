import 'package:mofa/src/core/resources/data_state.dart';
import 'package:mofa/src/domain/entities/home/owner.dart';
import 'package:mofa/src/domain/repositories/get_all_projects_repository.dart';

class GetProjectOwnerUseCase {
  final GetAllProjectsRepository _getAllProjectsRepository;

  GetProjectOwnerUseCase(this._getAllProjectsRepository);

  Future<DataState<List<GetOwner>>> call() async {
    return await _getAllProjectsRepository.getProjectOwners();
  }
}
