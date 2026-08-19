import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/core/base/widget/base_stateful_widget.dart';
import 'package:mofa/src/core/resources/image_paths.dart';
import 'package:mofa/src/core/utils/show_filter_bottom_sheet.dart';
import 'package:mofa/src/core/utils/show_massage_dialog_widget.dart';
import 'package:mofa/src/core/utils/show_sort_bottom_sheet.dart';
import 'package:mofa/src/di/data_layer_injector.dart';
import 'package:mofa/src/domain/entities/home/challenges.dart';
import 'package:mofa/src/domain/entities/shared/filter.dart';
import 'package:mofa/src/domain/entities/shared/sort.dart';
import 'package:mofa/src/domain/usecase/sort/get_sort_challenges_use_case.dart';
import 'package:mofa/src/presentation/blocs/challenges/challenges_bloc.dart';
import 'package:mofa/src/presentation/screens/challenges/challenge_details_screen.dart';
import 'package:mofa/src/presentation/screens/challenges/skeleton/challenge_skeleton.dart';
import 'package:mofa/src/presentation/screens/challenges/widgets/challenges_card_widget.dart';
import 'package:mofa/src/presentation/screens/home/home_screen.dart';
import 'package:mofa/src/presentation/widgets/bell_notification_widget.dart';
import 'package:mofa/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:mofa/src/presentation/widgets/build_options_props_widget.dart';
import 'package:mofa/src/presentation/widgets/custom_empty_list_widget.dart';
import 'package:mofa/src/presentation/widgets/reset_button_widget.dart';
import 'package:mofa/src/presentation/widgets/search_text_field_widget.dart';

class ChallengesScreen extends BaseStatefulWidget {
  final bool isShowBackButton;

  const ChallengesScreen({
    super.key,
    this.isShowBackButton = false,
  });

  @override
  BaseState<ChallengesScreen> baseCreateState() => _ChallengesScreenState();
}

class _ChallengesScreenState extends BaseState<ChallengesScreen> {
  final List<Challenges> _challenges = [];
  final TextEditingController controller = TextEditingController();
  Filter? _filter;
  bool _isShowFilter = false;

  ChallengesBloc get _bloc => BlocProvider.of<ChallengesBloc>(context);
  int _skip = 0;
  final int _pageSize = 10;
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;
  bool _hasMore = true;
  String _sortColumnDirection = "desc";
  String _columnDirection = "descending";

  @override
  void initState() {
    super.initState();
    _bloc.add(GetChallengesEvent(
      pageSize: _pageSize,
      skip: _skip,
      isStart: true,
      columnDirection: _columnDirection,
      sortColumnDirection: _sortColumnDirection,
    ));
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (!_isLoadingMore && _hasMore) {
        _isLoadingMore = true;
        _skip += _pageSize;
        _bloc.add(GetChallengesEvent(
          pageSize: _pageSize,
          skip: _skip,
          departmentId: _filter?.departmentId,
          statusId: _filter?.statusId,
          priorityPriority: -1,
          //_filter?.priorityId,
          isShowFilter: _isShowFilter,
          columnDirection: _columnDirection,
          sortColumnDirection: _sortColumnDirection,
        ));
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<ChallengesBloc, ChallengesState>(
      listener: (context, state) {
        if (state is GetChallengesSuccessState) {
          if (_skip == 0) {
            _challenges.clear();
          }
          _challenges.addAll(state.challenges);
          _isLoadingMore = false;
          _hasMore = state.challenges.length ==
              _pageSize; // أقل من pageSize يعني مفيش بيانات تانية
          hideLoading();
        } else if (state is GetChallengesErrorState) {
          _showMessageDialog(
            message: state.message,
            icon: ImagePaths.warning,
          );
          hideLoading();
        } else if (state is SearchChallengesState) {
          _challenges.clear();
          _challenges.addAll(state.challenges);
        } else if (state is SortChallengesState) {
          _challenges.clear();
          _challenges.addAll(state.challenges);
        } else if (state is FilterChallengesState) {
          _challenges.clear();
          _challenges.addAll(state.challenges);
        }
      },
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async {
            _isShowFilter = false;
            _skip = 0;
            _challenges.clear();
            _isLoadingMore = false;
            _hasMore = true;
            _filter = null;
            _sortColumnDirection = "desc";
            _columnDirection = "descending";
            _bloc.add(GetChallengesEvent(
              pageSize: _pageSize,
              skip: 0,
              isStart: true,
              columnDirection: _columnDirection,
              sortColumnDirection: _sortColumnDirection,
            ));
          },
          child: Scaffold(
            appBar: buildAppBarWidget(
              context,
              title: S.of(context).challenges,
              isHaveBackButton: widget.isShowBackButton,
              centredTitle: !widget.isShowBackButton,
              onBackButtonPressed: () => Navigator.pop(context),
              actionWidget: BellNotificationWidget(
                totalApprovals: totalApprovals,
              ),
            ),
            body: state is GetChallengesLoadingState
                ? const ChallengesSkeleton()
                : SingleChildScrollView(
                    controller: _scrollController,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 12),
                          SearchTextFieldWidget(
                            controller: controller,
                            onChange: (value) {
                              setState(() {
                                controller.text = value;
                              });
                            },
                            onTapSearch: () {
                              _skip = 0;
                              _bloc.add(GetChallengesEvent(
                                pageSize: _pageSize,
                                skip: _skip,
                                isStart: true,
                                searchValue: controller.text,
                                departmentId: _filter?.departmentId,
                                statusId: _filter?.statusId,
                                columnDirection: _columnDirection,
                                sortColumnDirection: _sortColumnDirection,
                              ));
                            },
                            onClear: () {
                              _skip = 0;
                              controller.clear();
                              _bloc.add(GetChallengesEvent(
                                pageSize: _pageSize,
                                skip: _skip,
                                isStart: true,
                                departmentId: _filter?.departmentId,
                                statusId: _filter?.statusId,
                                columnDirection: _columnDirection,
                                sortColumnDirection: _sortColumnDirection,
                              ));
                            },
                            searchText: S.of(context).search,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              if (_challenges.isNotEmpty)
                                BuildOptionsPropsWidget(
                                  title: S.of(context).sort,
                                  image: ImagePaths.icSort,
                                  onTap: () => _showSortBottomSheet(context),
                                ),
                              if (_challenges.isNotEmpty)
                                const SizedBox(width: 12),
                              if (_challenges.isNotEmpty)
                                BuildOptionsPropsWidget(
                                  title: S.of(context).filter,
                                  image: ImagePaths.icFilter,
                                  onTap: () => _showFilterBottomSheet(context),
                                ),
                              const Spacer(),
                              ResetButtonWidget(
                                onTap: () {
                                  _skip = 0;
                                  _isShowFilter = false;
                                  _filter = null;
                                  _sortColumnDirection = "desc";
                                  _columnDirection = "descending";
                                  _bloc.add(GetChallengesEvent(
                                    pageSize: _pageSize,
                                    skip: 0,
                                    isStart: true,
                                    searchValue: "",
                                    searchFilterDefinition: "",
                                    departmentId: "",
                                    statusId: -1,
                                    priorityPriority: -1,
                                    columnDirection: _columnDirection,
                                    sortColumnDirection: _sortColumnDirection,
                                  ));
                                },
                              ),
                            ],
                          ),
                          if (_challenges.isNotEmpty)
                            const SizedBox(height: 32),
                          _challenges.isEmpty
                              ? Center(
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 70),
                                      CustomEmptyListWidget(
                                        imagePath: ImagePaths.emptyProject,
                                        text: S.of(context).noRecordFound,
                                      ),
                                    ],
                                  ),
                                )
                              : Container(
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
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (context, index) {
                                      if (index == _challenges.length &&
                                          _hasMore) {
                                        return const Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 16),
                                          child: Center(
                                            child: SpinKitDoubleBounce(
                                              color: ColorSchemes.primary,
                                            ),
                                          ),
                                        );
                                      }
                                      return ChallengeCardWidget(
                                        challenge: _challenges[index],
                                        onTap: (challenge) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ChallengeDetailsScreen(
                                                id: challenge.id,
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    separatorBuilder: (_, __) =>
                                        const SizedBox(height: 8),
                                    itemCount:
                                        _challenges.length + (_hasMore ? 1 : 0),
                                  ),
                                ),
                          const SizedBox(height: 16),
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

