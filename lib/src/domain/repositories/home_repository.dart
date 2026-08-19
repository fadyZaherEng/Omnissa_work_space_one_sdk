import 'package:mofa/src/core/resources/data_state.dart';
import 'package:mofa/src/domain/entities/home/department.dart';
import 'package:mofa/src/domain/entities/home/home_static.dart';
import 'package:mofa/src/domain/entities/home/pointers_tool.dart';
import 'package:mofa/src/domain/entities/home/status_model.dart';
import 'package:mofa/src/domain/entities/home/user_info.dart';

abstract class HomeRepository {
  Future<DataState<List<HomeStatistics>>> getStatistics({
    required int pageSize,
    required int skip,
    required String sortColumnDirection,
    required String columnDirection,
  });

  Future<DataState<List<PointersTool>>> getAllKPI({
    required int pageSize,
    required int skip,
    required String sortColumnDirection,
    required String columnDirection,
  });

  Future<DataState<List<Department>>> getDepartments();

  Future<DataState<List<StatusModel>>> getStatus();

  Future<DataState<CurrentUserInfo>> getCurrentUserInfo();
}
