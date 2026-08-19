import 'package:equatable/equatable.dart';

class Filter extends Equatable {
  final String statusName;
  final String departmentName;
  final int? statusId;
  final String? departmentId;
  final String? ownerId;
  final String ownerName;
  final String startDate;
  final String endDate;

  const Filter({
    required this.startDate,
    required this.endDate,
    required this.statusName,
    required this.departmentName,
    required this.statusId,
    required this.departmentId,
    required this.ownerId,
    required this.ownerName,
  });

  @override
  List<Object?> get props => [
        startDate,
        endDate,
        statusName,
        departmentName,
        statusId,
        departmentId,
        ownerId,
        ownerName,
      ];

  Filter copyWith({
    String? startDate,
    String? endDate,
    String? statusName,
    String? departmentName,
    int? statusId,
    String? departmentId,
    String? ownerId,
    String? ownerName,
  }) {
    return Filter(
      statusName: statusName ?? this.statusName,
      departmentName: departmentName ?? this.departmentName,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      statusId: statusId ?? this.statusId,
      departmentId: departmentId ?? this.departmentId,
      ownerId: ownerId ?? this.ownerId,
      ownerName: ownerName ?? this.ownerName,
    );
  }
}