  void _showSortBottomSheet(BuildContext context) async {
    Sort? selectedSort = await GetSortChallengesUseCase(injector())();
    showSortsBottomSheet(
      isFirst: selectedSort != null && selectedSort.id != -1 ? false : true,
      context: context,
      selectedSort:
          selectedSort != null && selectedSort.id != -1 ? selectedSort : null,
      onSortSelected: (Sort value) {
        _bloc.add(GetSortedChallengesEvent(sort: value));
        if (value.id == 1) {
          _sortColumnDirection = "asc";
          _columnDirection = "ascending";
        } else if (value.id == 2) {
          _sortColumnDirection = "desc";
          _columnDirection = "descending";
        } else if (value.id == 3) {
          _sortColumnDirection = "desc";
          _columnDirection = "recentlyAdded";
        } else if (value.id == 4) {
          _sortColumnDirection = "asc";
          _columnDirection = "oldest";
        }
        setState(() {});
        _skip = 0;
        _bloc.add(GetChallengesEvent(
          pageSize: _pageSize,
          skip: 0,
          isStart: true,
          departmentId: _filter?.departmentId,
          statusId: _filter?.statusId,
          isShowFilter: _isShowFilter,
          columnDirection: _columnDirection,
          sortColumnDirection: _sortColumnDirection,
        ));
      },
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showFilterBottomSheet(
      context: context,
      onFilterSelected: (Filter filter) {
        _filter = filter;
        _isShowFilter = true;
        setState(() {});
        _skip = 0;
        setState(() {});
        _bloc.add(GetChallengesEvent(
          pageSize: _pageSize,
          skip: 0,
          isStart: true,
          statusId: filter.statusId,
          departmentId: filter.departmentId,
          isShowFilter: _isShowFilter,
          columnDirection: _columnDirection,
          sortColumnDirection: _sortColumnDirection,
        ));
      },
      onReset: () {
        Navigator.pop(context);
        _filter = null;
        _skip = 0;
        _isShowFilter = false;
        setState(() {});
        _columnDirection = "descending";
        _sortColumnDirection = "desc";
        _bloc.add(GetChallengesEvent(
          pageSize: _pageSize,
          skip: 0,
          searchValue: "",
          searchFilterDefinition: "",
          departmentId: "",
          statusId: -1,
          priorityPriority: -1,
          isStart: true,
          columnDirection: _columnDirection,
          sortColumnDirection: _sortColumnDirection,
        ));
      },
      saveFilter: _filter,
    );
  }
}
