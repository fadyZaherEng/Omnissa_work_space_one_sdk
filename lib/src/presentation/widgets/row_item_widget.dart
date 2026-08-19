import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/core/resources/image_paths.dart';
import 'package:mofa/src/presentation/widgets/notification_switch_button_widget.dart';

class RowItemWidget extends StatelessWidget {
  final String path;
  final String title;
  final void Function() onTap;
  final bool isLast;
  final String text;
  final bool isSwitch;
  final bool isAllowNotification;
  final void Function(bool)? onAllowNotification;
  final bool isDelete;

  const RowItemWidget({
    super.key,
    required this.path,
    required this.onTap,
    required this.title,
    this.isLast = false,
    this.text = "",
    this.isAllowNotification = false,
    this.onAllowNotification,
    this.isSwitch = false,
    this.isDelete = false,
  });

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  path,
                  width: 24,
                  height: 24,
                  fit: BoxFit.scaleDown,
                  color: //isLast ? ColorSchemes.redError :
                      ColorSchemes.primary,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: //isLast ? ColorSchemes.redError :
                              ColorSchemes.black,
                          fontSize: 14,
                        ),
                  ),
                ),
                if (text.isNotEmpty)
                  Text(
                    text,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: ColorSchemes.gray,
                          fontSize: 14,
                        ),
                  ),
                if (isSwitch)
                  NotificationsSwitchButtonWidget(
                    value: isAllowNotification,
                    onTap: onAllowNotification ?? (_) {},
                  ),
                if (!isSwitch && text.isEmpty && !isDelete)
                  Transform(
                    alignment: Alignment.center,
                    transform: !isRtl
                        ? Matrix4.rotationY(3.14159)
                        : Matrix4.rotationY(0),
                    child: SvgPicture.asset(
                      ImagePaths.arrowLeft,
                      width: 24,
                      height: 24,
                      fit: BoxFit.scaleDown,
                      color: ColorSchemes.gray,
                    ),
                  ),
              ],
            ),
            if (!isLast)
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                height: 1.4,
                color: ColorSchemes.moreBackground,
              ),
            if (isLast) const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
