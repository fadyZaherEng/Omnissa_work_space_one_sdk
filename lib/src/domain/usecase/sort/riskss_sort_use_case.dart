import 'package:mofa/src/core/utils/format_time.dart';
import 'package:mofa/src/domain/entities/home/risks.dart';
import 'package:mofa/src/domain/entities/shared/sort.dart';

class RisksSortUseCase {
  List<Risks> sortRisks(List<Risks> risks, Sort sort) {
    final sortedRisks = [...risks];

    switch (sort.id) {
      case 1: // A-Z by title
        sortedRisks.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 2: // Z-A by title
        sortedRisks.sort((a, b) => b.title.compareTo(a.title));
        break;
      case 3: // Ascending by start date
        sortedRisks
            .sort((a, b) => compareDates(a.creationDate, b.creationDate));
        break;
      case 4: // Descending by start date
        sortedRisks
            .sort((b, a) => compareDates(b.creationDate, a.creationDate));
        break;
      default:
        break; // No sorting
    }

    return sortedRisks;
  }
}
