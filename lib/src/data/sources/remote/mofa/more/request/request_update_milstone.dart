import 'package:json_annotation/json_annotation.dart';

part 'request_update_milstone.g.dart';

@JsonSerializable()
class RequestUpdateMilstone {
  final String? id;
  final String? note;

  const RequestUpdateMilstone({
    this.id,
    this.note,
  });

  factory RequestUpdateMilstone.fromJson(Map<String, dynamic> json) =>
      _$RequestUpdateMilstoneFromJson(json);

  Map<String, dynamic> toJson() => _$RequestUpdateMilstoneToJson(this);
}
