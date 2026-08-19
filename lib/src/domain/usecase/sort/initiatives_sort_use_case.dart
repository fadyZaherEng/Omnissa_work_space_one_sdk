import 'package:mofa/src/core/utils/format_time.dart';
import 'package:mofa/src/domain/entities/home/project.dart';
import 'package:mofa/src/domain/entities/shared/sort.dart';

class InitiativesSortUseCase {
  List<Project> sortInitiatives(List<Project> projects, Sort sort) {
    final sortedInitiatives = [...projects];

    switch (sort.id) {
      case 1: // A-Z by title
        sortedInitiatives.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 2: // Z-A by title
        sortedInitiatives.sort((a, b) => b.title.compareTo(a.title));
        break;
      case 3: // Ascending by start date
        sortedInitiatives.sort(
            (a, b) => compareDates(a.projectStartDate, b.projectStartDate));
        break;
      case 4: // Descending by start date
        sortedInitiatives
            .sort((a, b) => compareDates(b.projectEndDate, a.projectEndDate));
        break;
      default:
        break; // No sorting
    }

    return sortedInitiatives;
  }
}
