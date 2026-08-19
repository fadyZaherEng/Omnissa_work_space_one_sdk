import 'package:mofa/src/core/utils/format_time.dart';
import 'package:mofa/src/domain/entities/home/milstones.dart';
import 'package:mofa/src/domain/entities/shared/sort.dart';

class MilstonesSortUseCase {
  List<Milstones> sortMilstones(List<Milstones> milstones, Sort sort) {
    final sortedChallenges = [...milstones];

    switch (sort.id) {
      case 1: // A-Z by title
        sortedChallenges.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 2: // Z-A by name
        sortedChallenges.sort((a, b) => b.name.compareTo(a.name));
        break;
      case 3: // Ascending by start date
        sortedChallenges.sort((a, b) => compareDates(a.endDate, b.endDate));
        break;
      case 4: // Descending by start date
        sortedChallenges.sort((a, b) => compareDates(b.startDate, a.startDate));
        break;
      default:
        break; // No sorting
    }

    return sortedChallenges;
  }
}
