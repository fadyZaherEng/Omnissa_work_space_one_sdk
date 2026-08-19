import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/core/base/widget/base_stateful_widget.dart';
import 'package:mofa/src/domain/entities/home/output_attachments.dart';
import 'package:mofa/src/domain/entities/home/risks.dart';
import 'package:mofa/src/domain/entities/home/stratgy.dart';
import 'package:mofa/src/domain/entities/shared/status.dart';
import 'package:mofa/src/domain/entities/shared/steps.dart';
import 'package:mofa/src/presentation/blocs/strategy_details/strategy_details_bloc.dart';
import 'package:mofa/src/presentation/screens/home/home_screen.dart';
import 'package:mofa/src/presentation/widgets/bell_notification_widget.dart';
import 'package:mofa/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:mofa/src/presentation/widgets/risks_card_widget.dart';
import 'package:mofa/src/presentation/widgets/steps_widget.dart';

class StrategyDetailsScreen extends BaseStatefulWidget {
  final Strategy strategy;

  const StrategyDetailsScreen({
    super.key,
    required this.strategy,
  });

  @override
  BaseState<StrategyDetailsScreen> baseCreateState() =>
      _StrategyDetailsScreenState();
}

class _StrategyDetailsScreenState extends BaseState<StrategyDetailsScreen> {
  StrategyDetailsBloc get _bloc =>
      BlocProvider.of<StrategyDetailsBloc>(context);

  // final List<Information> _information = [];
  // final List<OutPut> _output = [];
  // final List<Landmark> _landmarks = [];
  final List<Risks> _risks = [];

  // final List<Challenges> _challenges = [];
  int _selectedId = 0;

