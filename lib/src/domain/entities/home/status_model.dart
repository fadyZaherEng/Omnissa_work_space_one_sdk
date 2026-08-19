import 'package:equatable/equatable.dart';

class StatusModel extends Equatable {
  final int id;
  final int order;
  final String name;
  final String nameAr;
  final bool isAllowed;
  final bool isDisabled;
  final bool isForm;
  final int projectTab;

  const StatusModel({
    this.id = 0,
    this.order = 0,
    this.name = '',
    this.nameAr = '',
    this.isAllowed = false,
    this.isDisabled = false,
    this.isForm = false,
    this.projectTab = 0,
  });

  @override
  List<Object?> get props => [
        id,
        order,
        name,
        nameAr,
        isAllowed,
        isDisabled,
        isForm,
        projectTab,
      ];
}
