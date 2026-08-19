import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/core/resources/image_paths.dart';
import 'package:mofa/src/core/utils/constants.dart';
import 'package:mofa/src/core/utils/extensions/color_extension.dart';
import 'package:mofa/src/core/utils/format_date.dart';
import 'package:mofa/src/core/utils/show_snack_bar.dart';
import 'package:mofa/src/domain/entities/home/risks.dart';
import 'package:mofa/src/presentation/blocs/risks/risks_bloc.dart';
import 'package:mofa/src/presentation/screens/home/home_screen.dart';
import 'package:mofa/src/presentation/screens/risks/skeleton/risk_details_skeleton.dart';
import 'package:mofa/src/presentation/widgets/bell_notification_widget.dart';
import 'package:mofa/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:mofa/src/presentation/widgets/expandble_scetion.dart';

class RiskDetailsScreen extends StatefulWidget {
  final String id;

  const RiskDetailsScreen({
    super.key,
    required this.id,
  });

  @override
  State<RiskDetailsScreen> createState() => _RiskDetailsScreenState();
}

class _RiskDetailsScreenState extends State<RiskDetailsScreen> {
  late final RisksBloc _bloc;
  Risks risk = const Risks();
  bool isAssumptionsExpanded = false;

  bool isDescriptionWithinScopeExpanded = false;

  bool isDescriptionsExpanded = false;

  bool isDescriptionOutsideScopeExpanded = false;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<RisksBloc>();
    _bloc.add(GetRisksInfoEvent(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarWidget(
        context,
        title: S.of(context).riskDetails,
        isHaveBackButton: true,
        onBackButtonPressed: () => Navigator.of(context).pop(),
        centredTitle: true,
        actionWidget: BellNotificationWidget(
          totalApprovals: totalApprovals,
        ),
      ),
      body: BlocConsumer<RisksBloc, RisksState>(
        bloc: _bloc,
        listener: (context, state) {
          if (state is GetRiskInfoErrorState) {
            showSnackBar(
              context: context,
              message: state.errorMessage,
              color: Colors.red,
              icon: ImagePaths.error,
            );
          } else if (state is GetRiskInfoSuccessState) {
            risk = state.risk;
          }
        },
        builder: (context, state) {
          if (state is GetRiskInfoLoadingState) {
            return const RiskDetailsSkeleton();
          }
          return _buildRiskInfoSection(risk);
        },
      ),
    );
  }

