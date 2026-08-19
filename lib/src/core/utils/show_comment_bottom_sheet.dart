import 'package:flutter/material.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/presentation/widgets/bottom_sheet_widget.dart';
import 'package:mofa/src/presentation/widgets/comment_bottom_sheet_widget.dart';

Future showCommentBottomSheet({
  required BuildContext context,
  double? height,
  required void Function(String comment) onSend,
}) async {
  return await showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    enableDrag: false,
    isScrollControlled: true,
    builder: (context) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 8,
        left: 8,
        right: 8,
      ),
      child: BottomSheetWidget(
        titleLabel: S.of(context).comment,
        height: height ?? 440,
        content: CommentBottomSheetWidget(
          onSend: onSend,
        ),
      ),
    ),
  );
}
