import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';

class Status extends Equatable {
  final int id;
  final String name;
  final String description;
  final double percentage;
  final Color color;

  const Status({
    this.id = 0,
    this.description = '',
    this.name = '',
    this.percentage = 0,
    this.color = ColorSchemes.blue,
  });

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      name: json['name'] ?? '',
      percentage: (json['value'] as num?)?.toDouble() ?? 0.0,
      color: _colorFromString(json['color'] ?? ''),
    );
  }

  static Color _colorFromString(String colorName) {
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

  @override
  List<Object?> get props => [name, percentage, color];
}
