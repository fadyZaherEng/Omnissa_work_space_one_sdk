import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/core/resources/image_paths.dart';
import 'package:mofa/src/core/utils/extensions/color_extension.dart';
import 'package:mofa/src/core/utils/format_date.dart';
import 'package:mofa/src/core/utils/show_snack_bar.dart';
import 'package:mofa/src/domain/entities/home/challenges.dart';
import 'package:mofa/src/presentation/blocs/challenges/challenges_bloc.dart';
import 'package:mofa/src/presentation/screens/challenges/skeleton/challenge_details_skeleton.dart';
import 'package:mofa/src/presentation/screens/home/home_screen.dart';
import 'package:mofa/src/presentation/widgets/bell_notification_widget.dart';
import 'package:mofa/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:mofa/src/presentation/widgets/expandble_scetion.dart';
import 'package:mofa/src/presentation/widgets/status_widget.dart';

class ChallengeDetailsScreen extends StatefulWidget {
  final String id;

  const ChallengeDetailsScreen({
    super.key,
    required this.id,
  });

  @override
  State<ChallengeDetailsScreen> createState() => _ChallengeDetailsScreenState();
}

class _ChallengeDetailsScreenState extends State<ChallengeDetailsScreen> {
  ChallengesBloc get _bloc => BlocProvider.of<ChallengesBloc>(context);

  // Expanded states for each multiline field
  final Map<String, bool> _expanded = {
    "description": false,
    "discussion": false,
    "resolution": false,
    "problemFromClient": false,
  };
  Challenges _challenge = const Challenges();
  bool isAssumptionsExpanded = false;

  bool isDescriptionWithinScopeExpanded = false;

  bool isDescriptionsExpanded = false;

  bool isDescriptionOutsideScopeExpanded = false;

  @override
  void initState() {
    _bloc.add(GetChallengesInfoEvent(id: widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarWidget(
        context,
        title: S.of(context).challengeDetails,
        isHaveBackButton: true,
        onBackButtonPressed: () => Navigator.of(context).pop(),
        centredTitle: true,
        actionWidget: BellNotificationWidget(
          totalApprovals: totalApprovals,
        ),
      ),
      body: BlocConsumer<ChallengesBloc, ChallengesState>(
        listener: (context, state) {
          if (state is GetChallengesInfoErrorState) {
            showSnackBar(
              context: context,
              message: state.message,
              color: ColorSchemes.redError,
              icon: ImagePaths.error,
            );
          } else if (state is GetChallengesInfoSuccessState) {
            _challenge = state.challenge;
          }
        },
        builder: (context, state) {
          if (state is GetChallengesInfoLoadingState) {
            return const ChallengeDetailsSkeleton();
          }

          return _buildChallengeDetails(_challenge);
        },
      ),
    );
  }

  Widget _buildChallengeDetails(Challenges challenge) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Title
          Row(
            children: [
              Expanded(
                child: Text(
                  challenge.title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: ColorSchemes.black,
                        fontSize: 16,
                      ),
                ),
              ),

              const SizedBox(width: 16),
              // Status Chips
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (challenge.issuePrioColor.label.isNotEmpty)
                    StatusWidget(
                      statusMessage: challenge.issuePrioColor.label,
                      statusColor: challenge.issuePrioColor.color.toColor(),
                    ),
                  const SizedBox(width: 4),
                  if (challenge.statusColor.label.isNotEmpty)
                    StatusWidget(
                      statusColor: challenge.statusColor.color.toColor(),
                      statusMessage: challenge.statusColor.label,
                    ),
                ],
              ),
            ],
          ),
          // const SizedBox(height: 16),

          const SizedBox(height: 24),

          // Project info (two fields per row)
          _buildTwoInRow(
            S.of(context).projectName,
            challenge.projectName,
            S.of(context).projectManager,
            challenge.projectManagerStr,
          ),
          _buildTwoInRow(
            S.of(context).assignTo,
            challenge.assignedTo,
            S.of(context).owner,
            challenge.ownerStr,
          ),
          _buildTwoInRow(
            S.of(context).category,
            challenge.categoryStr,
            S.of(context).dueDate,
            formatDate(challenge.dueDate),
          ),
          _buildReadOnlyField(
            label: S.of(context).resolvedDate,
            value: formatDate(challenge.resolvedDate),
          ),

          const SizedBox(height: 16),
          Container(height: 0.75, color: ColorSchemes.border),
          const SizedBox(height: 16),
          ExpandableSection(
            title: S.of(context).description,
            value: _challenge.description,
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
            title: S.of(context).discussions,
            isPadding: false,
            value: _challenge.discussion,
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
            title: S.of(context).latestUpdateBrief,
            value: _challenge.resolution,
            isExpanded: isDescriptionWithinScopeExpanded,
            isPadding: false,
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
            title: S.of(context).problemFromClient,
            value: _challenge.problemFromClient,
            isExpanded: isDescriptionOutsideScopeExpanded,
            isPadding: false,
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

  /// Two fields in one row
  Widget _buildTwoInRow(
    String label1,
    String value1,
    String label2,
    String value2,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _buildReadOnlyField(label: label1, value: value1)),
        const SizedBox(width: 24),
        Expanded(child: _buildReadOnlyField(label: label2, value: value2)),
      ],
    );
  }

  /// Read-only field
  Widget _buildReadOnlyField({
    required String label,
    required String value,
    bool isMultiline = false,
    String? fieldKey,
  }) {
    final isExpanded = fieldKey != null ? _expanded[fieldKey]! : false;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
            value.isNotEmpty ? value : "_",
            maxLines: isMultiline && !isExpanded ? 2 : null,
            overflow: isMultiline && !isExpanded
                ? TextOverflow.ellipsis
                : TextOverflow.visible,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: ColorSchemes.black,
                  fontWeight: FontWeight.bold,
                ),
          ),
          if (isMultiline && value.length > 100)
            InkWell(
              onTap: () {
                setState(() {
                  _expanded[fieldKey!] = !isExpanded;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  isExpanded ? S.of(context).showLess : S.of(context).showMore,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: ColorSchemes.primary,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
