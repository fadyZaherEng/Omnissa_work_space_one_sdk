import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/core/resources/image_paths.dart';
import 'package:mofa/src/core/utils/constants.dart';
import 'package:mofa/src/core/utils/format_date.dart';
import 'package:mofa/src/domain/entities/home/work_flow_history_list.dart';

class TimeLineItemWidget extends StatelessWidget {
  final TimelineItem timeLine;
  final bool isLastItem;

  const TimeLineItemWidget({
    super.key,
    required this.timeLine,
    required this.isLastItem,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildDottedTimeLineWidget(),
              const SizedBox(width: 4),
              _buildTimeLineContentWidget(
                context: context,
                timeLine: timeLine,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDateWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDateItem(
          date: convertTimestampToDateFormat(timeLine.time),
          path: ImagePaths.calendar,
          context: context,
        ),
        // const SizedBox(width: 8),
        // Text(
        //   "/",
        //   style: Theme.of(context)
        //       .textTheme
        //       .bodySmall
        //       ?.copyWith(color: ColorSchemes.gray),
        // ),
        // _buildDateItem(
        //   date: covertDateTimeToLowerCase(timeLine.time),
        //   path: ImagePaths.hourglass,
        //   context: context,
        // ),
      ],
    );
  }

  Widget _buildDateItem({
    required String date,
    required String path,
    required BuildContext context,
  }) {
    return Row(
      children: [
        // SvgPicture.asset(
        //   path,
        //   color: ColorSchemes.gray,
        //   width: 12,
        //   height: 12,
        //   fit: BoxFit.scaleDown,
        //   matchTextDirection: true,
        // ),
        // const SizedBox(width: 4),
        Text(
          date,
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: ColorSchemes.gray),
        )
      ],
    );
  }

  Widget _buildDottedTimeLineWidget() {
    return Column(
      children: [
        SizedBox(
          height: 150,
          width: 30,
          child: Stack(
            children: [
              const Padding(
                padding: EdgeInsetsDirectional.only(start: 4),
                child: DottedLine(
                  dashColor: ColorSchemes.gray,
                  direction: Axis.vertical,
                  dashRadius: 1,
                  dashLength: 8,
                ),
              ),
              PositionedDirectional(
                top: 9,
                start: 0,
                child: Row(
                  children: [
                    Container(
                      width: 9,
                      height: 9,
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: Colors.transparent,
                        border:
                            Border.all(color: ColorSchemes.primary, width: 1),
                      ),
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: ColorSchemes.primary,
                        ),
                      ),
                    ),
                    const DottedLine(
                      dashColor: ColorSchemes.gray,
                      direction: Axis.horizontal,
                      lineLength: 24,
                      dashRadius: 1,
                      dashLength: 8,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (isLastItem) const SizedBox(height: 30),
      ],
    );
  }

  Widget _buildTimeLineContentWidget({
    required BuildContext context,
    required TimelineItem timeLine,
  }) {
    final local = S.of(context);

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 2),

          // Header: icon + department name
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image.network(
              //   timeLine.phaseIcon,
              //   color: ColorSchemes.primary,
              //   width: 24,
              //   height: 24,
              //   fit: BoxFit.scaleDown,
              //   matchTextDirection: true,
              //   loadingBuilder: (context, child, loadingProgress) {
              //     if (loadingProgress == null) return child;
              //     return const SkeletonAvatar(
              //       style: SkeletonAvatarStyle(
              //         shape: BoxShape.circle,
              //         width: 24,
              //         height: 24,
              //       ),
              //     );
              //   },
              //   errorBuilder: (context, error, stackTrace) => SvgPicture.asset(
              //     ImagePaths.error,
              //     color: ColorSchemes.primary,
              //     width: 24,
              //     height: 24,
              //     fit: BoxFit.scaleDown,
              //     matchTextDirection: true,
              //   ),
              // ),
              Container(
                margin: const EdgeInsets.only(left: 8),
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: ColorSchemes.primary,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  timeLine.createdBy.isNotEmpty
                      ? timeLine.createdBy.substring(0, 1).toUpperCase()
                      : timeLine.createdBy,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: ColorSchemes.white,
                        fontWeight: Constants.fontWeightBold,
                      ),
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  timeLine.createdBy,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: ColorSchemes.primary,
                        fontWeight: Constants.fontWeightBold,
                      ),
                ),
              ),
              const SizedBox(width: 8),
              _buildDateWidget(context),
            ],
          ),
          const SizedBox(height: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTimelineText(
                context,
                title: local.stage,
                value: timeLine.oldStatus,
              ),
              const SizedBox(height: 12),
              _buildTimelineText(
                context,
                title: local.projectManager,
                value: timeLine.projectManagerName,
              ),
              const SizedBox(height: 12),
              _buildTimelineText(
                context,
                title: local.executingDepartment,
                value: timeLine.departmentName,
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildTimelineText(
    BuildContext context, {
    required String title,
    required String value,
  }) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "$title:  ",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: ColorSchemes.primary, // Blue title
                  fontWeight: FontWeight.w600,
                ),
          ),
          TextSpan(
            text: value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: ColorSchemes.black, // Black value
                ),
          ),
        ],
      ),
    );
  }
}
