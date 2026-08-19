import 'package:flutter/material.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';

class StatusWidget extends StatelessWidget {
  final Color statusColor;
  final String statusMessage;
  final bool isProject;

  const StatusWidget({
    super.key,
    required this.statusColor,
    required this.statusMessage,
    this.isProject = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: statusColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        statusMessage,
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(fontSize: 14, color: ColorSchemes.white),
      ),
    );
  }
}
