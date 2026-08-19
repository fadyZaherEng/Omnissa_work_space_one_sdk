import 'package:mofa/src/core/resources/data_state.dart';
import 'package:mofa/src/data/sources/remote/mofa/login/request/request_login.dart';
import 'package:mofa/src/domain/entities/login/login.dart';

abstract class LoginRepository {
  Future<DataState<Login>> getLogin({
    required RequestLogin requestLogin,
  });
}
