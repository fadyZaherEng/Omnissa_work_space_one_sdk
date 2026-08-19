import 'package:flutter/material.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/core/utils/constants.dart';
import 'package:mofa/src/presentation/widgets/custom_button_widget.dart';

class CommentBottomSheetWidget extends StatefulWidget {
  final void Function(String comment) onSend;

  const CommentBottomSheetWidget({
    super.key,
    required this.onSend,
  });

  @override
  State<CommentBottomSheetWidget> createState() =>
      _CommentBottomSheetWidgetState();
}

class _CommentBottomSheetWidgetState extends State<CommentBottomSheetWidget> {
  final TextEditingController _commentController = TextEditingController();
  String? _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: TextFormField(
            textAlign: TextAlign.start,
            maxLength: 500,
            controller: _commentController,
            minLines: null,
            maxLines: 10,
            onChanged: (value) {
              if (value.isEmpty) {
                _errorMessage = S.of(context).writeComment;
              } else {
                _errorMessage = null;
              }
              setState(() {});
            },
            decoration: InputDecoration(
              errorText: _errorMessage,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: ColorSchemes.primary),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: ColorSchemes.gray),
              ),
              hintText: S.of(context).writeComment,
              hintStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: Constants.fontWeightRegular,
                    color: ColorSchemes.black,
                    letterSpacing: -0.13,
                  ),
            ),
          ),
        ),
        const SizedBox(height: 64),
        CustomButtonWidget(
          onTap: () {
            if (_commentController.text.isEmpty) {
              _errorMessage = S.of(context).writeComment;
              setState(() {});
            } else {
              _errorMessage = null;
              widget.onSend(_commentController.text);
              setState(() {});
            }
          },
          text: S.of(context).confirm,
          backgroundColor: ColorSchemes.primary,
          height: 54,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
