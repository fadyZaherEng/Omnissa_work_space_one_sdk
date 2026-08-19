// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/core/base/widget/base_stateful_widget.dart';
import 'package:mofa/src/core/resources/image_paths.dart';
import 'package:mofa/src/core/utils/show_comment_bottom_sheet.dart';
import 'package:mofa/src/core/utils/show_massage_dialog_widget.dart';
import 'package:mofa/src/core/utils/show_sort_bottom_sheet.dart';
import 'package:mofa/src/data/sources/remote/mofa/more/request/request_save_project_latest.dart';
import 'package:mofa/src/di/data_layer_injector.dart';
import 'package:mofa/src/domain/entities/home/challenges.dart';
import 'package:mofa/src/domain/entities/home/complinace.dart';
import 'package:mofa/src/domain/entities/home/land_mark.dart';
import 'package:mofa/src/domain/entities/home/out_put.dart';
import 'package:mofa/src/domain/entities/home/project.dart';
import 'package:mofa/src/domain/entities/home/project_details.dart';
import 'package:mofa/src/domain/entities/home/risks.dart';
import 'package:mofa/src/domain/entities/home/work_flow_history_list.dart';
import 'package:mofa/src/domain/entities/shared/steps.dart';
import 'package:mofa/src/presentation/blocs/project_details/project_details_bloc.dart';
import 'package:mofa/src/presentation/screens/home/home_screen.dart';
import 'package:mofa/src/presentation/screens/project_detaills/skeleton/project_skeleton.dart';
import 'package:mofa/src/presentation/screens/project_detaills/widgets/complinace_card_widget.dart';
import 'package:mofa/src/presentation/screens/project_detaills/widgets/time_line_item_widget.dart';
import 'package:mofa/src/presentation/widgets/bell_notification_widget.dart';
import 'package:mofa/src/presentation/widgets/challenges_card_widget.dart';
import 'package:mofa/src/presentation/screens/project_detaills/widgets/information_card_widget.dart';
import 'package:mofa/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:mofa/src/presentation/widgets/custom_empty_list_widget.dart';
import 'package:mofa/src/presentation/widgets/landmark_card_widget.dart';
import 'package:mofa/src/presentation/widgets/output_card_widget.dart';
import 'package:mofa/src/presentation/widgets/risks_card_widget.dart';
import 'package:mofa/src/presentation/widgets/steps_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProjectDetailsScreen extends BaseStatefulWidget {
  final String projectId;

  const ProjectDetailsScreen({
    super.key,
    required this.projectId,
  });

  @override
  BaseState<ProjectDetailsScreen> baseCreateState() =>
      _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends BaseState<ProjectDetailsScreen> {
  ProjectDetailsBloc get _bloc => BlocProvider.of<ProjectDetailsBloc>(context);
  final List<Project> _information = [];
  final List<OutPut> _output = [];
  final List<Landmark> _landmarks = [];
  final List<Risks> _risks = [];
  final List<Challenges> _challenges = [];
  final List<Complinace> _compliance = [];
  int _selectedId = 0;
  ProjectDetails _projectDetails = const ProjectDetails();
  bool _isFirst = true;
  final TextEditingController _commentController = TextEditingController();
  String? _errorMessage;
  bool _isLandmarkStatusSaved = false;
  int _skip = 0;
  final int _pageSize = 10;
  final ScrollController _outputScrollController = ScrollController();
  final ScrollController _landmarksScrollController = ScrollController();
  final ScrollController _risksScrollController = ScrollController();
  final ScrollController _challengesScrollController = ScrollController();
  final ScrollController _complianceScrollController = ScrollController();
  bool _isLoadingMore = false;
  bool _hasMore = true;
  String _searchValue = "";

  @override
  void initState() {
    _searchValue = "1";
    _bloc.add(GetProjectDetailsEvent(
      projectId: widget.projectId,
      searchValue: "",
      draw: "1",
      skip: _skip,
      pageSize: _pageSize,
      isPagination: false,
    ));

    // injector<SharedPreferences>().setInt('landmark_status', 0);
    super.initState();
    // _outputScrollController.addListener(() {
    //   _onScroll("1", _outputScrollController);
    // });
    // _landmarksScrollController.addListener(() {
    //   _onScroll("4", _landmarksScrollController);
    // });
    // _risksScrollController.addListener(() {
    //   _onScroll("1", _risksScrollController);
    // });
    // _challengesScrollController.addListener(() {
    //   _onScroll("1", _challengesScrollController);
    // });
    // _complianceScrollController.addListener(() {
    //   _onScroll("1", _complianceScrollController);
    // });
    _outputScrollController.addListener(() => _onScroll(_outputScrollController));
    _landmarksScrollController.addListener(() => _onScroll(_landmarksScrollController));
    _risksScrollController.addListener(() => _onScroll(_risksScrollController));
    _challengesScrollController.addListener(() => _onScroll(_challengesScrollController));
    _complianceScrollController.addListener(() => _onScroll(_complianceScrollController));

  }

  // void _onScroll(String draw, ScrollController scrollController) {
  //   if (scrollController.position.pixels >=
  //       scrollController.position.maxScrollExtent - 200) {
  //     if (!_isLoadingMore && _hasMore) {
  //       _isLoadingMore = true;
  //       _skip += _pageSize;
  //       _bloc.add(GetProjectDetailsEvent(
  //         projectId: widget.projectId,
  //         searchValue: draw == "4" ? _searchValue : "",
  //         draw: draw,
  //         skip: _skip,
  //         pageSize: _pageSize,
  //         isPagination: true,
  //       ));
  //     }
  //   }
  // }
  void _onScroll(ScrollController scrollController) {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      if (!_isLoadingMore && _hasMore) {
        _isLoadingMore = true;
        _skip += _pageSize;

        String draw = "1";
        String searchValue = "";
        if (_selectedId == 2) {
          draw = "4";
          searchValue = _searchValue;
        }

        _bloc.add(GetProjectDetailsEvent(
          projectId: widget.projectId,
          searchValue: searchValue,
          draw: draw,
          skip: _skip,
          pageSize: _pageSize,
          isPagination: true,
        ));
      }
    }
  }

  @override
  void dispose() {
    _outputScrollController.dispose();
    _landmarksScrollController.dispose();
    _risksScrollController.dispose();
    _challengesScrollController.dispose();
    _complianceScrollController.dispose();
    injector<SharedPreferences>().remove('landmark_status');

    super.dispose();
  }

  @override
  Widget baseBuild(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _skip = 0;
        _hasMore = true;
        _isLoadingMore = false;
        _output.clear();
        _outputScrollController.jumpTo(0);
        _landmarks.clear();
        _landmarksScrollController.jumpTo(0);
        _risks.clear();
        _risksScrollController.jumpTo(0);
        _challenges.clear();
        _challengesScrollController.jumpTo(0);
        _compliance.clear();
        _complianceScrollController.jumpTo(0);
        _bloc.add(
          GetProjectDetailsEvent(
            projectId: widget.projectId,
            searchValue: "",
            draw: "1",
            skip: _skip,
            pageSize: _pageSize,
            isPagination: false,
          ),
        );
      },
      child: BlocConsumer<ProjectDetailsBloc, ProjectDetailsState>(
        listener: (context, state) {
          if (state is ProjectDetailsSuccessState) {
            _information.clear();
            _information.addAll([state.projectDetails.project]);
            _projectDetails = state.projectDetails;
            _commentController.text =
                state.projectDetails.project.latestUpdateBrief;
            if (state.isPagination) {
              if (_skip == 0 && _selectedId == 1) {
                _output.clear();
                _output.addAll(state.projectDetails.deliverables);
                _hasMore = state.projectDetails.deliverables.length == _pageSize;
              } else if (_skip != 0 && _selectedId == 1) {
                _output.addAll(state.projectDetails.deliverables);
                _hasMore = state.projectDetails.deliverables.length == _pageSize;
              }
              if (_skip == 0 && _selectedId == 2) {
                _landmarks.clear();
                _landmarks.addAll(state.projectDetails.milestones);
                _hasMore = state.projectDetails.milestones.length == _pageSize;
              } else if (_skip != 0 && _selectedId == 2) {
                _landmarks.addAll(state.projectDetails.milestones);
                _hasMore = state.projectDetails.milestones.length == _pageSize;
              }

              if (_skip == 0 && _selectedId == 3) {
                _risks.clear();
                _risks.addAll(state.projectDetails.risks);
                _hasMore = state.projectDetails.risks.length == _pageSize;
              } else if (_skip != 0 && _selectedId == 3) {
                _risks.addAll(state.projectDetails.risks);
                _hasMore = state.projectDetails.risks.length == _pageSize;
              }
              if (_skip == 0 && _selectedId == 4) {
                _challenges.clear();
                _challenges.addAll(state.projectDetails.issues);
                _hasMore = state.projectDetails.issues.length == _pageSize;
              } else if (_skip != 0 && _selectedId == 4) {
                _challenges.addAll(state.projectDetails.issues);
                _hasMore = state.projectDetails.issues.length == _pageSize;
              }
              if (_skip == 0 && _selectedId == 5) {
                _compliance.clear();
                _compliance.addAll(state.projectDetails.compliance);
                _hasMore = state.projectDetails.compliance.length == _pageSize;
              } else if (_skip != 0 && _selectedId == 5) {
                _compliance.addAll(state.projectDetails.compliance);
                _hasMore = state.projectDetails.compliance.length == _pageSize;
              }
              _isLoadingMore = false;
            } else {
              _output.clear();
              _output.addAll(state.projectDetails.deliverables);
              _landmarks.clear();
              _landmarks.addAll(state.projectDetails.milestones);
              _risks.clear();
              _risks.addAll(state.projectDetails.risks);
              _challenges.clear();
              _challenges.addAll(state.projectDetails.issues);
              _compliance.clear();
              _compliance.addAll(state.projectDetails.compliance);
              if (_selectedId == 1) {
                _hasMore =state.projectDetails.deliverables.length == _pageSize;
              } else if (_selectedId == 2) {
                _hasMore = state.projectDetails.milestones.length == _pageSize;
              } else if (_selectedId == 3) {
                _hasMore = state.projectDetails.risks.length == _pageSize;
              } else if (_selectedId == 4) {
                _hasMore = state.projectDetails.issues.length == _pageSize;
              } else if (_selectedId == 5) {
                _hasMore =state.projectDetails.compliance.length == _pageSize;
              }
              _isLoadingMore = false;
            }
          } else if (state is ProjectDetailsErrorState) {
            _showMessageDialog(message: state.message, icon: ImagePaths.error);
          } else if (state is SaveProjectLatestLoadingState) {
            showLoading();
          } else if (state is SaveProjectLatestSuccessState) {
            _showMessageDialog(
              message: S.of(context).SaveProjectLatestSuccessfully,
              icon: ImagePaths.success,
            );
            hideLoading();
          } else if (state is SaveProjectLatestErrorState) {
            _showMessageDialog(
              message: state.message,
              icon: ImagePaths.error,
            );
            hideLoading();
          }
        },
        builder: (context, state) {
          if (state is ProjectDetailsLoadingState) {
            return const ProjectDetailsSkeleton();
          }
          return Scaffold(
            appBar: buildAppBarWidget(
              context,
              title: _projectDetails.project.projectDisplayName,
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
                    height: 50,
                    isAnotherSpace: false,
                    isLandmarkStatusSaved: _isLandmarkStatusSaved,
                    selectedId: _selectedId,
                    onSortTapped: () => _showSortBottomSheet(context),
                    onLandMarkStatusCleared: (int index) async {
                      setState(() {
                        _isLandmarkStatusSaved = true;
                        _selectedId = -1;
                      });
                      _bloc.add(
                        GetProjectDetailsEvent(
                          projectId: widget.projectId,
                          searchValue: "",
                          draw: "1",
                          skip: _skip,
                          pageSize: _pageSize,
                          isPagination: false,
                        ),
                      );
                      await Future.delayed(const Duration(seconds: 2));
                      setState(() {
                        _isLandmarkStatusSaved = false;
                      });
                    },
                    onLandMarkStatusTapped: (int statusIndex) async {
                      setState(() {
                        _isLandmarkStatusSaved = true;
                      });
                      _selectedId = statusIndex - 1;
                      _searchValue = statusIndex.toString();
                      _bloc.add(GetProjectDetailsEvent(
                        projectId: widget.projectId,
                        searchValue: statusIndex.toString(),
                        draw: "4",
                        skip: _skip,
                        pageSize: _pageSize,
                        isPagination: false,
                      ));
                      await Future.delayed(const Duration(seconds: 2));
                      setState(() {
                        _isLandmarkStatusSaved = false;
                      });
                    },
                    steps: [
                      Steps(id: 0, name: S.of(context).information),
                      Steps(id: 1, name: S.of(context).output),
                      Steps(id: 2, name: S.of(context).landmarks),
                      Steps(id: 3, name: S.of(context).risks),
                      Steps(id: 4, name: S.of(context).challenges),
                      Steps(id: 5, name: S.of(context).compliance),
                      Steps(id: 6, name: S.of(context).workFlowHistory),
                    ],
                    pages: [
                      _buildInformationWidget(),
                      _buildOutputWidget(),
                      _buildLandmarksWidget(),
                      _buildRisksWidget(),
                      _buildChallengesWidget(),
                      _buildComplianceWidget(),
                      TimelineWidget(
                        historyList:
                            _projectDetails.project.workflowHistoryList,
                      ),
                      // _buildNotesWidget(),
                    ],
                    onStepTapped: (int id) {
                      setState(() {
                        _selectedId = id;
                        _skip = 0;
                        _hasMore = true;
                        _isLoadingMore = false;
                      });
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        _bloc.add(GetProjectDetailsEvent(
                          projectId: widget.projectId,
                          searchValue: id == 2 &&
                                  injector<SharedPreferences>()
                                      .containsKey('landmark_status')
                          && injector<SharedPreferences>()
                                      .getInt('landmark_status') != -1
                              ? _searchValue
                              : "",
                          draw: id == 2 &&
                                  injector<SharedPreferences>()
                                      .containsKey('landmark_status')&&
                                      injector<SharedPreferences>()
                                      .getInt('landmark_status') != -1
                              ? "4"
                              : "1",
                          skip: _skip,
                          pageSize: _pageSize,
                          isPagination: true,
                        ));
                      });
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
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
        _bloc.add(
          GetProjectDetailsEvent(
            projectId: widget.projectId,
            searchValue: "",
            draw: "1",
            skip: _skip,
            pageSize: _pageSize,
            isPagination: false,
          ),
        );
      },
    );
  }

  void _showSortBottomSheet(BuildContext context) {
    showSortsBottomSheet(
      context: context,
      isFirst: _isFirst,
      onSortSelected: (value) {
        setState(() {
          _isFirst = false;
        });
      },
    );
  }

  Widget _buildInformationWidget() {
    if (_information.isEmpty) {
      return CustomEmptyListWidget(
        imagePath: ImagePaths.emptyProject,
        text: S.of(context).noRecordFound,
      );
    }
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
                commentController: _commentController,
                errorMessage: _errorMessage,
                onSubmit: (Project information) {
                  _errorMessage = null;
                  _showCommentBottomSheet(
                    context: context,
                    project: information,
                  );
                },
                onTap: (information) {},
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

  void _showCommentBottomSheet({
    required BuildContext context,
    required Project project,
  }) {
    showCommentBottomSheet(
      context: context,
      onSend: (comment) {
        Navigator.pop(context);
        _errorMessage = null;
        _bloc.add(
          SaveProjectLatestEvent(
            requestSaveProjectLatest: RequestSaveProjectLatest(
              id: project.id,
              latestUpdateBrief: comment,
            ),
          ),
        );
        setState(() {});
      },
    );
  }

  Widget _buildOutputWidget() {
    if (_output.isEmpty) {
      return CustomEmptyListWidget(
        imagePath: ImagePaths.emptyProject,
        text: S.of(context).noRecordFound,
      );
    }
    return SingleChildScrollView(
      controller: _outputScrollController,
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
              itemBuilder: (context, index) {
                if (index == _output.length && _hasMore) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 16,
                    ),
                    child: Center(
                      child: SpinKitDoubleBounce(
                        color: ColorSchemes.primary,
                      ),
                    ),
                  );
                }

                return OutPutCardWidget(
                  output: _output[index],
                  onTap: (output) {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => DeliveryDetailsScreen(
                    //       deliverableId: output.id,
                    //       isShowBackButton: true,
                    //     ),
                    //   ),
                    // );
                  },
                );
              },
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemCount: _output.length + (_hasMore ? 1 : 0),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildComplianceWidget() {
    if (_compliance.isEmpty) {
      return CustomEmptyListWidget(
        imagePath: ImagePaths.emptyProject,
        text: S.of(context).noRecordFound,
      );
    }
    return SingleChildScrollView(
      controller: _complianceScrollController,
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
              itemBuilder: (context, index) {
                if (index == _compliance.length && _hasMore) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 16,
                    ),
                    child: Center(
                      child: SpinKitDoubleBounce(
                        color: ColorSchemes.primary,
                      ),
                    ),
                  );
                }

                return ComplinaceCardWidget(
                  compliance: _compliance[index],
                  onTap: (compliance) {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => DeliveryDetailsScreen(
                    //       deliverableId: output.id,
                    //       isShowBackButton: true,
                    //     ),
                    //   ),
                    // );
                  },
                );
              },
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemCount: _compliance.length + (_hasMore ? 1 : 0),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildLandmarksWidget() {
    if (_landmarks.isEmpty) {
      return CustomEmptyListWidget(
        imagePath: ImagePaths.emptyProject,
        text: S.of(context).noRecordFound,
      );
    }
    return SingleChildScrollView(
      controller: _landmarksScrollController,
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
              itemBuilder: (context, index) {
                if (index == _landmarks.length && _hasMore) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 16,
                    ),
                    child: Center(
                      child: SpinKitDoubleBounce(
                        color: ColorSchemes.primary,
                      ),
                    ),
                  );
                }

                return LandmarkCardWidget(
                  landmark: _landmarks[index],
                  onTap: (landmark) {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => MilstoneDetailsScreen(
                    //         milstones: Milstones(
                    //           id: landmark.id,
                    //           name: landmark.name,
                    //           projectCardStatusStr: MilstoneProjectStatusColor(
                    //             color: landmark.projectStatusColor.color,
                    //             label: landmark.projectStatusColor.label,
                    //           ),
                    //           baselineEndDate: landmark.endDateBasicsLine,
                    //           baselineStartDate: landmark.startDateBasicsLine,
                    //           endDate: landmark.endDate,
                    //           startDate: landmark.startDate,
                    //           percentDone: landmark.percentDone,
                    //           project: const MilstoneProject(),
                    //           weight: landmark.weight,
                    //         ),
                    //         isShowBackButton: true,
                    //       ),
                    //     ));
                  },
                );
              },
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemCount: _landmarks.length + (_hasMore ? 1 : 0),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildRisksWidget() {
    if (_risks.isEmpty) {
      return CustomEmptyListWidget(
        imagePath: ImagePaths.emptyProject,
        text: S.of(context).noRecordFound,
      );
    }
    return SingleChildScrollView(
      controller: _risksScrollController,
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
              itemBuilder: (context, index) {
                if (index == _risks.length && _hasMore) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 16,
                    ),
                    child: Center(
                      child: SpinKitDoubleBounce(
                        color: ColorSchemes.primary,
                      ),
                    ),
                  );
                }

                return RisksCardWidget(
                  risks: _risks[index],
                  onTap: (risk) {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => RiskDetailsScreen(
                    //       id: risk.id,
                    //     ),
                    //   ),
                    // );
                  },
                );
              },
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemCount: _risks.length + (_hasMore ? 1 : 0),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildChallengesWidget() {
    if (_challenges.isEmpty) {
      return CustomEmptyListWidget(
        imagePath: ImagePaths.emptyProject,
        text: S.of(context).noRecordFound,
      );
    }
    return SingleChildScrollView(
      controller: _challengesScrollController,
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
              itemBuilder: (context, index) {
                if (index == _challenges.length && _hasMore) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 16,
                    ),
                    child: Center(
                      child: SpinKitDoubleBounce(
                        color: ColorSchemes.primary,
                      ),
                    ),
                  );
                }

                return ChallengesCardWidget(
                  challenge: _challenges[index],
                  onTap: (challenge) {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => ChallengeDetailsScreen(
                    //       id: challenge.id,
                    //     ),
                    //   ),
                    // );
                  },
                );
              },
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemCount: _challenges.length + (_hasMore ? 1 : 0),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class TimelineWidget extends StatelessWidget {
  final List<WorkFlowHistoryList> historyList;

  const TimelineWidget({super.key, required this.historyList});

  @override
  Widget build(BuildContext context) {
    final items =
        historyList.map((e) => TimelineItem.fromWorkFlowHistory(e)).toList();
    if (items.isEmpty) {
      return CustomEmptyListWidget(
        imagePath: ImagePaths.emptyProject,
        text: S.of(context).noRecordFound,
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        return TimeLineItemWidget(
          timeLine: item,
          isLastItem: index == items.length - 1,
        );
      },
    );
  }
}
