import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/config/routes/routes_manager.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/core/base/widget/base_stateful_widget.dart';
import 'package:mofa/src/core/resources/data_state.dart';
import 'package:mofa/src/core/resources/image_paths.dart';
import 'package:mofa/src/core/utils/extensions/color_extension.dart';
import 'package:mofa/src/core/utils/show_language_bottom_sheet.dart';
import 'package:mofa/src/core/utils/show_massage_dialog_widget.dart';
import 'package:mofa/src/core/utils/summaries.dart';
import 'package:mofa/src/di/data_layer_injector.dart';
import 'package:mofa/src/domain/entities/home/home_static.dart';
import 'package:mofa/src/domain/entities/home/home_statics_item.dart';
import 'package:mofa/src/domain/entities/home/user_info.dart';
import 'package:mofa/src/domain/entities/shared/chart_graph.dart';
import 'package:mofa/src/domain/usecase/get_language_use_case.dart';
import 'package:mofa/src/domain/usecase/home/get_current_user_info_use_case.dart';
import 'package:mofa/src/presentation/blocs/home/home_bloc.dart';
import 'package:mofa/src/presentation/screens/home/skeleton/home_skeleton.dart';
import 'package:mofa/src/presentation/screens/home/widgets/home_details_widget.dart';
import 'package:mofa/src/presentation/screens/home/widgets/home_header_section.dart';
import 'package:mofa/src/presentation/screens/home/widgets/image_widget.dart';
import 'package:mofa/src/presentation/screens/home/widgets/kpi_widgets.dart';
import 'package:mofa/src/presentation/screens/profile/profile_screen.dart';
import 'package:mofa/src/presentation/widgets/circle_chart_full_widget.dart';
import 'package:mofa/src/presentation/widgets/circle_chart_half_without_legend_widget.dart';

int totalApprovals = 0;

class HomeScreen extends BaseStatefulWidget {
  const HomeScreen({super.key});

