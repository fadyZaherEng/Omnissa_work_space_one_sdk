import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/core/utils/constants.dart';
import 'package:mofa/src/core/utils/extensions/color_extension.dart';
import 'package:mofa/src/core/utils/format_date.dart';
import 'package:mofa/src/domain/entities/home/land_mark.dart';
import 'package:mofa/src/domain/entities/shared/status.dart';
import 'package:mofa/src/presentation/widgets/build_header_app_card.dart';
import 'package:mofa/src/presentation/widgets/expandble_scetion.dart';
import 'package:mofa/src/presentation/widgets/progress_horizantal_indicator_widget.dart';

class LandmarkCardWidget extends StatefulWidget {
  final Landmark landmark;
  final void Function(Landmark) onTap;

  const LandmarkCardWidget({
    super.key,
    required this.landmark,
    required this.onTap,
  });

  @override
  State<LandmarkCardWidget> createState() => _LandmarkCardWidgetState();
}

class _LandmarkCardWidgetState extends State<LandmarkCardWidget> {
  bool isNoteExpanded = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.onTap(widget.landmark),
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
              title: widget.landmark.name,
              statusColor: widget.landmark.projectStatusColor.color.toColor(),
              status: widget.landmark.projectStatusColor.label,
              id: "",
            ),
            const SizedBox(height: 12),
            Container(height: 0.75, color: ColorSchemes.border),
            const SizedBox(height: 12),
            _buildUserAndDepartment(context),
            // const SizedBox(height: 16),
            // _buildAddressRow(context),
            const SizedBox(height: 16),
            _buildDatesRow(context),
            const SizedBox(height: 16),
            _buildDatesLineBasicsRow(context),
            const SizedBox(height: 16),
            _buildNumberOfDaysRow(context),
            const SizedBox(height: 16),
            // Container(height: 0.75, color: ColorSchemes.border),
            // const SizedBox(height: 16),
            ExpandableSection(
              title: S.of(context).notes,
              value:
                  widget.landmark.note == null || widget.landmark.note.isEmpty
                      ? "---"
                      : widget.landmark.note ?? "",
              isExpanded: isNoteExpanded,
              onEdit: null,
              onToggle: () {
                setState(() {
                  isNoteExpanded = !isNoteExpanded;
                });
              },
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).assignments,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: ColorSchemes.gray,
                          fontSize: 13,
                          fontWeight: Constants.fontWeightSemiBold,
                        ),
                  ),
                  if (widget.landmark.assignments.isEmpty ?? false)
                    const SizedBox(height: 8),
                  if (widget.landmark.assignments.isEmpty ?? false)
                    Text(
                      "---",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: ColorSchemes.black,
                            fontSize: 14,
                            fontWeight: Constants.fontWeightSemiBold,
                          ),
                    ),
                ],
              ),
            ),
            if (widget.landmark.assignments.isNotEmpty ?? false)
              AssignmentsStrip(assignments: widget.landmark.assignments),
            if (widget.landmark.assignments.isNotEmpty ?? false)
              const SizedBox(height: 16),

            // if (landmark.assignments.isNotEmpty)
            //   Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 16),
            //     child: Text(
            //       S.of(context).assignments,
            //       style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            //             color: ColorSchemes.gray,
            //             fontSize: 13,
            //             fontWeight: Constants.fontWeightSemiBold,
            //           ),
            //     ),
            //   ),
            // if (landmark.assignments.isNotEmpty)
            //   AssignmentsStrip(assignments: landmark.assignments),
            // if (landmark.assignments.isNotEmpty) const SizedBox(height: 16),
            const SizedBox(height: 16),
            _buildProgressSection(context),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildUserAndDepartment(BuildContext context) {
    if (widget.landmark.assignments.isEmpty) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _buildAvatar(context, widget.landmark.assignments.first.resourceName),
          const SizedBox(width: 8),
          Text(
            widget.landmark.assignments.first.resourceName,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: ColorSchemes.black,
                  fontWeight: Constants.fontWeightSemiBold,
                ),
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
              value: formatDate(
                widget.landmark.startDate.isNotEmpty
                    ? widget.landmark.startDate
                    : DateTime.now().toString(),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildLabeledValue(
              context,
              label: S.of(context).endDate,
              value: formatDate(
                widget.landmark.endDate.isNotEmpty
                    ? widget.landmark.endDate
                    : DateTime.now().toString(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDatesLineBasicsRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildLabeledValue(
              context,
              label: S.of(context).startDateBasicsLine,
              value: formatDate(
                widget.landmark.startDateBasicsLine.isNotEmpty
                    ? widget.landmark.startDateBasicsLine
                    : DateTime.now().toString(),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildLabeledValue(
              context,
              label: S.of(context).endDateBasicsLine,
              value: formatDate(
                widget.landmark.endDateBasicsLine.isNotEmpty
                    ? widget.landmark.endDateBasicsLine
                    : DateTime.now().toString(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildLabeledValue(
              context,
              label: S.of(context).address,
              value: widget.landmark.address,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildLabeledValue(
              context,
              label: S.of(context).implementationState,
              value: widget.landmark.implementationState,
              color: widget.landmark.statusColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNumberOfDaysRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          // if (widget.landmark.assignments.isEmpty)
          //   Expanded(
          //     child: _buildLabeledValue(
          //       context,
          //       label: S.of(context).assignments,
          //       value: "---",
          //     ),
          //   ),
          // if (widget.landmark.assignments.isEmpty) const SizedBox(width: 16),
          Expanded(
            child: _buildLabeledValue(
              context,
              label: S.of(context).weight,
              value: "${widget.landmark.weight}",
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).achievements,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: ColorSchemes.gray,
                  fontSize: 13,
                  fontWeight: Constants.fontWeightSemiBold,
                ),
          ),
          const SizedBox(height: 8),
          ProgressHorizontalIndicatorWidget(
            status: Status(
              percentage: widget.landmark.percentDone.toDouble(),
              color: Colors.green,
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

  Widget _buildAvatar(BuildContext context, String fullName) {
    final initials = fullName
        .trim()
        .split(' ')
        .where((e) => e.isNotEmpty)
        .map((e) => e.characters.first)
        .take(2)
        .join(' ');

    return Container(
      width: 32,
      height: 32,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: ColorSchemes.primary,
      ),
      child: Center(
        child: Text(
          initials,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: ColorSchemes.white,
                fontSize: 13,
                fontWeight: Constants.fontWeightSemiBold,
              ),
        ),
      ),
    );
  }
}

class AssignmentsStrip extends StatelessWidget {
  final List<Assignments> assignments;

  const AssignmentsStrip({super.key, required this.assignments});

  @override
  Widget build(BuildContext context) {
    final hist = assignments.expand((a) => a.assignmentHistory).toList();
    String? start, end;
    if (hist.isNotEmpty) {
      hist.sort((a, b) => _parseDate(a.date).compareTo(_parseDate(b.date)));
      start = _fmt(_parseDate(hist.first.date));
      end = _fmt(_parseDate(hist.last.date));
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Wrap(
        // crossAxisAlignment: CrossAxisAlignment.center,
        alignment: WrapAlignment.start,
        spacing: 0,
        runSpacing: 0,
        crossAxisAlignment: WrapCrossAlignment.start,
        direction: Axis.horizontal,
        runAlignment: WrapAlignment.start,

        children: [
          // left: resources chips (vertical like the screenshot)
          Wrap(
            spacing: 4,
            runSpacing: 4,
            crossAxisAlignment: WrapCrossAlignment.start,
            direction: Axis.horizontal,
            runAlignment: WrapAlignment.start,
            children: assignments.map((a) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 0),
                child: Chip(
                  backgroundColor: Colors.teal,
                  label: Text(
                    '${a.resourceName} (${a.units}%)',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              );
            }).toList(),
          ),

          // const SizedBox(width: 16),

          // center: a thin separator to mimic the bar area (no progress)
          // Expanded(
          //   child: Container(
          //     height: 12,
          //     decoration: BoxDecoration(
          //       color: Colors.grey.shade200,
          //       borderRadius: BorderRadius.circular(6),
          //     ),
          //   ),
          // ),

          // const SizedBox(width: 16),

          // right: start/end dates if available
          if (start != null && end != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(start,
                    style:
                        TextStyle(color: Colors.grey.shade700, fontSize: 12)),
                const SizedBox(height: 8),
                Text(end,
                    style:
                        TextStyle(color: Colors.grey.shade700, fontSize: 12)),
              ],
            ),
        ],
      ),
    );
  }

  static DateTime _parseDate(String raw) {
    // يدعم ISO مثل "2025-01-31" أو millis مثل "1756130427000"
    final asInt = int.tryParse(raw);
    if (asInt != null && raw.length >= 12) {
      return DateTime.fromMillisecondsSinceEpoch(asInt, isUtc: false);
    }
    return DateTime.tryParse(raw) ?? DateTime.fromMillisecondsSinceEpoch(0);
  }

  static String _fmt(DateTime d) => DateFormat('yyyy-MM-dd').format(d);
}
