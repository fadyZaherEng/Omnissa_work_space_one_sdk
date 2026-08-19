import 'package:mofa/src/core/resources/data_state.dart';
import 'package:mofa/src/data/sources/remote/mofa/login/request/request_login.dart';
import 'package:mofa/src/domain/entities/login/login.dart';
import 'package:mofa/src/domain/repositories/login_repository.dart';

class LoginUseCase {
  final LoginRepository _loginRepository;

  LoginUseCase(this._loginRepository);

  Future<DataState<Login>> call({
    required RequestLogin requestLogin,
  }) async {
    return await _loginRepository.getLogin(requestLogin: requestLogin);
  }
}
