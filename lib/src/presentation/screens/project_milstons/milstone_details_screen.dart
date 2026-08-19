import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/core/base/widget/base_stateful_widget.dart';
import 'package:mofa/src/core/resources/image_paths.dart';
import 'package:mofa/src/core/utils/constants.dart';
import 'package:mofa/src/core/utils/extensions/color_extension.dart';
import 'package:mofa/src/core/utils/format_date.dart';
import 'package:mofa/src/core/utils/show_comment_bottom_sheet.dart';
import 'package:mofa/src/core/utils/show_massage_dialog_widget.dart';
import 'package:mofa/src/data/sources/remote/mofa/more/entity/remore_milstone_details.dart';
import 'package:mofa/src/data/sources/remote/mofa/more/request/request_update_milstone.dart';
import 'package:mofa/src/data/sources/remote/mofa/projects/entity/remote_milstone.dart';
import 'package:mofa/src/domain/entities/home/milstones.dart';
import 'package:mofa/src/presentation/blocs/milstones/milstones_bloc.dart';
import 'package:mofa/src/presentation/screens/home/home_screen.dart';
import 'package:mofa/src/presentation/screens/pointers_tool/skeleton/pointer_skeleton.dart';
import 'package:mofa/src/presentation/widgets/bell_notification_widget.dart';
import 'package:mofa/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:mofa/src/presentation/widgets/build_header_app_card.dart';
import 'package:mofa/src/presentation/widgets/expandble_scetion.dart';
import 'package:mofa/src/presentation/widgets/landmark_card_widget.dart';

class MilstoneDetailsScreen extends BaseStatefulWidget {
  final bool isShowBackButton;
  final Milstones milstones;

  const MilstoneDetailsScreen({
    super.key,
    this.isShowBackButton = false,
    required this.milstones,
  });

  @override
  BaseState<MilstoneDetailsScreen> baseCreateState() =>
      _MilstoneDetailsScreenState();
}

class _MilstoneDetailsScreenState extends BaseState<MilstoneDetailsScreen> {
  MilstonesBloc get _bloc => BlocProvider.of<MilstonesBloc>(context);
  RemoteMilstoneDetails milstone = const RemoteMilstoneDetails();
  bool isNoteExpanded = false;
  String _sortColumnDirection = "desc";
  String _columnDirection = "descending";

