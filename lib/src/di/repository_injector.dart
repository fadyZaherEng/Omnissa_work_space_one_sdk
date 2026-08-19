import 'package:mofa/src/data/repositories/home_repository_implementation.dart';
import 'package:mofa/src/data/repositories/login_repository_implementation.dart';
import 'package:mofa/src/data/repositories/more_repository_implementation.dart';
import 'package:mofa/src/data/repositories/projects_repository_implementation.dart';
import 'package:mofa/src/di/data_layer_injector.dart';
import 'package:mofa/src/domain/repositories/get_all_projects_repository.dart';
import 'package:mofa/src/domain/repositories/home_repository.dart';
import 'package:mofa/src/domain/repositories/login_repository.dart';
import 'package:mofa/src/domain/repositories/more_repository.dart';

Future<void> initializeRepositoryDependencies() async {
  injector.registerFactory<GetAllProjectsRepository>(
      () => GetAllProjectsRepositoryImplementation(injector()));
  injector.registerFactory<LoginRepository>(
      () => LoginRepositoryImplementation(injector()));
  injector.registerFactory<HomeRepository>(
      () => HomeRepositoryImplementation(injector()));
  injector.registerFactory<MoreRepository>(
      () => MoreRepositoryImplementation(injector()));
}
