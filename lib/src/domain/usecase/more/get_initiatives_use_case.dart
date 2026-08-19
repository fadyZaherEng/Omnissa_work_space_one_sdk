import 'package:mofa/src/core/resources/data_state.dart';
import 'package:mofa/src/domain/entities/home/project.dart';
import 'package:mofa/src/domain/repositories/more_repository.dart';

class GetInitiativesUseCase {
  final MoreRepository _moreRepository;

  GetInitiativesUseCase(this._moreRepository);

  Future<DataState<List<Project>>> call({
    required int pageSize,
    required int skip,
    required String sortColumnDirection,
    required String columnDirection,
  }) async {
    return await _moreRepository.getInitiatives(
      pageSize: pageSize,
      skip: skip,
      sortColumnDirection: sortColumnDirection,
      columnDirection: columnDirection,
    );
  }
}
