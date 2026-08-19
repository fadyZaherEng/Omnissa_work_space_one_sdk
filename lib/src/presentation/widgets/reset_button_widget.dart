import 'package:flutter/material.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';

class ResetButtonWidget extends StatelessWidget {
  final Function() onTap;

  const ResetButtonWidget({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: ColorSchemes.white,
          border: Border.all(
            color: ColorSchemes.border,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          S.of(context).reset,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 13,
                color: ColorSchemes.redError,
                letterSpacing: -0.24,
              ),
        ),
      ),
    );
  }
}
