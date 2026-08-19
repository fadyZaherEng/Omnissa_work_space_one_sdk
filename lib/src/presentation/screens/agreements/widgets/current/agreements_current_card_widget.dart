import 'package:flutter/material.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/core/resources/image_paths.dart';
import 'package:mofa/src/core/utils/constants.dart';
import 'package:mofa/src/core/utils/extensions/color_extension.dart';
import 'package:mofa/src/core/utils/format_date.dart';
import 'package:mofa/src/core/utils/show_massage_dialog_widget.dart';
import 'package:mofa/src/di/data_layer_injector.dart';
import 'package:mofa/src/domain/entities/home/form_approval.dart';
import 'package:mofa/src/domain/usecase/get_language_use_case.dart';
import 'package:mofa/src/presentation/widgets/build_header_app_card.dart';
import 'package:mofa/src/presentation/widgets/custom_button_with_prefix_icon_widget.dart';

class AgreementsCurrentCardWidget extends StatefulWidget {
  final FormApproval agreement;
  final void Function(FormApproval) onTap;
  final void Function(ActionsList) onAcceptTap;

  const AgreementsCurrentCardWidget({
    super.key,
    required this.agreement,
    required this.onTap,
    required this.onAcceptTap,
  });

  @override
  State<AgreementsCurrentCardWidget> createState() =>
      _AgreementsCurrentCardWidgetState();
}

