import 'package:mofa/src/core/resources/data_state.dart';
import 'package:mofa/src/domain/entities/home/department.dart';
import 'package:mofa/src/domain/repositories/home_repository.dart';

class GetHomeDepartmentsUseCase {
  final HomeRepository _homeRepository;

  GetHomeDepartmentsUseCase(this._homeRepository);

  Future<DataState<List<Department>>> call() async {
    return await _homeRepository.getDepartments();
  }
}
