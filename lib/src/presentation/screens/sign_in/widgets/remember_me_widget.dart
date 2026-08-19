import 'package:flutter/material.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';

class RememberMeWidget extends StatelessWidget {
  final bool isCheckRememberMe;
  final Function() onTap;
  final void Function(bool value) onChange;

  const RememberMeWidget({
    super.key,
    required this.isCheckRememberMe,
    required this.onTap,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Checkbox(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
            side: const BorderSide(color: ColorSchemes.lightGray),
            activeColor: ColorSchemes.primary,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            tristate: true,
            value: isCheckRememberMe,
            onChanged: (value) => onChange(!isCheckRememberMe),
          ),
          Text(
            S.of(context).rememberMe,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: ColorSchemes.black,
                  letterSpacing: -0.13,
                ),
          ),
        ],
      ),
    );
  }
}
