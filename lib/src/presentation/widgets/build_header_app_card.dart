import 'package:flutter/material.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/core/resources/image_paths.dart';
import 'package:mofa/src/core/utils/constants.dart';
import 'package:mofa/src/core/utils/extensions/color_extension.dart';
import 'package:mofa/src/di/data_layer_injector.dart';
import 'package:mofa/src/domain/entities/home/project.dart';
import 'package:mofa/src/domain/usecase/get_language_use_case.dart';
import 'package:mofa/src/presentation/widgets/status_widget.dart';

class BuildHeaderAppCard extends StatelessWidget {
  final String title;
  final Color statusColor;
  final String status;
  final String id;
  final String? strategy;
  final bool showStatus;
  final bool isProject;
  final bool isHasIssue;
  final bool isHasRisk;
  final bool isHasCR;
  final bool isSevity;
  final bool isPriority;
  final ProjectStatusColor? sevityStatusColor;
  final ProjectStatusColor? priorityStatusColor;

  const BuildHeaderAppCard({
    super.key,
    required this.title,
    required this.statusColor,
    required this.status,
    required this.id,
    this.strategy,
    this.showStatus = true,
    this.isProject = false,
    this.isHasIssue = false,
    this.isHasRisk = false,
    this.isHasCR = false,
    this.isSevity = false,
    this.sevityStatusColor,
    this.isPriority = false,
    this.priorityStatusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// Text Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                /// Title text (no Expanded here)
                if (title.isNotEmpty)
                  Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: ColorSchemes.black,
                          fontSize: title.split(" ").length > 3 ? 14 : 17,
                          fontWeight: Constants.fontWeightBold,
                        ),
                  ),
                const SizedBox(height: 8),

                /// ID or Strategy
                Row(
                  children: [
                    if (strategy != null || id.isNotEmpty)
                      Text(
                        strategy != null
                            ? strategy!
                            : GetLanguageUseCase(injector())() == "ar"
                                ? "#$id"
                                : "$id#",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: ColorSchemes.primary),
                      ),
                    if (isProject) const SizedBox(width: 8),
                    if (isProject && (isHasIssue || isHasRisk || isHasCR))
                      Row(
                        children: [
                          if (isHasIssue)
                            Image.asset(
                              ImagePaths.p1,
                              width: 32,
                              height: 32,
                              fit: BoxFit.cover,
                            ),
                          if (isHasRisk)
                            Image.asset(
                              ImagePaths.p2,
                              width: 32,
                              height: 32,
                              fit: BoxFit.cover,
                            ),
                          if (isHasCR)
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
          const SizedBox(width: 16),

          /// Status Widget with constrained width
          if (showStatus && status.isNotEmpty)
            StatusWidget(
              statusColor: statusColor,
              statusMessage: status,
              isProject: isProject,
            ),

          if (isSevity && sevityStatusColor != null) const SizedBox(width: 16),

          if (isSevity && sevityStatusColor != null)
            StatusWidget(
              statusColor: sevityStatusColor!.color.toColor(),
              statusMessage: sevityStatusColor!.label,
              isProject: isProject,
            ),

          if (isPriority && priorityStatusColor != null)
            const SizedBox(width: 16),

          if (isPriority && priorityStatusColor != null)
            StatusWidget(
              statusColor: priorityStatusColor!.color.toColor(),
              statusMessage: priorityStatusColor!.label,
              isProject: isProject,
            ),
        ],
      ),
    );
  }
}
