import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/core/resources/image_paths.dart';
import 'package:mofa/src/domain/entities/home/status_model.dart';

class StatusWithMarksWidget extends StatelessWidget {
  final bool isSelected;
  final StatusModel status;
  final void Function(StatusModel) onTap;

  const StatusWithMarksWidget({
    super.key,
    required this.isSelected,
    required this.status,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(status),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: isSelected ? ColorSchemes.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? ColorSchemes.primary : ColorSchemes.border,
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Center(
            child: Row(
              children: [
                Text(
                  status.name,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: isSelected
                            ? ColorSchemes.white
                            : ColorSchemes.border,
                        fontSize: 13,
                      ),
                ),
                if (isSelected) const SizedBox(width: 4),
                if (isSelected)
                  SvgPicture.asset(
                    ImagePaths.right,
                    width: 16,
                    height: 16,
                    color: ColorSchemes.white,
                    fit: BoxFit.scaleDown,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
