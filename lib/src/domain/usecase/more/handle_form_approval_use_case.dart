import 'package:mofa/src/core/resources/data_state.dart';
import 'package:mofa/src/data/sources/remote/mofa/more/request/request_handle_form_approval.dart';
import 'package:mofa/src/domain/repositories/more_repository.dart';

class HandleFormApprovalUseCase {
  final MoreRepository _moreRepository;

  HandleFormApprovalUseCase(this._moreRepository);

  Future<DataState<String>> call({
    required RequestHandleFormApproval request,
  }) async {
    return await _moreRepository.handleFormsApprovals(request: request);
  }
}
