import 'package:flutter/material.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/core/resources/image_paths.dart';
import 'package:mofa/src/core/utils/constants.dart';
import 'package:mofa/src/core/utils/extensions/color_extension.dart';
import 'package:mofa/src/core/utils/format_date.dart';
import 'package:mofa/src/di/data_layer_injector.dart';
import 'package:mofa/src/domain/entities/home/project.dart';
import 'package:mofa/src/domain/entities/shared/status.dart';
import 'package:mofa/src/domain/usecase/get_language_use_case.dart';
import 'package:mofa/src/presentation/widgets/expandble_scetion.dart';
import 'package:mofa/src/presentation/widgets/status_widget.dart';

class InformationCardWidget extends StatefulWidget {
  final Project information;
  final void Function(Project) onTap;
  final TextEditingController commentController;

  String? errorMessage;
  final void Function(Project) onSubmit;

  InformationCardWidget({
    super.key,
    required this.information,
    required this.onTap,
    required this.commentController,
    this.errorMessage,
    required this.onSubmit,
  });

  @override
  State<InformationCardWidget> createState() => _InformationCardWidgetState();
}

class _InformationCardWidgetState extends State<InformationCardWidget> {
  bool isAssumptionsExpanded = false;

  bool isDescriptionWithinScopeExpanded = false;

  bool isDescriptionsExpanded = false;

  bool isDescriptionOutsideScopeExpanded = false;
  bool isLatestUpdatesExpanded = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.onTap(widget.information),
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
            _buildHeader(context),
            const SizedBox(height: 12),
            Container(height: 0.75, color: ColorSchemes.border),
            const SizedBox(height: 12),
            _buildInformationRow(
              context,
              S.of(context).department,
              widget.information.departmentName,
              S.of(context).projectManager,
              widget.information.projectManagerStr,
            ),
            // BuildUserAndDepartmentCardIconWidget(
            //   name: widget.information.departmentName,
            // ),
            const SizedBox(height: 16),
            _buildInformationRow(
              context,
              S.of(context).projectOwner,
              widget.information.projectOwnerName,
              S.of(context).projectSponsor,
              widget.information.projectSponsorName,
            ),
            const SizedBox(height: 16),
            _buildInformationRow(
              context,
              S.of(context).projectPriority,
              widget.information.projectPriorityName,
              S.of(context).projectClassification,
              widget.information.projectClassificationStr,
              // isColor: true,
            ),
            const SizedBox(height: 16),
            _buildInformationRow(
              context,
              S.of(context).currentProjectPhase,
              widget.information.currentProjectPhaseStr.isEmpty
                  ? "---"
                  : widget.information.currentProjectPhaseStr,
              S.of(context).currentProjectStage,
              widget.information.currentProjectStageStr.isEmpty
                  ? "---"
                  : widget.information.currentProjectStageStr,
            ),
            const SizedBox(height: 16),
            _buildDatesRow(context),
            const SizedBox(height: 16),
            _buildProgressSection(context),
            const SizedBox(height: 16),
            // Container(height: 0.75, color: ColorSchemes.border),
            // const SizedBox(height: 16),
            // ExpandableSection(
            //   title: S.of(context).projectDescription,
            //   value: widget.information.projectDescription.isEmpty
            //       ? "---"
            //       : widget.information.projectDescription,
            //   isExpanded: isDescriptionsExpanded,
            //   onToggle: () {
            //     setState(() {
            //       isDescriptionsExpanded = !isDescriptionsExpanded;
            //     });
            //   },
            // ),
            //
            // const SizedBox(height: 16),
            // Container(height: 0.75, color: ColorSchemes.border),
            // const SizedBox(height: 16),
            // ExpandableSection(
            //   title: S.of(context).assumptions,
            //   value: widget.information.assumption.isEmpty
            //       ? "---"
            //       : widget.information.assumption,
            //   isExpanded: isAssumptionsExpanded,
            //   onToggle: () {
            //     setState(() {
            //       isAssumptionsExpanded = !isAssumptionsExpanded;
            //     });
            //   },
            // ),
            //
            // const SizedBox(height: 16),
            // Container(height: 0.75, color: ColorSchemes.border),
            // const SizedBox(height: 16),
            // ExpandableSection(
            //   title: S.of(context).projectDescriptionWithinScope,
            //   value: widget.information.projectDescriptionWithinScope.isEmpty
            //       ? "---"
            //       : widget.information.projectDescriptionWithinScope,
            //   isExpanded: isDescriptionWithinScopeExpanded,
            //   onToggle: () {
            //     setState(() {
            //       isDescriptionWithinScopeExpanded =
            //           !isDescriptionWithinScopeExpanded;
            //     });
            //   },
            // ),
            //
            // const SizedBox(height: 16),
            // Container(height: 0.75, color: ColorSchemes.border),
            // const SizedBox(height: 16),
            // ExpandableSection(
            //   title: S.of(context).projectDescriptionOutsideScope,
            //   value: widget.information.projectOutOfScope.isEmpty
            //       ? "---"
            //       : widget.information.projectOutOfScope,
            //   isExpanded: isDescriptionOutsideScopeExpanded,
            //   onToggle: () {
            //     setState(() {
            //       isDescriptionOutsideScopeExpanded =
            //           !isDescriptionOutsideScopeExpanded;
            //     });
            //   },
            // ),

