import 'package:mofa/src/core/utils/format_time.dart';
import 'package:mofa/src/domain/entities/home/task_update_approval.dart';
import 'package:mofa/src/domain/entities/shared/sort.dart';

class TaskUpdateApprovalSortUseCase {
  List<TaskUpdateApproval> sortTaskUpdateApproval(
      List<TaskUpdateApproval> taskApproval, Sort sort) {
    final sortedChallenges = [...taskApproval];

    switch (sort.id) {
      case 1: // A-Z by title
        sortedChallenges.sort((a, b) => a.taskName.compareTo(b.taskName));
        break;
      case 2: // Z-A by taskName
        sortedChallenges.sort((a, b) => b.taskName.compareTo(a.taskName));
        break;
      case 3: // Ascending by start date
        sortedChallenges
            .sort((a, b) => compareDates(a.taskEndDate, b.taskEndDate));
        break;
      case 4: // Descending by start date
        sortedChallenges
            .sort((a, b) => compareDates(b.taskStartDate, a.taskStartDate));
        break;
      default:
        break; // No sorting
    }

    return sortedChallenges;
  }
}
