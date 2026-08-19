import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:flutter/material.dart';
import 'package:mofa/src/core/utils/constants.dart';

class CustomButtonWidget extends StatelessWidget {
  final void Function() onTap;
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final double? height;
  final double? width;
  final double borderWidth;
  final double buttonBorderRadius;
  final FontWeight fontWeight;
  final TextStyle? textStyle;
  final bool isLoading;
  final bool isPaddingVertical;

  const CustomButtonWidget({
    super.key,
    required this.onTap,
    required this.text,
    required this.backgroundColor,
    this.textColor = ColorSchemes.white,
    this.height = 54,
    this.width = double.infinity,
    this.borderWidth = 1,
    this.borderColor = Colors.transparent,
    this.buttonBorderRadius = 8,
    this.fontWeight = Constants.fontWeightSemiBold,
    this.textStyle,
    this.isLoading = false,
    this.isPaddingVertical = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ButtonStyle(
          textStyle: MaterialStateProperty.all<TextStyle>(
            Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: textColor,
                  letterSpacing: 0.24,
                  fontWeight: fontWeight,
                ),
          ),
          elevation: MaterialStateProperty.all<double>(0),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(buttonBorderRadius),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
          side: MaterialStateProperty.all<BorderSide>(
            BorderSide(color: borderColor, width: borderWidth),
          ),
          padding: isPaddingVertical == true
              ? null
              : MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.symmetric(horizontal: 6)),
        ),
        onPressed: isLoading ? null : onTap,
        child: Padding(
          padding: isPaddingVertical == true
              ? const EdgeInsets.symmetric(vertical: 10, horizontal: 24)
              : const EdgeInsets.symmetric(horizontal: 0),
          child: isLoading
              ? SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: textColor,
                    strokeWidth: 2,
                  ),
                )
              : Text(
                  text,
                  style: textStyle ??
                      Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: textColor,
                            letterSpacing: 0.24,
                            fontWeight: fontWeight,
                          ),
                ),
        ),
      ),
    );
  }
}
