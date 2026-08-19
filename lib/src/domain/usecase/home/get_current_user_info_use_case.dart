import 'package:mofa/src/core/resources/data_state.dart';
import 'package:mofa/src/domain/entities/home/user_info.dart';
import 'package:mofa/src/domain/repositories/home_repository.dart';

class GetCurrentUserInfoUseCase {
  final HomeRepository _homeRepository;

  GetCurrentUserInfoUseCase(this._homeRepository);

  Future<DataState<CurrentUserInfo>> call() async {
    return await _homeRepository.getCurrentUserInfo();
  }
}
