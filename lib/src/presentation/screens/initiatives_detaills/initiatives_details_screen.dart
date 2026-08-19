import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/core/base/widget/base_stateful_widget.dart';
import 'package:mofa/src/core/utils/show_massage_dialog_widget.dart';
import 'package:mofa/src/core/utils/show_sort_bottom_sheet.dart';
import 'package:mofa/src/domain/entities/home/challenges.dart';
import 'package:mofa/src/domain/entities/home/information.dart';
import 'package:mofa/src/domain/entities/home/land_mark.dart';
import 'package:mofa/src/domain/entities/home/out_put.dart';
import 'package:mofa/src/domain/entities/home/output_attachments.dart';
import 'package:mofa/src/domain/entities/home/project.dart';
import 'package:mofa/src/domain/entities/home/risks.dart';
import 'package:mofa/src/domain/entities/shared/chart_graph.dart';
import 'package:mofa/src/domain/entities/shared/status.dart';
import 'package:mofa/src/domain/entities/shared/steps.dart';
import 'package:mofa/src/presentation/blocs/initiatives_details/initiatives_details_bloc.dart';
import 'package:mofa/src/presentation/screens/home/home_screen.dart';
import 'package:mofa/src/presentation/screens/initiatives_detaills/widgets/information_card_widget.dart';
import 'package:mofa/src/presentation/widgets/bell_notification_widget.dart';
import 'package:mofa/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:mofa/src/presentation/widgets/challenges_card_widget.dart';
import 'package:mofa/src/presentation/widgets/landmark_card_widget.dart';
import 'package:mofa/src/presentation/widgets/output_card_widget.dart';
import 'package:mofa/src/presentation/widgets/risks_card_widget.dart';
import 'package:mofa/src/presentation/widgets/steps_widget.dart';

class InitiativesDetailsScreen extends BaseStatefulWidget {
  final Project initiatives;

  const InitiativesDetailsScreen({
    super.key,
    required this.initiatives,
  });

  @override
  BaseState<InitiativesDetailsScreen> baseCreateState() =>
      _InitiativesDetailsScreenState();
}

