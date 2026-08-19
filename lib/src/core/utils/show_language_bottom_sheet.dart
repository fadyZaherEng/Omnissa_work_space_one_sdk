import 'package:flutter/material.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/domain/entities/shared/sort.dart';
import 'package:mofa/src/presentation/screens/change_language/change_language_screen.dart';
import 'package:mofa/src/presentation/widgets/bottom_sheet_widget.dart';
import 'package:mofa/src/presentation/widgets/sort_bottom_sheet_widget.dart';

Future showLanguageBottomSheet({
  required BuildContext context,
  bool isBottomSheet = true,
  double? height,
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
          titleLabel: S.of(context).ChooseYourPreferredLanguage,
          height: height ?? 320,
          content: ChangeLanguageScreen(
            isBottomSheet: isBottomSheet,
          )),
    ),
  );
}
