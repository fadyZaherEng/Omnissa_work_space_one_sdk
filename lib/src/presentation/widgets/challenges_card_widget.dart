import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/core/resources/image_paths.dart';
import 'package:mofa/src/core/utils/constants.dart';
import 'package:mofa/src/core/utils/extensions/color_extension.dart';
import 'package:mofa/src/core/utils/format_date.dart';
import 'package:mofa/src/domain/entities/home/challenges.dart';
import 'package:mofa/src/presentation/widgets/build_header_app_card.dart';
import 'package:mofa/src/presentation/widgets/build_user_and_department_card_widget.dart';
import 'package:mofa/src/presentation/widgets/progress_horizantal_indicator_widget.dart';

class ChallengesCardWidget extends StatefulWidget {
  final Challenges challenge;
  final void Function(Challenges) onTap;

  const ChallengesCardWidget({
    super.key,
    required this.challenge,
    required this.onTap,
  });

  @override
  State<ChallengesCardWidget> createState() => _ChallengesCardWidgetState();
}

class _ChallengesCardWidgetState extends State<ChallengesCardWidget> {
  bool isAttachmentExpanded = false;
  bool isDescriptionExpanded = false;
  bool isSuggestionsExpanded = false;
  bool isProblemsExpanded = false;
  bool isChallengesExpanded = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.onTap(widget.challenge),
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
              title: widget.challenge.title,
              statusColor: widget.challenge.statusColor.color.toColor(),
              status: widget.challenge.statusColor.label,
              id: "",
              isPriority: true,
              priorityStatusColor: widget.challenge.issuePrioColor,
              showStatus: false,
            ),
            const SizedBox(height: 12),
            Container(height: 0.75, color: ColorSchemes.border),
            const SizedBox(height: 12),
            BuildUserAndDepartmentCardWidget(
              name: widget.challenge.ownerStr,
              label: S.of(context).assignTo,
              value: widget.challenge.assignedTo,
              isChallenge: true,
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: _buildLabeledValue(
                      context,
                      label: S.of(context).category,
                      value: widget.challenge.categoryStr.isNotEmpty
                          ? widget.challenge.categoryStr
                          : "---",
                    ),
                  ),
                  const SizedBox(width: 32),
                  Expanded(
                    child: _buildLabeledValue(
                      context,
                      label: S.of(context).priority,
                      value: widget.challenge.priorityStr.isNotEmpty
                          ? widget.challenge.priorityStr
                          : "---",
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            _buildStatusRow(context),
            const SizedBox(height: 16),

            // _buildDatesRow(context),
            // const SizedBox(height: 16),
            // Container(height: 0.75, color: ColorSchemes.border),
            // const SizedBox(height: 16),
            // _buildDescription(context),
            // const SizedBox(height: 16),
            // Container(height: 0.75, color: ColorSchemes.border),
            // const SizedBox(height: 16),
            // _buildSuggestedSolution(context),
            // const SizedBox(height: 16),
            // Container(height: 0.75, color: ColorSchemes.border),
            // const SizedBox(height: 16),
            // _buildProblemReason(context),
            // const SizedBox(height: 16),
            // Container(height: 0.75, color: ColorSchemes.border),
            // const SizedBox(height: 16),
            // _buildProblemChallenge(context),
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

  Widget _buildDatesRow(BuildContext context) {
    print("Due Date: ${widget.challenge.dueDate}");
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildLabeledValue(
              context,
              label: S.of(context).solveDate,
              value: formatDate(
                widget.challenge.dueDate.isNotEmpty
                    ? widget.challenge.dueDate
                    : DateTime.now().toString(),
              ),
            ),
          ),
          const SizedBox(width: 32),
          Expanded(
            child: _buildLabeledValue(
              context,
              label: S.of(context).dueDate,
              value: formatDate(
                widget.challenge.dueDate.isNotEmpty
                    ? widget.challenge.dueDate
                    : DateTime.now().toString(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          // Expanded(
          //   child: _buildProgressSection(context),
          // ),
          Expanded(
            child: _buildLabeledValue(
              context,
              label: S.of(context).resolvedDate,
              value: widget.challenge.resolvedDate.isNotEmpty
                  ? formatDate(
                      widget.challenge.resolvedDate.isNotEmpty
                          ? widget.challenge.resolvedDate
                          : DateTime.now().toString(),
                    )
                  : "---",
            ),
          ),
          const SizedBox(width: 32),
          Expanded(
            child: _buildLabeledValue(
              context,
              label: S.of(context).dueDate,
              value: widget.challenge.dueDate.isNotEmpty
                  ? formatDate(
                      widget.challenge.dueDate.isNotEmpty
                          ? widget.challenge.dueDate
                          : DateTime.now().toString(),
                    )
                  : "---",
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).challengeRisk,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: ColorSchemes.gray,
                fontSize: 13,
                fontWeight: Constants.fontWeightSemiBold,
              ),
        ),
        const SizedBox(height: 8),
        ProgressHorizontalIndicatorWidget(
          status: widget.challenge.challengeRisk,
          isLabelBottom: true,
          width: 120,
        ),
      ],
    );
  }

  Widget _buildLabeledValue(
    BuildContext context, {
    required String label,
    required String value,
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
                color: ColorSchemes.black,
                fontWeight: Constants.fontWeightSemiBold,
              ),
        ),
      ],
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
                  itemCount: widget.challenge.attachments.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 16),
                  itemBuilder: (context, index) => Row(
                    children: [
                      SvgPicture.asset(
                        widget.challenge.attachments[index].isPdf
                            ? ImagePaths.pdf
                            : ImagePaths.xls,
                        width: 20,
                        height: 20,
                        fit: BoxFit.scaleDown,
                        color: ColorSchemes.primary,
                      ),
                      const SizedBox(width: 9),
                      Text(
                        widget.challenge.attachments[index].name,
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
              widget.challenge.description,
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

  Widget _buildSuggestedSolution(BuildContext context) {
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
                S.of(context).suggestSolution,
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
                    isSuggestionsExpanded = !isSuggestionsExpanded;
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
          if (isSuggestionsExpanded) const SizedBox(height: 4),
          if (isSuggestionsExpanded)
            Text(
              widget.challenge.discussion,
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

  Widget _buildProblemReason(BuildContext context) {
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
                S.of(context).problemReasons,
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
                    isProblemsExpanded = !isProblemsExpanded;
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
          if (isProblemsExpanded) const SizedBox(height: 4),
          if (isProblemsExpanded)
            Text(
              widget.challenge.resolution,
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

  Widget _buildProblemChallenge(BuildContext context) {
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
                S.of(context).problemChallenge,
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
                    isChallengesExpanded = !isChallengesExpanded;
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
          if (isChallengesExpanded) const SizedBox(height: 4),
          if (isChallengesExpanded)
            Text(
              widget.challenge.problemChallenge,
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
