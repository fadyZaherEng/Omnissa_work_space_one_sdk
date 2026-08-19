import 'package:mofa/src/core/utils/format_time.dart';
import 'package:mofa/src/domain/entities/home/agreement.dart';
import 'package:mofa/src/domain/entities/shared/sort.dart';

class AgreementsSortUseCase {
  List<Agreements> sortAgreements(List<Agreements> agreements, Sort sort) {
    final sortedAgreements = [...agreements];

    switch (sort.id) {
      case 1: // A-Z by title
        sortedAgreements.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 2: // Z-A by title
        sortedAgreements.sort((a, b) => b.title.compareTo(a.title));
        break;
      case 3: // Ascending by start date
        sortedAgreements
            .sort((a, b) => compareDates(a.creationDate, b.creationDate));
        break;
      case 4: // Descending by start date
        sortedAgreements
            .sort((b, a) => compareDates(b.creationDate, a.creationDate));
        break;
      default:
        break; // No sorting
    }

    return sortedAgreements;
  }
}
