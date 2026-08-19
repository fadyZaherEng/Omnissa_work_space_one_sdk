import 'package:flutter/material.dart';
import 'package:mofa/src/di/data_layer_injector.dart';
import 'package:mofa/src/domain/entities/shared/status.dart';
import 'package:mofa/src/domain/usecase/get_language_use_case.dart';

class ProgressHorizontalIndicatorWidget extends StatelessWidget {
  final Status status;
  final bool isLabelBottom;
  final double? width;

  const ProgressHorizontalIndicatorWidget({
    super.key,
    required this.status,
    this.isLabelBottom = false,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final clampedPercentage = (status.percentage / 100).clamp(0.0, 1.0);

    return LayoutBuilder(builder: (context, constraints) {
      final fullWidth = width ?? constraints.maxWidth;
      final activeWidth = (status.percentage <= 0)
          ? fullWidth * clampedPercentage
          : fullWidth * clampedPercentage + 10;
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              // Background Bar
              Container(
                width: fullWidth,
                height: 12,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(230, 233, 240, 0.4),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              // Active Progress Bar
              Stack(
                children: [
                  Container(
                    width: activeWidth,
                    height: 12,
                    decoration: BoxDecoration(
                      color: status.color,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  if (!isLabelBottom && status.name.isEmpty)
                    Positioned(
                      left: GetLanguageUseCase(injector())() == 'ar'
                          ? null
                          : status.percentage < 10
                              ? 0
                              : 10,
                      right:
                          GetLanguageUseCase(injector())() == 'en' ? null : 10,
                      child: Text(
                        '${(clampedPercentage * 100).toInt()}%',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                ],
              ),
            ],
          ),
          if (isLabelBottom || status.name.isNotEmpty)
            const SizedBox(height: 8),
          if (isLabelBottom || status.name.isNotEmpty)
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                status.name.isNotEmpty
                    ? status.name
                    : '   ${(clampedPercentage * 100).toInt()}%',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
        ],
      );
    });
  }
}
