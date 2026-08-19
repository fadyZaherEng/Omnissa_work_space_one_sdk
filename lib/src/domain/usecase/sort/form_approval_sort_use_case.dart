import 'package:mofa/src/core/utils/format_time.dart';
import 'package:mofa/src/domain/entities/home/form_approval.dart';
import 'package:mofa/src/domain/entities/shared/sort.dart';

class FormApprovalSortUseCase {
  List<FormApproval> sortFormApproval(List<FormApproval> forms, Sort sort) {
    final sortedChallenges = [...forms];

    switch (sort.id) {
      case 1: // A-Z by title
        sortedChallenges.sort((a, b) => a.projectName.compareTo(b.projectName));
        break;
      case 2: // Z-A by title
        sortedChallenges.sort((a, b) => b.projectName.compareTo(a.projectName));
        break;

      case 3: // Ascending by start date
        sortedChallenges
            .sort((a, b) => compareDates(a.creationDate, b.creationDate));
        break;
      case 4: // Descending by start date
        sortedChallenges
            .sort((a, b) => compareDates(b.creationDate, a.creationDate));
        break;
      default:
        break; // No sorting
    }

    return sortedChallenges;
  }
}
