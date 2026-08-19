import 'package:mofa/src/core/utils/format_time.dart';
import 'package:mofa/src/domain/entities/home/task.dart';
import 'package:mofa/src/domain/entities/shared/sort.dart';

class TasksSortUseCase {
  List<Task> sortTasks(List<Task> projects, Sort sort) {
    final sortedTasks = [...projects];

    switch (sort.id) {
      case 1: // A-Z by title
        sortedTasks.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 2: // Z-A by name
        sortedTasks.sort((a, b) => b.name.compareTo(a.name));
        break;
      case 3: // Ascending by start date
        sortedTasks
            .sort((a, b) => compareDates(a.taskStartDate, b.taskStartDate));
        break;
      case 4: // Descending by start date
        sortedTasks.sort((a, b) => compareDates(b.taskEndDate, a.taskEndDate));
        break;
      default:
        break; // No sorting
    }

    return sortedTasks;
  }
}
