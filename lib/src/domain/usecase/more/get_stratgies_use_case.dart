import 'package:mofa/src/core/resources/data_state.dart';
import 'package:mofa/src/domain/entities/home/stratgy.dart';
import 'package:mofa/src/domain/repositories/more_repository.dart';

class GetStratygiesUseCase {
  final MoreRepository _moreRepository;

  GetStratygiesUseCase(this._moreRepository);

  Future<DataState<List<Strategy>>> call({
    required bool isMonitoringAndExecution,
    required int pageSize,
    required int skip,
    required String sortColumnDirection,
    required String columnDirection,
  }) async {
    return await _moreRepository.getStrategies(
      isMonitoringAndExecution: isMonitoringAndExecution,
      pageSize: pageSize,
      skip: skip,
      sortColumnDirection: sortColumnDirection,
      columnDirection: columnDirection,
    );
  }
}
