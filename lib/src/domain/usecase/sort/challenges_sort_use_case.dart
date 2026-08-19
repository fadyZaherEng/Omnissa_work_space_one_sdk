import 'package:mofa/src/core/utils/format_time.dart';
import 'package:mofa/src/domain/entities/home/challenges.dart';
import 'package:mofa/src/domain/entities/shared/sort.dart';

class ChallengesSortUseCase {
  List<Challenges> sortChallenges(List<Challenges> challenges, Sort sort) {
    final sortedChallenges = [...challenges];

    switch (sort.id) {
      case 1: // A-Z by title
        sortedChallenges.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 2: // Z-A by title
        sortedChallenges.sort((a, b) => b.title.compareTo(a.title));
        break;
      case 3: // Ascending by start date
        sortedChallenges.sort((a, b) => compareDates(a.endDate, b.endDate));
        break;
      case 4: // Descending by start date
        sortedChallenges.sort((b, a) => compareDates(b.endDate, a.endDate));
        break;
      default:
        break; // No sorting
    }

    return sortedChallenges;
  }
}