  @override
  void initState() {
    super.initState();
    _dumpData();
  }

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<StrategyDetailsBloc, StrategyDetailsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: buildAppBarWidget(
            context,
            title: widget.strategy.name,
            isHaveBackButton: true,
            onBackButtonPressed: () => Navigator.pop(context),
            actionWidget: BellNotificationWidget(
              totalApprovals: totalApprovals,
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Expanded(
                child: StepsWidget(
                  isBackgroundColor: false,
                  backgroundColor: ColorSchemes.secondary,
                  isStepBackgroundColor: false,
                  height: 60,
                  isLandmarkStatusSaved: false,
                  isAnotherSpace: false,
                  isShowOptionsForAll: true,
                  onLandMarkStatusTapped: (int statusIndex) {},
                  onLandMarkStatusCleared: (int index) {},
                  steps: [
                    Steps(id: 0, name: S.of(context).summary),
                    Steps(id: 1, name: S.of(context).goals),
                    Steps(id: 2, name: S.of(context).initiatives),
                    Steps(id: 3, name: S.of(context).pointers),
                    Steps(id: 4, name: S.of(context).risks),
                    Steps(id: 5, name: S.of(context).notes),
                  ],
                  pages: [
                    Container(),
                    Container(),
                    Container(),
                    Container(),
                    // _buildInformationWidget(),
                    // _buildOutputWidget(),
                    // _buildLandmarksWidget(),
                    _buildRisksWidget(),
                    // _buildChallengesWidget(),
                    _buildNotesWidget(),
                  ],
                  onStepTapped: (int id) {
                    setState(() {
                      _selectedId = id;
                    });
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOptionWidget({
    required String title,
    required String image,
    required void Function() onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 85,
        height: 38,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: ColorSchemes.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: ColorSchemes.border, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              image,
              width: 24,
              height: 24,
              fit: BoxFit.scaleDown,
              color: ColorSchemes.black,
            ),
            const SizedBox(width: 4),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: ColorSchemes.black),
            ),
          ],
        ),
      ),
    );
  }

  // void _showSortBottomSheet(BuildContext context) {
  //   showSortsBottomSheet(
  //     context: context,
  //     onSortSelected: (value) {},
  //   );
  // }

  // Widget _buildInformationWidget() {
  //   return SingleChildScrollView(
  //     child: Column(
  //       children: [
  //         const SizedBox(height: 32),
  //         Container(
  //           padding: const EdgeInsets.symmetric(horizontal: 16),
  //           decoration: const BoxDecoration(
  //             boxShadow: [
  //               BoxShadow(
  //                 color: ColorSchemes.projectBackground,
  //                 offset: Offset(0, 4),
  //                 blurRadius: 1,
  //                 spreadRadius: 24,
  //               ),
  //             ],
  //           ),
  //           child: ListView.separated(
  //             physics: const NeverScrollableScrollPhysics(),
  //             shrinkWrap: true,
  //             itemBuilder: (context, index) => InformationCardWidget(
  //               information: _information[index],
  //               onTap: (information) {},
  //             ),
  //             separatorBuilder: (_, __) => const SizedBox(height: 8),
  //             itemCount: _information.length,
  //           ),
  //         ),
  //         const SizedBox(height: 16),
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget _buildOutputWidget() {
  //   return SingleChildScrollView(
  //     child: Column(
  //       children: [
  //         const SizedBox(height: 32),
  //         Container(
  //           padding: const EdgeInsets.symmetric(horizontal: 16),
  //           decoration: const BoxDecoration(
  //             boxShadow: [
  //               BoxShadow(
  //                 color: ColorSchemes.projectBackground,
  //                 offset: Offset(0, 4),
  //                 blurRadius: 1,
  //                 spreadRadius: 24,
  //               ),
  //             ],
  //           ),
  //           child: ListView.separated(
  //             physics: const NeverScrollableScrollPhysics(),
  //             shrinkWrap: true,
  //             itemBuilder: (context, index) => OutPutCardWidget(
  //               output: _output[index],
  //               onTap: (output) {},
  //             ),
  //             separatorBuilder: (_, __) => const SizedBox(height: 8),
  //             itemCount: _output.length,
  //           ),
  //         ),
  //         const SizedBox(height: 16),
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget _buildLandmarksWidget() {
  //   return SingleChildScrollView(
  //     child: Column(
  //       children: [
  //         const SizedBox(height: 32),
  //         Container(
  //           padding: const EdgeInsets.symmetric(horizontal: 16),
  //           decoration: const BoxDecoration(
  //             boxShadow: [
  //               BoxShadow(
  //                 color: ColorSchemes.projectBackground,
  //                 offset: Offset(0, 4),
  //                 blurRadius: 1,
  //                 spreadRadius: 24,
  //               ),
  //             ],
  //           ),
  //           child: ListView.separated(
  //             physics: const NeverScrollableScrollPhysics(),
  //             shrinkWrap: true,
  //             itemBuilder: (context, index) => LandmarkCardWidget(
  //               landmark: _landmarks[index],
  //               onTap: (landmark) {},
  //             ),
  //             separatorBuilder: (_, __) => const SizedBox(height: 8),
  //             itemCount: _landmarks.length,
  //           ),
  //         ),
  //         const SizedBox(height: 16),
  //       ],
  //     ),
  //   );
  // }
  //
  Widget _buildRisksWidget() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: ColorSchemes.projectBackground,
                  offset: Offset(0, 4),
                  blurRadius: 1,
                  spreadRadius: 24,
                ),
              ],
            ),
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => RisksCardWidget(
                risks: _risks[index],
                onTap: (risk) {},
              ),
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemCount: _risks.length,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  // Widget _buildChallengesWidget() {
  //   return SingleChildScrollView(
  //     child: Column(
  //       children: [
  //         const SizedBox(height: 32),
  //         Container(
  //           padding: const EdgeInsets.symmetric(horizontal: 16),
  //           decoration: const BoxDecoration(
  //             boxShadow: [
  //               BoxShadow(
  //                 color: ColorSchemes.projectBackground,
  //                 offset: Offset(0, 4),
  //                 blurRadius: 1,
  //                 spreadRadius: 24,
  //               ),
  //             ],
  //           ),
  //           child: ListView.separated(
  //             physics: const NeverScrollableScrollPhysics(),
  //             shrinkWrap: true,
  //             itemBuilder: (context, index) => ChallengesCardWidget(
  //               challenge: _challenges[index],
  //               onTap: (challenge) {},
  //             ),
  //             separatorBuilder: (_, __) => const SizedBox(height: 8),
  //             itemCount: _challenges.length,
  //           ),
  //         ),
  //         const SizedBox(height: 16),
  //       ],
  //     ),
  //   );
  // }
  //
  Widget _buildNotesWidget() {
    return Container(
      child: Text(widget.strategy.name),
    );
  }

  void _dumpData() {
    // for (int i = 0; i < 10; i++) {
    //   _information.add(
    //     const Information(
    //       id: '82912121',
    //       managerName: ' الادارة المالكة',
    //       startDate: '21 مارس 2025',
    //       endDate: '21 مارس 2025',
    //       status: 'جارى التنفيذ',
    //       statusColor: ColorSchemes.yellow,
    //       achievedProgress: Status(percentage: 80),
    //       planProgress: Status(percentage: 80, color: ColorSchemes.purple),
    //     ),
    //   );
    // }
    // for (int i = 0; i < 10; i++) {
    //   _landmarks.add(
    //     const Landmark(
    //       id: '82912121',
    //       title: "أسم المعلم",
    //       managerName: ' الادارة المالكة',
    //       endDateReal: '21 مارس 2025',
    //       endDateExpected: '21 مارس 2025',
    //       status: 'جارى التنفيذ',
    //       statusColor: ColorSchemes.yellow,
    //       address: "الرياض-5",
    //       implementationState: "قيد التنفيذ",
    //       numberOfDays: 12,
    //       progressImplementation: Status(percentage: 80),
    //       weight: 30,
    //       startDateBasicsLine: '21 مارس 2025',
    //       endDateBasicsLine: '21 مارس 2025',
    //     ),
    //   );
    // }
    // for (int i = 0; i < 10; i++) {
    //   _output.add(
    //     const OutPut(
    //       id: '82912121',
    //       title: "اسم المخرج",
    //       status: 'جارى التنفيذ',
    //       statusColor: ColorSchemes.yellow,
    //       planProgress: Status(percentage: 80),
    //       achievedProgress: Status(percentage: 70, color: ColorSchemes.purple),
    //       startDate: '21 مارس 2025',
    //       endDate: '21 مارس 2025',
    //       attachments: [
    //         OutPutAttachments(name: "ملف خاص بالمخاطر"),
    //         OutPutAttachments(
    //           name: "ملف خاص بالمخاطر",
    //           isPdf: true,
    //         ),
    //       ],
    //     ),
    //   );
    // }
    for (int i = 0; i < 10; i++) {
      _risks.add(
        const Risks(
            id: '82912121',
            title: "اسم الخطر",
            statusStr: 'جارى التنفيذ',
            // statusColor: ColorSchemes.yellow,
            specificDate: '21 مارس 2025',
            attachments: [
              OutPutAttachments(name: "ملف خاص بالمخاطر"),
              OutPutAttachments(
                name: "ملف خاص بالمخاطر",
                isPdf: true,
              ),
            ],
            description: "وصف الخطر",
            projectManagerStr: ' الادارة المالكة',
            riskEffect:
                Status(color: ColorSchemes.red, name: "مرتفعه", percentage: 80),
            riskStatus: Status(color: ColorSchemes.yellow, percentage: 80),
            riskStrong: Status(color: ColorSchemes.purple, name: "عالية")),
      );
    }
    // for (int i = 0; i < 10; i++) {
    //   _challenges.add(
    //     const Challenges(
    //       id: '82912121',
    //       title: "اسم التحدي",
    //       status: 'جارى التنفيذ',
    //       statusColor: ColorSchemes.yellow,
    //       endDate: '21 مارس 2025',
    //       attachments: [
    //         OutPutAttachments(name: "ملف خاص بالمخاطر"),
    //         OutPutAttachments(
    //           name: "ملف خاص بالمخاطر",
    //           isPdf: true,
    //         ),
    //       ],
    //       description: "وصف التحدي",
    //       managerName: ' الادارة المالكة',
    //       category: "التصنيف",
    //       challengeRisk: Status(color: ColorSchemes.yellow, percentage: 80),
    //       department: "الادارة",
    //       problemReasons: "السبب",
    //       solveDate: "21 مارس 2025",
    //       suggestSolution: "الحل",
    //     ),
    //   );
    // }
  }
}
