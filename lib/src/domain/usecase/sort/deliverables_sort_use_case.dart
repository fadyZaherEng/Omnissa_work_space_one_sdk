import 'package:mofa/src/core/utils/format_time.dart';
import 'package:mofa/src/domain/entities/home/deliverables.dart';
import 'package:mofa/src/domain/entities/shared/sort.dart';

class DeliverablesSortUseCase {
  List<Deliverbles> sortDeliverables(
      List<Deliverbles> deliverables, Sort sort) {
    final sortedChallenges = [...deliverables];

    switch (sort.id) {
      case 1: // A-Z by title
        sortedChallenges
            .sort((a, b) => a.deliverableName.compareTo(b.deliverableName));
        break;
      case 2: // Z-A by deliverableName
        sortedChallenges
            .sort((a, b) => b.deliverableName.compareTo(a.deliverableName));
        break;
      case 3: // Ascending by start date
        sortedChallenges
            .sort((a, b) => compareDates(a.projectEndDate, b.projectEndDate));
        break;
      case 4: // Descending by start date
        sortedChallenges.sort(
            (a, b) => compareDates(b.projectStartDate, a.projectStartDate));
        break;
      default:
        break; // No sorting
    }

    return sortedChallenges;
  }
}
