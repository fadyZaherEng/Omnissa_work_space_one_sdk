import 'package:json_annotation/json_annotation.dart';
import 'package:mofa/src/data/sources/remote/mofa/home/entity/remote_statistic_item.dart';
import 'package:mofa/src/domain/entities/home/home_static.dart';

part 'remote_home_statistics.g.dart';

@JsonSerializable()
class RemoteHomeStatistics {
  final String? title;
  final List<RemoteStaticsItem>? items;
  final bool? visible;

  const RemoteHomeStatistics({
    this.title = '',
    this.items = const [],
    this.visible = false,
  });

  factory RemoteHomeStatistics.fromJson(Map<String, dynamic> json) =>
      _$RemoteHomeStatisticsFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteHomeStatisticsToJson(this);
}

extension RemoteHomeStatisticsExt on RemoteHomeStatistics {
  HomeStatistics toDomain() => HomeStatistics(
        title: title ?? '',
        items: items?.map((e) => e.mapToDomain()).toList() ?? [],
        visible: visible ?? false,
      );
}

extension ListRemoteHomeStatisticsExt on List<RemoteHomeStatistics> {
  List<HomeStatistics> mapToDomain() => map((e) => e.toDomain()).toList();
}
