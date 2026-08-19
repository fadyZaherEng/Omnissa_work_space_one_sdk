import 'package:json_annotation/json_annotation.dart';
import 'package:mofa/src/domain/entities/home/home_statics_item.dart';

part 'remote_statistic_item.g.dart';

@JsonSerializable()
class RemoteStaticsItem {
  final String? label;
  final String? color;
  final int? count;

  const RemoteStaticsItem({
    this.label = "",
    this.color = "",
    this.count = 0,
  });

  factory RemoteStaticsItem.fromJson(Map<String, dynamic> json) =>
      _$RemoteStaticsItemFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteStaticsItemToJson(this);
}

extension MapToDomain on RemoteStaticsItem {
  HomeStaticsItem mapToDomain() => HomeStaticsItem(
        label: label ?? '',
        color: color ?? '',
        count: count ?? 0,
      );
}

extension MapToDomainList on List<RemoteStaticsItem> {
  List<HomeStaticsItem> mapToDomain() => map((e) => e.mapToDomain()).toList();
}
