import 'package:mofa/src/core/utils/format_time.dart';
import 'package:mofa/src/domain/entities/home/pointers_tool.dart';
import 'package:mofa/src/domain/entities/shared/sort.dart';

class PointersSortUseCase {
  List<PointersTool> sortPointers(List<PointersTool> projects, Sort sort) {
    final sortedPointers = [...projects];

    switch (sort.id) {
      case 1: // A-Z by title
        sortedPointers.sort((a, b) => a.kpiBankName.compareTo(b.kpiBankName));
        break;
      case 2: // Z-A by kpiBankName
        sortedPointers.sort((a, b) => b.kpiBankName.compareTo(a.kpiBankName));
        break;
      case 3: // Ascending by start date
        sortedPointers
            .sort((a, b) => compareDates(a.creationDate, b.creationDate));
        break;
      case 4: // Ascending by start date
        sortedPointers
            .sort((b, a) => compareDates(a.creationDate, b.creationDate));
        break;
      default:
        break; // No sorting
    }

    return sortedPointers;
  }
}
