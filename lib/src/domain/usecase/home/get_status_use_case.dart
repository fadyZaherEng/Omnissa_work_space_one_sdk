import 'package:mofa/src/core/resources/data_state.dart';
import 'package:mofa/src/domain/entities/home/status_model.dart';
import 'package:mofa/src/domain/repositories/home_repository.dart';

class GetHomeStatusUseCase {
  final HomeRepository _homeRepository;

  GetHomeStatusUseCase(this._homeRepository);

  Future<DataState<List<StatusModel>>> call() async {
    return await _homeRepository.getStatus();
  }
}
