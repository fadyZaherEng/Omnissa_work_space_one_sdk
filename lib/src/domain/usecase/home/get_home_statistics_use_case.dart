import 'package:mofa/src/core/resources/data_state.dart';
import 'package:mofa/src/domain/entities/home/home_static.dart';
import 'package:mofa/src/domain/repositories/home_repository.dart';

class GetHomeStatisticsUseCase {
  final HomeRepository _homeRepository;

  GetHomeStatisticsUseCase(this._homeRepository);

  Future<DataState<List<HomeStatistics>>> call({
    required int pageSize,
    required int skip,
    required String sortColumnDirection,
    required String columnDirection,
  }) async {
    return await _homeRepository.getStatistics(
      skip: skip,
      pageSize: pageSize,
      sortColumnDirection: sortColumnDirection,
      columnDirection: columnDirection,
    );
  }
}