            // const SizedBox(height: 16),
            // Container(height: 0.75, color: ColorSchemes.border),
            const SizedBox(height: 16),
            Container(height: 0.75, color: ColorSchemes.border),
            const SizedBox(height: 16),
            _buildInformationRow(
              context,
              S.of(context).validity,
              widget.information.validityColor.label,
              color: widget.information.validityColor.color.toColor(),
              isColor: true,
              S.of(context).latestUpdateDate,
              widget.information.latestUpdateDate.isEmpty
                  ? "---"
                  : formatDate(widget.information.latestUpdateDate),
            ),
            const SizedBox(height: 16),
            ExpandableSection(
              title: S.of(context).latestUpdateBrief,
              value: widget.information.latestUpdateBrief,
              isExpanded: isLatestUpdatesExpanded,
              onEdit: () {
                // Handle edit action if needed
                widget.onSubmit(widget.information);
              },
              onToggle: () {
                setState(() {
                  isLatestUpdatesExpanded = !isLatestUpdatesExpanded;
                });
              },
            ),
            const SizedBox(height: 16),

            // // const SizedBox(height: 16),
            // SizedBox(
            //   height: 200,
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 16),
            //     child: TextFormField(
            //       textAlign: TextAlign.start,
            //       maxLength: 500,
            //       controller: widget.commentController,
            //       minLines: null,
            //       maxLines: 10,
            //       onChanged: (value) {
            //         if (value.isEmpty) {
            //           widget.errorMessage = S.of(context).writeComment;
            //         } else {
            //           widget.errorMessage = null;
            //         }
            //         setState(() {});
            //       },
            //       decoration: InputDecoration(
            //         errorText: widget.errorMessage,
            //         border: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(12),
            //         ),
            //         focusedBorder: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(12),
            //           borderSide: const BorderSide(color: ColorSchemes.primary),
            //         ),
            //         enabledBorder: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(12),
            //           borderSide: const BorderSide(color: ColorSchemes.gray),
            //         ),
            //         hintText: S.of(context).writeComment,
            //         hintStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
            //               fontWeight: Constants.fontWeightRegular,
            //               color: ColorSchemes.black,
            //               letterSpacing: -0.13,
            //             ),
            //       ),
            //     ),
            //   ),
            // ),
            // const SizedBox(height: 32),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16),
            //   child: CustomButtonWidget(
            //     onTap: () {
            //       if (widget.commentController.text.isEmpty) {
            //         widget.errorMessage = S.of(context).writeComment;
            //         setState(() {});
            //       } else {
            //         widget.onSubmit(widget.information);
            //       }
            //     },
            //     text: S.of(context).confirm,
            //     backgroundColor: ColorSchemes.primary,
            //     height: 54,
            //   ),
            // ),

            // const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.information.projectDisplayName,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: ColorSchemes.gray),
                ),
                const SizedBox(height: 4),
                if (widget.information.projectCode.isNotEmpty)
                  Row(
                    children: [
                      Text(
                        GetLanguageUseCase(injector())() == "ar"
                            ? "#${widget.information.projectCode}"
                            : "${widget.information.projectCode}#",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: ColorSchemes.primary),
                      ),
                      if (widget.information.isHasIssues ||
                          widget.information.isHasRisks ||
                          widget.information.isBaseline)
                        const SizedBox(width: 8),
                      if (widget.information.isHasIssues ||
                          widget.information.isHasRisks ||
                          widget.information.isBaseline)
                        Row(
                          children: [
                            if (widget.information.isHasRisks)
                              Image.asset(
                                ImagePaths.p1,
                                width: 32,
                                height: 32,
                                fit: BoxFit.cover,
                              ),
                            if (widget.information.isHasIssues)
                              Image.asset(
                                ImagePaths.p2,
                                width: 32,
                                height: 32,
                                fit: BoxFit.cover,
                              ),
                            if (widget.information.isBaseline)
                              Image.asset(
                                ImagePaths.p3,
                                width: 32,
                                height: 32,
                                fit: BoxFit.cover,
                              ),
                          ],
                        )
                    ],
                  ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          StatusWidget(
            statusColor: widget.information.projectStatusColor.color.toColor(),
            statusMessage: widget.information.projectStatusStr,
          ),
        ],
      ),
    );
  }

  Widget _buildDatesRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildLabeledValue(
              context,
              label: S.of(context).startDate,
              value: formatDate(widget.information.projectStartDate),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildLabeledValue(
              context,
              label: S.of(context).endDate,
              value: formatDate(widget.information.projectEndDate),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInformationRow(BuildContext context, String label1,
      String value1, String label2, String value2,
      {bool isColor = false, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildLabeledValue(
              context,
              label: label1,
              value: value1,
              isColor: isColor,
              color: color,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildLabeledValue(
              context,
              label: label2,
              value: value2,
              // isColor: isColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  S.of(context).plan,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: ColorSchemes.gray,
                        fontSize: 12,
                        fontWeight: Constants.fontWeightSemiBold,
                      ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    "${widget.information.percentPlannedValue.toString()}%",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: ColorSchemes.black,
                          fontSize: 13,
                          fontWeight: Constants.fontWeightSemiBold,
                        ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  S.of(context).actual,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: ColorSchemes.gray,
                        fontSize: 12,
                        fontWeight: Constants.fontWeightSemiBold,
                      ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    "${widget.information.complianceScoreValue}%",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: ColorSchemes.black,
                          fontSize: 13,
                          fontWeight: Constants.fontWeightSemiBold,
                        ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  S.of(context).compliance,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: ColorSchemes.gray,
                        fontSize: 12,
                        fontWeight: Constants.fontWeightSemiBold,
                      ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    "${widget.information.complianceScoreValue.toString()}%",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: ColorSchemes.black,
                          fontSize: 13,
                          fontWeight: Constants.fontWeightSemiBold,
                        ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  S.of(context).progressPercentage,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: ColorSchemes.gray,
                        fontSize: 12,
                        fontWeight: Constants.fontWeightSemiBold,
                      ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color:
                          widget.information.projectPrioColor.color.toColor(),
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabeledValue(
    BuildContext context, {
    required String label,
    required String value,
    bool isColor = false,
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
        if (isColor)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            decoration: BoxDecoration(
              color:
                  color ?? widget.information.projectPrioColor.color.toColor(),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: ColorSchemes.white,
                    fontWeight: Constants.fontWeightSemiBold,
                    fontSize: 14,
                  ),
            ),
          ),
        if (!isColor)
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isColor ? ColorSchemes.primary : ColorSchemes.black,
                  fontWeight: Constants.fontWeightSemiBold,
                ),
          ),
      ],
    );
  }

  Color _getColor(List<Status> kpiValues) {
    Color color = ColorSchemes.gray;
    for (var element in kpiValues) {
      if (element.name == "ProgressKPI") {
        color = element.color;
      }
    }
    return color;
  }
}
