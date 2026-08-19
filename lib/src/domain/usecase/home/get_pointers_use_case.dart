import 'package:mofa/src/core/resources/data_state.dart';
import 'package:mofa/src/domain/entities/home/pointers_tool.dart';
import 'package:mofa/src/domain/repositories/home_repository.dart';

class GetHomePointersUseCase {
  final HomeRepository _homeRepository;

  GetHomePointersUseCase(this._homeRepository);

  Future<DataState<List<PointersTool>>> call({
    required int pageSize,
    required int skip,
    required String sortColumnDirection,
    required String columnDirection,
  }) async {
    return await _homeRepository.getAllKPI(
      pageSize: pageSize,
      skip: skip,
      sortColumnDirection: sortColumnDirection,
      columnDirection: columnDirection,
    );
  }
}