  Widget _buildRiskInfoSection(Risks risk) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Title
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  risk.title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: ColorSchemes.black,
                      ),
                ),
              ),
              const SizedBox(width: 4),
              // Risk Icon
              _buildStatusChip(
                risk.severityColor.label,
                risk.severityColor.color.toColor(),
              ),
              const SizedBox(width: 4),
              // Risk Status
              _buildStatusChip(
                risk.statusColor.label,
                risk.statusColor.color.toColor(),
              ),
              const SizedBox(width: 4),
            ],
          ),
          const SizedBox(height: 24),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Project Info
              Expanded(
                child: _buildReadOnlyField(
                  label: S.of(context).projectName,
                  value: risk.projectName,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildReadOnlyField(
                  label: S.of(context).projectManager,
                  value: risk.projectManagerStr,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildReadOnlyField(
                  label: S.of(context).assignTo,
                  value: risk.assignedTo,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildReadOnlyField(
                  label: S.of(context).owner,
                  value: risk.ownerStr,
                ),
              ),
            ],
          ),

          // Status & Severity
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).impact,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: ColorSchemes.gray,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 4),
                    _buildStatusChip(
                      risk.impactColor.label,
                      risk.impactColor.color.toColor(),
                      isBackground: false,
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
                      S.of(context).riskProbability,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: ColorSchemes.gray,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 4),
                    _buildStatusChip(
                      risk.riskProbabilityColor.label,
                      risk.riskProbabilityColor.color.toColor(),
                      isBackground: false,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category
              Expanded(
                child: _buildReadOnlyField(
                  label: S.of(context).category,
                  value: risk.categoryStr,
                ),
              ),
              const SizedBox(width: 16),
              // Expanded(
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: [
              //       Text(
              //         S.of(context).status,
              //         style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              //               color: ColorSchemes.gray,
              //               fontWeight: FontWeight.w600,
              //             ),
              //       ),
              //       const SizedBox(height: 4),
              //       if (risk.workflowDisplayStatus.color.isEmpty)
              //         Text(
              //           "---",
              //           style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              //                 color: risk.workflowDisplayStatus.color.toColor(),
              //                 fontWeight: FontWeight.bold,
              //               ),
              //         ),
              //       if (risk.workflowDisplayStatus.name.isNotEmpty)
              //         StatusWidget(
              //           statusColor: risk.workflowDisplayStatus.color.toColor(),
              //           statusMessage: risk.workflowDisplayStatus.name,
              //         ),
              //     ],
              //   ),
              // ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildReadOnlyField(
                  label: S.of(context).dueDate,
                  value: formatDate(risk.dueDate),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildReadOnlyField(
                  label: S.of(context).resolvedDate,
                  value: formatDate(risk.resolvedDate),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
          Container(height: 0.75, color: ColorSchemes.border),
          const SizedBox(height: 16),
          ExpandableSection(
            title: S.of(context).description,
            value: risk.description.isEmpty ? "---" : risk.description,
            isPadding: false,
            isExpanded: isDescriptionsExpanded,
            onToggle: () {
              setState(() {
                isDescriptionsExpanded = !isDescriptionsExpanded;
              });
            },
          ),

          const SizedBox(height: 16),
          Container(height: 0.75, color: ColorSchemes.border),
          const SizedBox(height: 16),
          ExpandableSection(
            isPadding: false,
            title: S.of(context).problemFromClient,
            value:
                risk.problemFromClient.isEmpty ? "---" : risk.problemFromClient,
            isExpanded: isAssumptionsExpanded,
            onToggle: () {
              setState(() {
                isAssumptionsExpanded = !isAssumptionsExpanded;
              });
            },
          ),

          const SizedBox(height: 16),
          Container(height: 0.75, color: ColorSchemes.border),
          const SizedBox(height: 16),
          ExpandableSection(
            isPadding: false,
            title: S.of(context).contingencyPlan,
            value: risk.contingencyPlan.isEmpty ? "---" : risk.contingencyPlan,
            isExpanded: isDescriptionWithinScopeExpanded,
            onToggle: () {
              setState(() {
                isDescriptionWithinScopeExpanded =
                    !isDescriptionWithinScopeExpanded;
              });
            },
          ),

          const SizedBox(height: 16),
          Container(height: 0.75, color: ColorSchemes.border),
          const SizedBox(height: 16),
          ExpandableSection(
            isPadding: false,
            title: S.of(context).mitigationPlan,
            value: risk.mitigationPlan.isEmpty ? "---" : risk.mitigationPlan,
            isExpanded: isDescriptionOutsideScopeExpanded,
            onToggle: () {
              setState(() {
                isDescriptionOutsideScopeExpanded =
                    !isDescriptionOutsideScopeExpanded;
              });
            },
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildReadOnlyField({
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: ColorSchemes.gray,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            value.isEmpty ? "---" : value,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: valueColor ?? ColorSchemes.black,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String label, Color statusColor,
      {bool isBackground = true}) {
    if (isBackground) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: statusColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: ColorSchemes.white,
                fontWeight: FontWeight.w500,
              ),
        ),
      );
    } else {
      return Text(
        label.isEmpty ? "---" : label,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: ColorSchemes.black,
              fontWeight: FontWeight.bold,
            ),
      );
    }
  }

  Widget _buildSuggestedSolution(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 0),
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
                    isAssumptionsExpanded = !isAssumptionsExpanded;
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
          if (isAssumptionsExpanded) const SizedBox(height: 4),
          if (isAssumptionsExpanded)
            Text(
              risk.problemFromClient,
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
