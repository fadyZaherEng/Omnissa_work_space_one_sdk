import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/core/base/widget/base_stateful_widget.dart';
import 'package:mofa/src/core/resources/image_paths.dart';
import 'package:mofa/src/core/utils/constants.dart';
import 'package:mofa/src/core/utils/extensions/color_extension.dart';
import 'package:mofa/src/core/utils/format_date.dart';
import 'package:mofa/src/core/utils/show_snack_bar.dart';
import 'package:mofa/src/domain/entities/home/deliverables.dart';
import 'package:mofa/src/presentation/blocs/deliverables/delivrables_bloc.dart';
import 'package:mofa/src/presentation/blocs/deliverables/delivrables_event.dart';
import 'package:mofa/src/presentation/blocs/deliverables/delivrables_state.dart';
import 'package:mofa/src/presentation/screens/home/home_screen.dart';
import 'package:mofa/src/presentation/screens/pointers_tool/skeleton/pointer_skeleton.dart';
import 'package:mofa/src/presentation/widgets/bell_notification_widget.dart';
import 'package:mofa/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:mofa/src/presentation/widgets/build_header_app_card.dart';
import 'package:mofa/src/presentation/widgets/expandble_scetion.dart';

class DeliveryDetailsScreen extends BaseStatefulWidget {
  final bool isShowBackButton;
  final String deliverableId;

  const DeliveryDetailsScreen({
    super.key,
    this.isShowBackButton = false,
    required this.deliverableId,
  });

  @override
  BaseState<DeliveryDetailsScreen> baseCreateState() =>
      _DeliveryDetailsScreenState();
}

class _DeliveryDetailsScreenState extends BaseState<DeliveryDetailsScreen> {
  final Deliverbles _deliverables = const Deliverbles();

  DelivrablesBloc get _bloc => BlocProvider.of<DelivrablesBloc>(context);
  Deliverbles _deliverbles = const Deliverbles();
  bool isDescriptionOutsideScopeExpanded = false;
  bool isLatestUpdatesExpanded = false;

  @override
  void initState() {
    _bloc.add(GetDeliverableInfoEvent(id: widget.deliverableId));
    super.initState();
  }

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<DelivrablesBloc, DelivrablesState>(
      listener: (context, state) {
        if (state is GetDeliverableInfoSuccessState) {
          _deliverbles = state.deliverable;
        } else if (state is GetDeliverableInfoErrorState) {
          showSnackBar(
            context: context,
            message: state.errorMessage,
            color: ColorSchemes.red,
            icon: ImagePaths.error,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: buildAppBarWidget(
            context,
            title: S.of(context).deliveryDetails,
            isHaveBackButton: true,
            centredTitle: true,
            onBackButtonPressed: () => Navigator.pop(context),
            actionWidget: BellNotificationWidget(
              totalApprovals: totalApprovals,
            ),
          ),
          body: state is GetDeliverableInfoLoadingState
              ? const PointersSkeleton()
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      BuildHeaderAppCard(
                        title: _deliverbles.deliverableName,
                        statusColor:
                            _deliverbles.deliverableStatusColor.color.toColor(),
                        status: _deliverbles.deliverableStatusColor.label,
                        id: "",
                      ),
                      const SizedBox(height: 24),
                      // Container(height: 0.75, color: ColorSchemes.border),
                      // const SizedBox(height: 12),
                      _buildUserAndDepartment(context),
                      const SizedBox(height: 16),
                      _buildProjectRow(context),
                      const SizedBox(height: 16),
                      _buildDatesRow(context),
                      const SizedBox(height: 16),
                      _buildDatesLineBasicsRow(context),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              S.of(context).completionPercentage,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: ColorSchemes.gray,
                                    fontSize: 13,
                                    fontWeight: Constants.fontWeightSemiBold,
                                  ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "${_deliverbles.completionPercentage}%",
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
                          ],
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(height: 16),
                              Container(
                                  height: 0.75, color: ColorSchemes.border),
                              const SizedBox(height: 16),
                              ExpandableSection(
                                isPadding: false,
                                title: S
                                    .of(context)
                                    .projectDescriptionOutsideScope,
                                value: _deliverbles.description.isEmpty
                                    ? "---"
                                    : _deliverbles.description,
                                isExpanded: isDescriptionOutsideScopeExpanded,
                                onToggle: () {
                                  setState(() {
                                    isDescriptionOutsideScopeExpanded =
                                        !isDescriptionOutsideScopeExpanded;
                                  });
                                },
                              ),
                              const SizedBox(height: 16),
                              Container(
                                  height: 0.75, color: ColorSchemes.border),
                              const SizedBox(height: 16),
                              ExpandableSection(
                                isPadding: false,
                                title: S.of(context).latestUpdateBrief,
                                value:
                                    _deliverbles.specificationsStandards.isEmpty
                                        ? "---"
                                        : _deliverbles.specificationsStandards,
                                isExpanded: isLatestUpdatesExpanded,
                                onToggle: () {
                                  setState(() {
                                    isLatestUpdatesExpanded =
                                        !isLatestUpdatesExpanded;
                                  });
                                },
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
        );
      },
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
              value: formatDate(_deliverables.baselineStartDate.isEmpty
                  ? DateTime.now().toString()
                  : _deliverables.baselineStartDate),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildLabeledValue(
              context,
              label: S.of(context).endDateBasicsLine,
              value: formatDate(_deliverables.baselineEndDate.isEmpty
                  ? DateTime.now().toString()
                  : _deliverables.baselineEndDate),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserAndDepartment(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // _buildAvatar(context, _deliverables.deliverableName),
                // const SizedBox(width: 8),

                Text(
                  S.of(context).projectName,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: ColorSchemes.gray,
                        fontWeight: Constants.fontWeightSemiBold,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  _deliverbles.projectName,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  S.of(context).projectManager,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: ColorSchemes.gray,
                        fontWeight: Constants.fontWeightSemiBold,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  _deliverbles.projectManagerStr,
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
              label: S.of(context).deliveryStartDate,
              value: formatDate(
                _deliverbles.projectStartDate.isEmpty
                    ? DateTime.now().toString()
                    : _deliverbles.projectStartDate,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildLabeledValue(
              context,
              label: S.of(context).deliveryEndDate,
              value: formatDate(
                _deliverbles.projectEndDate.isEmpty
                    ? DateTime.now().toString()
                    : _deliverbles.projectEndDate,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          // Expanded(
          //   child: _buildLabeledValue(
          //     context,
          //     label: S.of(context).projectName,
          //     value: _deliverbles.projectName,
          //   ),
          // ),
          Expanded(
            child: _buildLabeledValue(
              context,
              label: S.of(context).weight,
              value: "${_deliverbles.weight} ${S.of(context).weight}",
            ),
          ),
          // const SizedBox(width: 16),
          // Expanded(
          //   child: _buildLabeledValue(
          //     context,
          //     label: S.of(context).projectStatus,
          //     value: _deliverbles.deliverableStatusColor.label,
          //     color: ColorSchemes.yellow,
          //   ),
          // ),
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
}