  @override
  void initState() {
    super.initState();
    _bloc.add(GetMilstoneInfoEvent(
      id: widget.milstones.id,
      pageSize: 1,
      skip: 0,
      sortColumnDirection: _sortColumnDirection,
      columnDirection: _columnDirection,
    ));
  }

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<MilstonesBloc, MilstonesState>(
      listener: (context, state) {
        if (state is GetMilstonesErrorState) {
          _showMessageDialog(
            message: state.errorMessage,
            icon: ImagePaths.error,
          );
        } else if (state is GetMilstoneInfoSuccessState) {
          milstone = state.milstone;
        } else if (state is UpdateMilstoneLoadingState) {
          showLoading();
        } else if (state is UpdateMilstoneSuccessState) {
          _showMessageDialog(
            message: S.of(context).updateMilstoneSuccessfully,
            icon: ImagePaths.success,
          );
          _bloc.add(GetMilstoneInfoEvent(
            id: milstone.id ?? "",
            pageSize: 1,
            skip: 0,
            sortColumnDirection: _sortColumnDirection,
            columnDirection: _columnDirection,
          ));
          hideLoading();
        } else if (state is UpdateMilstoneErrorState) {
          _showMessageDialog(
            message: state.massage,
            icon: ImagePaths.error,
          );
          hideLoading();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: buildAppBarWidget(
            context,
            title: S.of(context).milstoneDetails,
            isHaveBackButton: widget.isShowBackButton,
            centredTitle: !widget.isShowBackButton,
            onBackButtonPressed: () => Navigator.pop(context),
            actionWidget: BellNotificationWidget(
              totalApprovals: totalApprovals,
            ),
          ),
          body: state is GetMilstoneInfoLoadingState
              ? const PointersSkeleton()
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        BuildHeaderAppCard(
                          title: milstone.name ?? "",
                          statusColor: widget
                              .milstones.projectCardStatusStr.color
                              .toColor(),
                          status: widget.milstones.projectCardStatusStr.label,
                          id: "",
                          showStatus: true,
                        ),
                        const SizedBox(height: 12),
                        Container(height: 0.75, color: ColorSchemes.border),
                        const SizedBox(height: 16),
                        _buildProjectRow(context),
                        const SizedBox(height: 16),
                        _buildDatesRow(context),
                        const SizedBox(height: 16),
                        _buildDatesLineBasicsRow(context),
                        const SizedBox(height: 16),
                        _buildNumberOfDaysRow(context),
                        const SizedBox(height: 16),
                        Container(height: 0.75, color: ColorSchemes.border),
                        const SizedBox(height: 16),
                        ExpandableSection(
                          title: S.of(context).notes,
                          value: milstone.note == null || milstone.note.isEmpty
                              ? "---"
                              : milstone.note ?? "",
                          isExpanded: isNoteExpanded,
                          onEdit: () {
                            _showCommentBottomSheet(
                              context: context,
                              milstone: milstone,
                            );
                          },
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
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: ColorSchemes.gray,
                                      fontSize: 13,
                                      fontWeight: Constants.fontWeightSemiBold,
                                    ),
                              ),
                              if (milstone.assignments?.isEmpty ?? false)
                                const SizedBox(height: 8),
                              if (milstone.assignments?.isEmpty ?? false)
                                Text(
                                  "---",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: ColorSchemes.black,
                                        fontSize: 14,
                                        fontWeight:
                                            Constants.fontWeightSemiBold,
                                      ),
                                ),
                            ],
                          ),
                        ),
                        if (milstone.assignments?.isNotEmpty ?? false)
                          AssignmentsStrip(
                              assignments: milstone.assignments
                                      ?.map((e) => e.mapToDomain())
                                      .toList() ??
                                  []),
                        if (milstone.assignments?.isNotEmpty ?? false)
                          const SizedBox(height: 16),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }

  void _showCommentBottomSheet({
    required BuildContext context,
    required RemoteMilstoneDetails milstone,
  }) {
    showCommentBottomSheet(
      context: context,
      onSend: (comment) async {
        Navigator.pop(context);
        if (comment.isEmpty) {
          setState(() {});
        } else {
          _bloc.add(
            UpdateMilstoneEvent(
              requestUpdateMilstone: RequestUpdateMilstone(
                id: milstone.id ?? "",
                note: comment,
              ),
            ),
          );
        }
        setState(() {});
      },
    );
  }

  Widget _buildProjectRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildLabeledValue(
              context,
              label: S.of(context).projectName,
              value: milstone.project?.projectName ?? "",
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildLabeledValue(
              context,
              label: S.of(context).projectManager,
              value: milstone.project?.projectManagerStr ?? "",
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
              label: S.of(context).taskStartDate,
              value: formatDate(milstone.startDate?.isEmpty == true
                  ? DateTime.now().toString()
                  : milstone.startDate ?? ""),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildLabeledValue(
              context,
              label: S.of(context).taskEndDate,
              value: formatDate(
                milstone.endDate?.isEmpty == true
                    ? DateTime.now().toString()
                    : milstone.endDate.toString() ?? "",
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
              label: S.of(context).endDateBasicsLine,
              value: formatDate(milstone.baselineStartDate?.isEmpty == true
                  ? DateTime.now().toString()
                  : milstone.baselineStartDate.toString() ?? ""),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildLabeledValue(
              context,
              label: S.of(context).endDateBasicsLine,
              value: formatDate(
                milstone.baselineEndDate?.isEmpty == true
                    ? DateTime.now().toString()
                    : milstone.baselineEndDate.toString() ?? "",
              ),
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
          Expanded(
            child: _buildLabeledValue(
              context,
              label: S.of(context).weight,
              value: "${milstone.weight} ${S.of(context).weight}",
            ),
          ),
          const SizedBox(width: 16),
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

  void _showMessageDialog({
    required String message,
    required String icon,
  }) {
    showMassageDialogWidget(
        context: context,
        text: message,
        icon: icon,
        buttonText: S.of(context).ok,
        onTap: () {
          Navigator.pop(context);
          Navigator.pop(context);
        });
  }
}
