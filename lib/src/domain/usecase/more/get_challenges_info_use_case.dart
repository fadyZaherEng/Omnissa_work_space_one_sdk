import 'package:mofa/src/core/resources/data_state.dart';
import 'package:mofa/src/domain/entities/home/challenges.dart';
import 'package:mofa/src/domain/repositories/more_repository.dart';

class GetChallengesInfoUseCase {
  final MoreRepository _moreRepository;

  GetChallengesInfoUseCase(this._moreRepository);

  Future<DataState<Challenges>> call({
    required String id,
  }) async {
    return await _moreRepository.getIssueInfo(id: id);
  }
}
