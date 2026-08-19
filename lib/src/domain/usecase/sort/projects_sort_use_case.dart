import 'package:mofa/src/core/utils/format_time.dart';
import 'package:mofa/src/domain/entities/home/project.dart';
import 'package:mofa/src/domain/entities/shared/sort.dart';

class ProjectsSortUseCase {
  List<Project> sortProjects(List<Project> projects, Sort sort) {
    final sortedProjects = [...projects];

    switch (sort.id) {
      case 1: // A-Z by title
        sortedProjects.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 2: // Z-A by title
        sortedProjects.sort((a, b) => b.title.compareTo(a.title));
        break;
      case 3: // Ascending by start date
        sortedProjects.sort(
            (a, b) => compareDates(a.projectStartDate, b.projectStartDate));
        break;
      case 4: // Descending by start date
        sortedProjects
            .sort((a, b) => compareDates(b.projectEndDate, a.projectEndDate));
        break;
      default:
        break;
    }

    return sortedProjects;
  }
}
