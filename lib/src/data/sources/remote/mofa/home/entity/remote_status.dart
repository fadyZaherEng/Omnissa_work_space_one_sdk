import 'package:json_annotation/json_annotation.dart';
import 'package:mofa/src/domain/entities/home/status_model.dart';

part 'remote_status.g.dart';

@JsonSerializable()
class RemoteStatus {
  final int? id;
  final int? order;
  final String? name;
  final String? nameAr;
  final bool? isAllowed;
  final bool? isDisabled;
  final bool? isForm;
  final int? projectTab;

  const RemoteStatus({
    this.id = 0,
    this.order = 0,
    this.name = '',
    this.nameAr = '',
    this.isAllowed = false,
    this.isDisabled = false,
    this.isForm = false,
    this.projectTab = 0,
  });

  factory RemoteStatus.fromJson(Map<String, dynamic> json) =>
      _$RemoteStatusFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteStatusToJson(this);
}

extension RemoteStatusExtension on RemoteStatus {
  StatusModel toDomain() => StatusModel(
        id: id ?? 0,
        order: order ?? 0,
        name: name ?? '',
        nameAr: nameAr ?? '',
        isAllowed: isAllowed ?? false,
        isDisabled: isDisabled ?? false,
        isForm: isForm ?? false,
        projectTab: projectTab ?? 0,
      );
}

extension RemoteStatusListExtension on List<RemoteStatus> {
  List<StatusModel> toDomain() => map((e) => e.toDomain()).toList();
}
