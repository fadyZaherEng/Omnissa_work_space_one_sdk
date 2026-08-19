import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/domain/entities/shared/status.dart';

part 'remote_kpi_values.g.dart';

@JsonSerializable()
class RemoteKpiValues {
  final String? name;
  final String? description;
  final int? value;
  final String? color;

  const RemoteKpiValues({
    this.name = '',
    this.description = '',
    this.value = 0,
    this.color = '',
  });

  factory RemoteKpiValues.fromJson(Map<String, dynamic> json) =>
      _$RemoteKpiValuesFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteKpiValuesToJson(this);
}

extension RemoteKpiValuesExt on RemoteKpiValues {
  Status mapToDomain() => Status(
        name: name ?? '',
        description: description ?? '',
        percentage: (value ?? 0).toDouble(),
        id: 0,
        color: colorFromString(color ?? ''),
      );
}

Color colorFromString(String colorName) {
  if (colorName.isEmpty) return ColorSchemes.blue;

  final lower = colorName.toLowerCase().trim();

  // ألوان نصية محددة
  switch (lower) {
    case 'red':
      return Colors.red;
    case 'green':
      return Colors.green;
    case 'blue':
      return Colors.blue;
    case 'orange':
      return Colors.orange;
    case 'yellow':
      return Colors.yellow;
    case 'purple':
      return Colors.purple;
    case 'grey':
    case 'gray':
      return Colors.grey;
  }

  // التحقق إذا Hex code
  final hexPattern = RegExp(r'^#?([0-9a-f]{6}|[0-9a-f]{8})$');
  if (hexPattern.hasMatch(lower)) {
    String hex = lower.replaceFirst('#', '');
    if (hex.length == 6) {
      hex = 'FF$hex'; // إضافة الشفافية الافتراضية
    }
    return Color(int.parse(hex, radix: 16));
  }

  // التحقق إذا 0xFFxxxxxx
  if (lower.startsWith('0x') && lower.length == 10) {
    try {
      return Color(int.parse(lower));
    } catch (_) {}
  }

  // لون افتراضي إذا فشل كل شيء
  return ColorSchemes.blue;
}
