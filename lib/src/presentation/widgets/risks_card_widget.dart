import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/core/resources/image_paths.dart';
import 'package:mofa/src/core/utils/constants.dart';
import 'package:mofa/src/core/utils/extensions/color_extension.dart';
import 'package:mofa/src/core/utils/format_date.dart';
import 'package:mofa/src/domain/entities/home/risks.dart';
import 'package:mofa/src/presentation/widgets/build_header_app_card.dart';

class RisksCardWidget extends StatefulWidget {
  final Risks risks;
  final void Function(Risks) onTap;

  const RisksCardWidget({
    super.key,
    required this.risks,
    required this.onTap,
  });

  @override
  State<RisksCardWidget> createState() => _RisksCardWidgetState();
}

class _RisksCardWidgetState extends State<RisksCardWidget> {
  bool isAttachmentExpanded = false;
  bool isDescriptionExpanded = false;
  bool isProblemFromClientExpanded = false;
  bool isMitigationPlanExpanded = false;
  bool isContingencyPlanExpanded = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.onTap(widget.risks),
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
            BuildHeaderAppCard(
              title: widget.risks.title,
              statusColor: widget.risks.statusColor.color.toColor(),
              status: widget.risks.statusColor.label,
              id: "",
              isSevity: true,
              sevityStatusColor: widget.risks.severityColor,
              showStatus: false,
            ),
            const SizedBox(height: 12),
            Container(height: 0.75, color: ColorSchemes.border),

            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).owner,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: ColorSchemes.gray,
                                    fontWeight: Constants.fontWeightSemiBold,
                                  ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.risks.ownerStr.isNotEmpty
                              ? widget.risks.ownerStr
                              : "---",
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: ColorSchemes.black,
                                    fontWeight: Constants.fontWeightSemiBold,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).dueDate,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: ColorSchemes.gray,
                                    fontWeight: Constants.fontWeightSemiBold,
                                  ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.risks.dueDate.isNotEmpty
                              ? formatDate(
                                  widget.risks.dueDate.isNotEmpty
                                      ? widget.risks.dueDate
                                      : DateTime.now().toString(),
                                )
                              : "---",
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: ColorSchemes.black,
                                    fontWeight: Constants.fontWeightSemiBold,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _buildDate(
                    context,
                    label: S.of(context).resolvedDate,
                    value: widget.risks.resolvedDate.isEmpty
                        ? DateTime.now().toString()
                        : widget.risks.resolvedDate,
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).category,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: ColorSchemes.gray,
                              fontWeight: Constants.fontWeightSemiBold,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.risks.categoryStr.isNotEmpty
                            ? widget.risks.categoryStr
                            : "---",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: ColorSchemes.black,
                              fontWeight: Constants.fontWeightSemiBold,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildProgressSection(context),
            const SizedBox(height: 16),
            // Container(height: 0.75, color: ColorSchemes.border),
            // const SizedBox(height: 16),
            // _buildDescription(context),
            // const SizedBox(height: 16),
            // _buildProblemFromClient(context),
            // const SizedBox(height: 16),
            // _buildContingencyPlan(context),
            // const SizedBox(height: 16),
            // _buildMitigationPlan(context),
            // const SizedBox(height: 16),

            // Container(height: 0.75, color: ColorSchemes.border),
            // const SizedBox(height: 16),
            // _buildAttachmentsWidget(context),
            // const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildDate(
    BuildContext context, {
    required String label,
    required String value,
    bool isSpacer = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
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
          SizedBox(height: isSpacer ? 16 : 4),
          Text(
            formatDate(value),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: ColorSchemes.black,
                  fontSize: 13,
                  fontWeight: Constants.fontWeightSemiBold,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).riskStatus,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: ColorSchemes.gray,
                        fontSize: 13,
                        fontWeight: Constants.fontWeightSemiBold,
                      ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: widget.risks.riskProbabilityColor.color.toColor(),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "${widget.risks.riskProbability} %",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: Constants.fontWeightSemiBold,
                        ),
                  ),
                ),
                // ProgressHorizontalIndicatorWidget(
                //   status: Status(
                //     percentage: widget.risks.riskProbability.toDouble(),
                //   ),
                //   isLabelBottom: true,
                // ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).riskEffect,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: ColorSchemes.gray,
                        fontSize: 13,
                        fontWeight: Constants.fontWeightSemiBold,
                      ),
                ),
                const SizedBox(height: 16),
                // ProgressHorizontalIndicatorWidget(
                //   status: widget.risks.riskEffect,
                // ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: widget.risks.impactColor.color.toColor(),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "${widget.risks.impact} %",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: Constants.fontWeightSemiBold,
                        ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Expanded(
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text(
          //         S.of(context).riskStrong,
          //         style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          //               color: ColorSchemes.gray,
          //               fontSize: 13,
          //               fontWeight: Constants.fontWeightSemiBold,
          //             ),
          //       ),
          //       const SizedBox(height: 16),
          //       StatusWidget(
          //         statusColor: widget.risks.statusColor,
          //         statusMessage: widget.risks.statusStr,
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildAttachmentsWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).attachments,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ColorSchemes.primary,
                      fontWeight: Constants.fontWeightSemiBold,
                      fontSize: 15,
                    ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  setState(() {
                    isAttachmentExpanded = !isAttachmentExpanded;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(2),
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorSchemes.secondary,
                  ),
                  child: SvgPicture.asset(
                    ImagePaths.arrowDown,
                    width: 16,
                    height: 16,
                    fit: BoxFit.scaleDown,
                    color: ColorSchemes.black,
                  ),
                ),
              ),
            ],
          ),
          if (isAttachmentExpanded) const SizedBox(height: 4),
          if (isAttachmentExpanded)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                height: 40,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.risks.attachments.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 16),
                  itemBuilder: (context, index) => Row(
                    children: [
                      SvgPicture.asset(
                        widget.risks.attachments[index].isPdf
                            ? ImagePaths.pdf
                            : ImagePaths.xls,
                        width: 20,
                        height: 20,
                        fit: BoxFit.scaleDown,
                        color: ColorSchemes.primary,
                      ),
                      const SizedBox(width: 9),
                      Text(
                        widget.risks.attachments[index].name,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: ColorSchemes.black,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).description,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ColorSchemes.primary,
                      fontWeight: Constants.fontWeightSemiBold,
                      fontSize: 15,
                    ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  setState(() {
                    isDescriptionExpanded = !isDescriptionExpanded;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(2),
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorSchemes.secondary,
                  ),
                  child: SvgPicture.asset(
                    ImagePaths.arrowDown,
                    width: 16,
                    height: 16,
                    fit: BoxFit.scaleDown,
                    color: ColorSchemes.black,
                  ),
                ),
              ),
            ],
          ),
          if (isDescriptionExpanded) const SizedBox(height: 4),
          if (isDescriptionExpanded)
            Text(
              widget.risks.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: ColorSchemes.black,
                  ),
            ),
        ],
      ),
    );
  }

  Widget _buildProblemFromClient(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).problemFromClient,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ColorSchemes.primary,
                      fontWeight: Constants.fontWeightSemiBold,
                      fontSize: 15,
                    ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  setState(() {
                    isProblemFromClientExpanded = !isProblemFromClientExpanded;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(2),
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorSchemes.secondary,
                  ),
                  child: SvgPicture.asset(
                    ImagePaths.arrowDown,
                    width: 16,
                    height: 16,
                    fit: BoxFit.scaleDown,
                    color: ColorSchemes.black,
                  ),
                ),
              ),
            ],
          ),
          if (isProblemFromClientExpanded) const SizedBox(height: 4),
          if (isProblemFromClientExpanded)
            Text(
              widget.risks.problemFromClient,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: ColorSchemes.black,
                  ),
            ),
        ],
      ),
    );
  }

  Widget _buildContingencyPlan(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).contingencyPlan,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ColorSchemes.primary,
                      fontWeight: Constants.fontWeightSemiBold,
                      fontSize: 15,
                    ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  setState(() {
                    isContingencyPlanExpanded = !isContingencyPlanExpanded;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(2),
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorSchemes.secondary,
                  ),
                  child: SvgPicture.asset(
                    ImagePaths.arrowDown,
                    width: 16,
                    height: 16,
                    fit: BoxFit.scaleDown,
                    color: ColorSchemes.black,
                  ),
                ),
              ),
            ],
          ),
          if (isContingencyPlanExpanded) const SizedBox(height: 4),
          if (isContingencyPlanExpanded)
            Text(
              widget.risks.contingencyPlan,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: ColorSchemes.black,
                  ),
            ),
        ],
      ),
    );
  }

  Widget _buildMitigationPlan(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).mitigationPlan,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ColorSchemes.primary,
                      fontWeight: Constants.fontWeightSemiBold,
                      fontSize: 15,
                    ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  setState(() {
                    isMitigationPlanExpanded = !isMitigationPlanExpanded;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(2),
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorSchemes.secondary,
                  ),
                  child: SvgPicture.asset(
                    ImagePaths.arrowDown,
                    width: 16,
                    height: 16,
                    fit: BoxFit.scaleDown,
                    color: ColorSchemes.black,
                  ),
                ),
              ),
            ],
          ),
          if (isMitigationPlanExpanded) const SizedBox(height: 4),
          if (isMitigationPlanExpanded)
            Text(
              widget.risks.mitigationPlan,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: ColorSchemes.black,
                  ),
            ),
        ],
      ),
    );
  }
}
