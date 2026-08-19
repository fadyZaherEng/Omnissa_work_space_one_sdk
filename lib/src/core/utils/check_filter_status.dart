import 'package:mofa/src/domain/entities/shared/filter.dart';

bool checkFilterStatus(
  bool matchesStatus,
  bool matchesDepartment,
  bool matchesStartDate,
  bool matchesEndDate,
  Filter filter,
) {
  if (filter.statusName.isNotEmpty &&
      filter.departmentName.isNotEmpty &&
      filter.startDate.isNotEmpty &&
      filter.endDate.isNotEmpty) {
    return matchesStatus &&
        matchesDepartment &&
        matchesStartDate &&
        matchesEndDate;
  } else if (filter.statusName.isNotEmpty &&
      filter.departmentName.isNotEmpty &&
      filter.startDate.isNotEmpty) {
    return matchesStatus && matchesDepartment && matchesStartDate;
  } else if (filter.statusName.isNotEmpty &&
      filter.departmentName.isNotEmpty &&
      filter.endDate.isNotEmpty) {
    return matchesStatus && matchesDepartment && matchesEndDate;
  } else if (filter.statusName.isNotEmpty &&
      filter.startDate.isNotEmpty &&
      filter.endDate.isNotEmpty) {
    return matchesStatus && matchesStartDate && matchesEndDate;
  } else if (filter.departmentName.isNotEmpty &&
      filter.startDate.isNotEmpty &&
      filter.endDate.isNotEmpty) {
    return matchesDepartment && matchesStartDate && matchesEndDate;
  } else if (filter.statusName.isNotEmpty && filter.startDate.isNotEmpty) {
    return matchesStatus && matchesStartDate;
  } else if (filter.statusName.isNotEmpty && filter.endDate.isNotEmpty) {
    return matchesStatus && matchesEndDate;
  } else if (filter.departmentName.isNotEmpty && filter.startDate.isNotEmpty) {
    return matchesDepartment && matchesStartDate;
  } else if (filter.departmentName.isNotEmpty && filter.endDate.isNotEmpty) {
    return matchesDepartment && matchesEndDate;
  } else if (filter.startDate.isNotEmpty && filter.endDate.isNotEmpty) {
    return matchesStartDate && matchesEndDate;
  } else if (filter.statusName.isNotEmpty) {
    return matchesStatus;
  } else if (filter.departmentName.isNotEmpty) {
    return matchesDepartment;
  } else if (filter.startDate.isNotEmpty) {
    return matchesStartDate;
  } else if (filter.endDate.isNotEmpty) {
    return matchesEndDate;
  }
  return false;
}