  @override
  BaseState<HomeScreen> baseCreateState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeScreen> {
  List<HomeStatistics> _statistics = [];
  CurrentUserInfo _currentUserInfo = const CurrentUserInfo();

  HomeBloc get _bloc => BlocProvider.of<HomeBloc>(context);

  @override
  void initState() {
    _getCurrentUserInfo();

    super.initState();
    _bloc.add(GetSummariesEvent());
  }

  Future<void> _getCurrentUserInfo() async {
    final DataState<CurrentUserInfo> userInfo =
        await GetCurrentUserInfoUseCase(injector())();
    if (userInfo is DataSuccess) {
      currentUser = userInfo.data ?? const CurrentUserInfo();
    }
    setState(() {
      _currentUserInfo = currentUser;
    });
  }

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is GetSummariesSuccessState) {
          _statistics = state.statistics;
          for (var item in _statistics) {
            Summaries summary = GetLanguageUseCase(injector())() == "en"
                ? parseSummaryEnglish(item.title)
                : parseSummary(item.title);
            if (summary == Summaries.Approvals) {
              totalApprovals = _getCount(item.items).toInt();
            }
          }
        } else if (state is GetSummariesErrorState) {
          _showMessageDialog(
            message: state.message,
            icon: ImagePaths.warning,
          );
        }
      },
      builder: (context, state) {
        if (state is GetSummariesLoadingState) {
          return const HomeSkeleton();
        }
        return RefreshIndicator(
          onRefresh: () async => _bloc.add(GetSummariesEvent()),
          child: Scaffold(
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 18),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ProfileScreen(
                                userInfo: _currentUserInfo,
                              ),
                            ),
                          );
                        },
                        child: HomeHeaderSection(
                          user: _currentUserInfo,
                          notificationCount: totalApprovals,
                          onNotificationTapped: () {
                            Navigator.pushNamed(
                              context,
                              Routes.agreementsScreen,
                              arguments: {"isShowBackButton": true},
                            );
                          },
                          onLanguageTapped: () {
                            _showBottomSheetLanguage(context);
                          },
                          onTapImageProfile: (image) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => FullScreenImageViewer(
                                  imageUrl: image,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration:
                          const BoxDecoration(color: ColorSchemes.secondary),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(S.of(context).details,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      color: ColorSchemes.black,
                                      fontSize: 17,
                                    )),
                            const SizedBox(height: 16),
                            HomeDetailsWidget(
                              isVisibleAgreements:
                                  _getItemVisible(S.of(context).agreements),
                              isVisibleChallenges:
                                  _getItemVisible(S.of(context).issues),
                              isVisibleProject:
                                  _getItemVisible(S.of(context).projects),
                              isVisibleRisks:
                                  _getItemVisible(S.of(context).risks),
                              isVisibleStrategy:
                                  _getItemVisible(S.of(context).deliverables),
                              onTapAgreements: () {
                                Navigator.pushNamed(
                                  context,
                                  Routes.agreementsScreen,
                                  arguments: {"isShowBackButton": true},
                                );
                              },
                              onTapChallenges: () {
                                Navigator.pushNamed(
                                  context,
                                  Routes.challengesScreen,
                                  arguments: {"isShowBackButton": true},
                                );
                              },
                              onTapProject: () {
                                Navigator.pushNamed(
                                  context,
                                  Routes.projectsScreen,
                                  arguments: {"isShowBackButton": true},
                                );
                              },
                              onTapRisks: () {
                                Navigator.pushNamed(
                                  context,
                                  Routes.risksScreen,
                                  arguments: {"isShowBackButton": true},
                                );
                              },
                              onTapStrategy: () {
                                Navigator.pushNamed(
                                  context,
                                  Routes.deliverablesScreen,
                                  arguments: {"isShowBackButton": true},
                                );
                              },
                            ),
                            const SizedBox(height: 16),
                            Text(
                              S.of(context).summaries,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color: ColorSchemes.black,
                                    fontSize: 17,
                                  ),
                            ),
                            const SizedBox(height: 16),
                            if (_statistics.isNotEmpty)
                              ListView.separated(
                                itemCount: _statistics.length,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                separatorBuilder: (_, index) {
                                  // if (_statistics[index].items.isNotEmpty) {
                                  //   if (_statistics[index].items.length > 1) {
                                  //     print(
                                  //         "dddddddddd${_statistics[index].items[1].count}");
                                  //     totalApprovals =
                                  //         _statistics[index].items[1].count;
                                  //   }
                                  // }

                                  HomeStatistics item = _statistics[index];
                                  Summaries summary =
                                      GetLanguageUseCase(injector())() == "en"
                                          ? parseSummaryEnglish(item.title)
                                          : parseSummary(item.title);
                                  if (_statistics[index].visible == false ||
                                      (summary == Summaries.Projects ||
                                          summary == Summaries.Risks ||
                                          summary == Summaries.Issues ||
                                          summary == Summaries.Deliverables)) {
                                    return const SizedBox.shrink();
                                  }
                                  return const SizedBox(height: 24);
                                },
                                itemBuilder: (context, index) {
                                  HomeStatistics item = _statistics[index];
                                  Summaries summary =
                                      GetLanguageUseCase(injector())() == "en"
                                          ? parseSummaryEnglish(item.title)
                                          : parseSummary(item.title);
                                  if (_statistics[index].visible == false ||
                                      (summary == Summaries.Projects ||
                                          summary == Summaries.Risks ||
                                          summary == Summaries.Issues ||
                                          summary == Summaries.Deliverables)) {
                                    return const SizedBox.shrink();
                                  }
                                  return Container(
                                    height: 218,
                                    width: _getWidth(),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    decoration: const BoxDecoration(
                                      color: ColorSchemes.white,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(12),
                                      ),
                                    ),
                                    child: _getWidget(index),
                                  );
                                },
                              ),
                            const SizedBox(height: 32),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
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

  double _getWidth() {
    return MediaQuery.of(context).size.width > 400
        ? MediaQuery.of(context).size.width * 0.81
        : MediaQuery.of(context).size.width * 0.845;
  }

  double _getCount(List<HomeStaticsItem> items) {
    double count = 0;
    for (var element in items) {
      count += element.count;
    }
    return count;
  }

  Widget _getWidget(int index) {
    HomeStatistics item = _statistics[index];
    Summaries summary = GetLanguageUseCase(injector())() == "en"
        ? parseSummaryEnglish(item.title)
        : parseSummary(item.title);
    switch (summary) {
      case Summaries.Milestones:
        return InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              Routes.milstonesScreen,
              arguments: {"isShowBackButton": true},
            );
          },
          child: CircleChartHalfWithoutLegendWidget(
            chartGraph: _statistics[index]
                .items
                .map((e) => ChartGraph(
                    x: e.label, y: e.count, color: e.color.toColor()))
                .toList(),
            titleText: _statistics[index].title,
          ),
        );
      // case Summaries.Approvals:
      //
      //   return KPIWidgets(
      //     homeStatistics: _statistics[index],
      //     isKPI: false,
      //     onTap: () {
      //       Navigator.pushNamed(
      //         context,
      //         Routes.agreementsScreen,
      //         arguments: {"isShowBackButton": true},
      //       );
      //     },
      //   );
      case Summaries.KPIs:
        return KPIWidgets(
          homeStatistics: _statistics[index],
          isKPI: true,
          onTap: () {
            Navigator.pushNamed(
              context,
              Routes.pointersScreen,
              arguments: {"isShowBackButton": true},
            );
          },
        );
      case Summaries.Tasks || Summaries.Approvals:
        totalApprovals = _getCount(_statistics[index].items).toInt();
        return CircleChartFullWidget(
          onTap: () {
            if (summary == Summaries.Approvals) {
              Navigator.pushNamed(
                context,
                Routes.agreementsScreen,
                arguments: {"isShowBackButton": true},
              );
              return;
            }
            Navigator.pushNamed(
              context,
              Routes.tasksScreen,
              arguments: {"isShowBackButton": true},
            );
          },
          chartGraph: _statistics[index]
              .items
              // .sublist(0, _statistics[index].items.length - 1)
              .map((e) =>
                  ChartGraph(x: e.label, y: e.count, color: e.color.toColor()))
              .toList(),
          titleText:
              // "${S.of(context).agreements} (${_getCount(_statistics[index].items.sublist(0, _statistics[index].items.length - 1)).toInt()})",
              // "${_statistics[index].title} (${_getCount(_statistics[index].items).toInt()})",
              "${_statistics[index].title} (${_getCount(_statistics[index].items).toInt()})",
        );
      default:
        return const SizedBox.shrink();
    }
  }

  void _showBottomSheetLanguage(BuildContext context) {
    showLanguageBottomSheet(context: context);
  }

  bool _getItemVisible(String value) {
    for (HomeStatistics element in _statistics) {
      if (element.title == value) {
        if (element.visible) {
          return true;
        } else {
          return false;
        }
      }
    }
    return false;
  }
}