class _AgreementsCurrentCardWidgetState
    extends State<AgreementsCurrentCardWidget> {
  @override
  void initState() {
    super.initState();
    actionsList = List<bool>.filled(widget.agreement.actionsList.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.onTap(widget.agreement),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ColorSchemes.border, width: 0.75),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: BuildHeaderAppCard(
                    title: widget.agreement.workflowFormName,
                    statusColor: ColorSchemes.primary,
                    status: widget.agreement.status.toString(),
                    id: "",
                    showStatus: false,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    formatDate(widget.agreement.creationDate.isEmpty
                        ? DateTime.now().toString()
                        : widget.agreement.creationDate),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: ColorSchemes.gray,
                          fontSize: 13,
                          fontWeight: Constants.fontWeightSemiBold,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(height: 0.75, color: ColorSchemes.border),
            const SizedBox(height: 12),

            buildUserAndDepartmentCard(
              context,
              widget.agreement.projectName,
              widget.agreement.details.info,
            ),
            const SizedBox(height: 12),

            /// Stage & Manager
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: _buildLabeledValue(
                      context,
                      label: S.of(context).currentStage,
                      value: widget.agreement.currentStage,
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(height: 0.75, color: ColorSchemes.border),
            const SizedBox(height: 12),

            /// 🔹 PWF Form Notice
            if (widget.agreement.workflowCategory == 1)
              _buildNotice(
                context,
                S.of(context).preferableToTakeActionFromWeb,
                Colors.orangeAccent,
              ),

            const SizedBox(height: 12),
            _buildButtonsOptions(context),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildNotice(BuildContext context, String message, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min, // 👈 shrink-wrap the row
        children: [
          Icon(Icons.info_outline, color: color, size: 18),
          const SizedBox(width: 8),

          /// Instead of Expanded → use Flexible (loose fit) or just wrap in ConstrainedBox
          Flexible(
            fit: FlexFit.loose, // 👈 allows wrapping instead of infinite expand
            child: Text(
              message,
              softWrap: true,
              overflow: TextOverflow.ellipsis, // 👈 prevent overflow
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  bool _isPwfForm(String formName) {
    // adjust to your logic / list of PWF forms
    const pwfForms = ['PWFForm1', 'PWFForm2', 'PWFForm3'];
    return pwfForms.contains(formName);
  }

  Widget _buildLabeledValue(
    BuildContext context, {
    required String label,
    required String value,
    Color? color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: ColorSchemes.gray,
                fontSize: 13,
                fontWeight: Constants.fontWeightSemiBold,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: color ?? ColorSchemes.black,
                fontWeight: Constants.fontWeightSemiBold,
              ),
        ),
      ],
    );
  }

  List<bool> actionsList = [];

  Widget _buildButtonsOptions(BuildContext context) {
    // fill actionsList with false values based on the number of actions
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: widget.agreement.actionsList.asMap().entries.map((e) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          /// 📎 Attachment icon
                          if (e.value.isRequiredAttachments)
                            GestureDetector(
                              onTap: () {
                                actionsList = List<bool>.filled(
                                  widget.agreement.actionsList.length,
                                  false,
                                );

                                // update actionsList to true
                                print('ActionsList: ${actionsList[e.key]}');
                                actionsList[e.key] = true;
                                print('ActionsList: ${actionsList[e.key]}');

                                // set state to update UI
                                setState(() {});

                                // reset actionsList after 2 seconds if needed
                                // Future.delayed(const Duration(seconds: 2), () {
                                //   actionsList[e.key] = false;
                                //   setState(() {});
                                // });
                              },
                              child: Transform.rotate(
                                angle: -1.57, // rotate clip icon
                                child: Icon(
                                  Icons.attachment,
                                  size: 24,
                                  color: e.value.isRequiredAttachments
                                      ? Colors.redAccent
                                      : Colors.grey,
                                ),
                              ),
                            ),
                          const SizedBox(width: 6),

                          /// ✅ Main action button
                          CustomButtonWithPrefixIconWidget(
                            onTap: () => actionsList[e.key] == true
                                ? setState(() {
                                    actionsList[e.key] = true;
                                  })
                                : widget.onAcceptTap(e.value),
                            text: GetLanguageUseCase(injector())() == 'en'
                                ? e.value.nameEn
                                : e.value.nameAr,
                            backgroundColor: e.value.backgroundColor.toColor(),
                            textColor: e.value.color.toColor(),
                            svgIcon: ImagePaths.approveNew,
                          ),
                          if (e.value.isRequiredAttachments)
                            const SizedBox(width: 6),
                        ],
                      ),

                      const SizedBox(height: 8),

                      /// 🔹 Required Attachments Notice
                      if (e.value.isRequiredAttachments && actionsList[e.key])
                        _buildNotice(
                          context,
                          S.of(context).thisRequestRequiresAttachments,
                          Colors.redAccent,
                        ),
                    ],
                  ),
                  const SizedBox(width: 16),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  // Widget _buildButtonsOptions(BuildContext context) {
  Widget buildUserAndDepartmentCard(
      BuildContext context, String value, String details) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).projectManager,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: ColorSchemes.gray,
                        fontSize: 13,
                        fontWeight: Constants.fontWeightSemiBold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: ColorSchemes.black,
                        fontWeight: Constants.fontWeightSemiBold,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final textSpan = TextSpan(
                  text: details,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: ColorSchemes.gray,
                        fontSize: 13,
                        fontWeight: Constants.fontWeightSemiBold,
                      ),
                );

                final textPainter = TextPainter(
                  text: textSpan,
                  maxLines: 2,
                  textDirection: TextDirection.ltr,
                )..layout(maxWidth: constraints.maxWidth);

                final isOverflowing = textPainter.didExceedMaxLines;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      details,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: ColorSchemes.gray,
                            fontSize: 13,
                            fontWeight: Constants.fontWeightSemiBold,
                          ),
                    ),
                    if (isOverflowing)
                      GestureDetector(
                        onTap: () {
                          showMassageDialogWidget(
                            context: context,
                            text: details,
                            icon: ImagePaths.logo,
                            buttonText: S.of(context).ok,
                            onTap: () {
                              Navigator.pop(context);
                            },
                          );
                        },
                        child: Text(
                          S.of(context).showMore,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// class AgreementsCurrentCardWidget extends StatelessWidget {
//   final FormApproval agreement;
//   final void Function(FormApproval) onTap;
//   final void Function(ActionsList) onAcceptTap;
//
//   const AgreementsCurrentCardWidget({
//     super.key,
//     required this.agreement,
//     required this.onTap,
//     required this.onAcceptTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () => onTap(agreement),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: ColorSchemes.border, width: 0.75),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 16),
//             Row(
//               children: [
//                 Expanded(
//                   flex: 2,
//                   child: BuildHeaderAppCard(
//                     title: agreement.workflowFormName,
//                     statusColor: ColorSchemes.primary,
//                     status: agreement.status.toString(),
//                     id: "",
//                     showStatus: false,
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 Expanded(
//                   child: Text(
//                     formatDate(agreement.creationDate.isEmpty
//                         ? DateTime.now().toString()
//                         : agreement.creationDate),
//                     style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                           color: ColorSchemes.gray,
//                           fontSize: 13,
//                           fontWeight: Constants.fontWeightSemiBold,
//                         ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 12),
//             Container(height: 0.75, color: ColorSchemes.border),
//             const SizedBox(height: 12),
//             // BuildUserAndDepartmentCardWidget(
//             //   name: agreement.projectName,
//             //   label: S.of(context).creationDate,
//             //   value: "",
//             // ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: _buildLabeledValue(
//                       context,
//                       label: S.of(context).currentStage,
//                       value: agreement.currentStage,
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   // Expanded(
//                   //   child: _buildLabeledValue(
//                   //     context,
//                   //     label: S.of(context).creationDate,
//                   //     value: ConvertDateFormat.convertDateFormat(
//                   //       agreement.creationDate.isEmpty
//                   //           ? DateTime.now().toString()
//                   //           : agreement.creationDate,
//                   //     ),
//                   //   ),
//                   // ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 12),
//             buildUserAndDepartmentCard(
//               context,
//               agreement.projectName,
//               agreement.details.info,
//             ),
//             const SizedBox(height: 12),
//             Container(height: 0.75, color: ColorSchemes.border),
//             const SizedBox(height: 12),
//             _buildButtonsOptions(context),
//             const SizedBox(height: 16),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildLabeledValue(
//     BuildContext context, {
//     required String label,
//     required String value,
//     Color? color,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                 color: ColorSchemes.gray,
//                 fontSize: 13,
//                 fontWeight: Constants.fontWeightSemiBold,
//               ),
//         ),
//         const SizedBox(height: 4),
//         Text(
//           value,
//           style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                 color: color ?? ColorSchemes.black,
//                 fontWeight: Constants.fontWeightSemiBold,
//               ),
//         ),
//       ],
//     );
//   }
//
// }
