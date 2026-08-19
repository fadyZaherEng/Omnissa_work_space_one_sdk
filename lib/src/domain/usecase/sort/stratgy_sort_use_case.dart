import 'package:mofa/src/core/utils/format_time.dart';
import 'package:mofa/src/domain/entities/home/stratgy.dart';
import 'package:mofa/src/domain/entities/shared/sort.dart';

class StratgySortUseCase {
  List<Strategy> sortStratgy(List<Strategy> projects, Sort sort) {
    final sortedStrategys = [...projects];

    switch (sort.id) {
      case 1: // A-Z by title
        sortedStrategys.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 2: // Z-A by name
        sortedStrategys.sort((a, b) => b.name.compareTo(a.name));
        break;
      case 3: // Ascending by start date
        sortedStrategys.sort((a, b) => compareDates(a.startDate, b.startDate));
        break;
      case 4: // Descending by start date
        sortedStrategys.sort((a, b) => compareDates(b.startDate, a.startDate));
        break;
      default:
        break; // No sorting
    }

    return sortedStrategys;
  }
}