class _InitiativesDetailsScreenState
    extends BaseState<InitiativesDetailsScreen> {
  InitiativesDetailsBloc get _bloc =>
      BlocProvider.of<InitiativesDetailsBloc>(context);
  final List<Information> _information = [];
  final List<OutPut> _output = [];
  final List<Landmark> _landmarks = [];
  final List<Risks> _risks = [];
  final List<Challenges> _challenges = [];
  bool _isFirst = true;

  int _selectedId = 0;
  final List<ChartGraph> _chartGraph = [
    const ChartGraph(x: 'لم تبدا', y: 1, color: Colors.greenAccent),
    const ChartGraph(x: 'على اليسار', y: 1, color: Colors.blue),
    const ChartGraph(x: 'متاخره', y: 0, color: Colors.yellow),
    const ChartGraph(x: 'متاخره جدا', y: 0, color: Colors.red),
    const ChartGraph(x: 'مكتمله', y: 1, color: Colors.purple),
  ];

  @override
  void initState() {
    super.initState();
    _dumpData();
  }

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<InitiativesDetailsBloc, InitiativesDetailsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: buildAppBarWidget(
            context,
            title: widget.initiatives.title,
            isHaveBackButton: true,
            centredTitle: false,
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
                  isAnotherSpace: false,
                  isLandmarkStatusSaved: false,
                  onLandMarkStatusTapped: (int statusIndex) {},
                  onLandMarkStatusCleared: (int index) {},
                  onSortTapped: () => _showSortBottomSheet(context),
                  steps: [
                    Steps(id: 0, name: S.of(context).information),
                    Steps(id: 1, name: S.of(context).output),
                    Steps(id: 2, name: S.of(context).landmarks),
                    Steps(id: 3, name: S.of(context).risks),
                    Steps(id: 4, name: S.of(context).challenges),
                    Steps(id: 5, name: S.of(context).notes),
                  ],
                  pages: [
                    _buildInformationWidget(),
                    _buildOutputWidget(),
                    _buildLandmarksWidget(),
                    _buildRisksWidget(),
                    _buildChallengesWidget(),
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

  void _showMessageDialog({
    required String message,
    required String icon,
  }) {
    showMassageDialogWidget(
      context: context,
      text: message,
      icon: icon,
      buttonText: S.of(context).ok,
      onTap: () => Navigator.pop(context),
    );
  }

  void _showSortBottomSheet(BuildContext context) {
    showSortsBottomSheet(
      isFirst: _isFirst,
      context: context,
      onSortSelected: (value) {
        setState(() {
          _isFirst = false;
        });
      },
    );
  }

  Widget _buildInformationWidget() {
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
              itemBuilder: (context, index) => InformationCardWidget(
                information: _information[index],
                onTap: (information) {},
                chartGraph: _chartGraph,
              ),
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemCount: _information.length,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildOutputWidget() {
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
              itemBuilder: (context, index) => OutPutCardWidget(
                output: _output[index],
                onTap: (output) {},
              ),
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemCount: _output.length,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildLandmarksWidget() {
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
              itemBuilder: (context, index) => LandmarkCardWidget(
                landmark: _landmarks[index],
                onTap: (landmark) {},
              ),
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemCount: _landmarks.length,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

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

  Widget _buildChallengesWidget() {
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
              itemBuilder: (context, index) => ChallengesCardWidget(
                challenge: _challenges[index],
                onTap: (challenge) {},
              ),
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemCount: _challenges.length,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildNotesWidget() {
    return Text(widget.initiatives.title);
  }

  void _dumpData() {
    for (int i = 0; i < 10; i++) {
      _information.add(
        const Information(
          id: '82912121',
          managerName: ' الادارة المالكة',
          startDate: '21 مارس 2025',
          endDate: '21 مارس 2025',
          status: 'جارى التنفيذ',
          statusColor: ColorSchemes.yellow,
          achievedProgress: Status(percentage: 80),
          planProgress: Status(percentage: 80, color: ColorSchemes.purple),
        ),
      );
    }
    for (int i = 0; i < 10; i++) {
      _landmarks.add(
        const Landmark(
          id: '82912121',
          name: "أسم المعلم",
          managerName: ' الادارة المالكة',
          endDateReal: '21 مارس 2025',
          endDateExpected: '21 مارس 2025',
          status: 'جارى التنفيذ',
          statusColor: ColorSchemes.yellow,
          address: "الرياض-5",
          implementationState: "قيد التنفيذ",
          numberOfDays: 12,
          progressImplementation: Status(percentage: 80),
          weight: 30,
          startDateBasicsLine: '21 مارس 2025',
          endDateBasicsLine: '21 مارس 2025',
        ),
      );
    }
    for (int i = 0; i < 10; i++) {
      _output.add(
        const OutPut(
          id: '82912121',
          deliverableName: "اسم المخرج",
          status: 'جارى التنفيذ',
          statusColor: ColorSchemes.yellow,
          planProgress: Status(percentage: 80),
          achievedProgress: Status(percentage: 70, color: ColorSchemes.purple),
          deliverableStartDate: '21 مارس 2025',
          deliverableEndDate: '21 مارس 2025',
          attachments: [
            OutPutAttachments(name: "ملف خاص بالمخاطر"),
            OutPutAttachments(
              name: "ملف خاص بالمخاطر",
              isPdf: true,
            ),
          ],
        ),
      );
    }
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
    for (int i = 0; i < 10; i++) {
      _challenges.add(
        const Challenges(
          id: '82912121',
          title: "اسم التحدي",
          status: 'جارى التنفيذ',
          // statusColor: ColorSchemes.yellow,
          endDate: '21 مارس 2025',
          attachments: [
            OutPutAttachments(name: "ملف خاص بالمخاطر"),
            OutPutAttachments(
              name: "ملف خاص بالمخاطر",
              isPdf: true,
            ),
          ],
          description: "وصف التحدي",
          projectManagerStr: ' الادارة المالكة',
          category: "التصنيف",
          challengeRisk: Status(color: ColorSchemes.yellow, percentage: 80),
          department: "الادارة",
          problemReasons: "السبب",
          solveDate: "21 مارس 2025",
          suggestSolution: "الحل",
        ),
      );
    }
  }
}
