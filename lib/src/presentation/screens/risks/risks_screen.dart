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
import 'package:mofa/src/domain/entities/home/risks.dart';
import 'package:mofa/src/domain/entities/shared/filter.dart';
import 'package:mofa/src/domain/entities/shared/sort.dart';
import 'package:mofa/src/domain/usecase/sort/get_sort_risks_use_case.dart';
import 'package:mofa/src/presentation/blocs/risks/risks_bloc.dart';
import 'package:mofa/src/presentation/screens/home/home_screen.dart';
import 'package:mofa/src/presentation/screens/risks/risk_details_screen.dart';
import 'package:mofa/src/presentation/screens/risks/skeleton/risks_skeleton.dart';
import 'package:mofa/src/presentation/screens/risks/widgets/risks_card_widget.dart';
import 'package:mofa/src/presentation/widgets/bell_notification_widget.dart';
import 'package:mofa/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:mofa/src/presentation/widgets/build_options_props_widget.dart';
import 'package:mofa/src/presentation/widgets/custom_empty_list_widget.dart';
import 'package:mofa/src/presentation/widgets/reset_button_widget.dart';
import 'package:mofa/src/presentation/widgets/search_text_field_widget.dart';

class RisksScreen extends BaseStatefulWidget {
  final bool isShowBackButton;

  const RisksScreen({
    super.key,
    this.isShowBackButton = false,
  });

  @override
  BaseState<RisksScreen> baseCreateState() => _RisksScreenState();
}

class _RisksScreenState extends BaseState<RisksScreen> {
  final List<Risks> _risks = [];
  final TextEditingController controller = TextEditingController();
  Filter? _filter;
  bool _isShowFilter = false;

  RisksBloc get _bloc => BlocProvider.of<RisksBloc>(context);
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
    _bloc.add(GetRisksEvent(
      pageSize: _pageSize,
      skip: _skip,
      isStart: true,
      sortColumnDirection: _sortColumnDirection,
      columnDirection: _columnDirection,
    ));
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (!_isLoadingMore && _hasMore) {
        _isLoadingMore = true;
        _skip += _pageSize;
        _bloc.add(GetRisksEvent(
          pageSize: _pageSize,
          skip: _skip,
          departmentId: _filter?.departmentId,
          statusId: _filter?.statusId,
          priorityPriority: -1,
          isShowFilter: _isShowFilter,
          sortColumnDirection: _sortColumnDirection,
          columnDirection: _columnDirection,
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
    return RefreshIndicator(
      onRefresh: () async {
        _skip = 0;
        _risks.clear();
        _isLoadingMore = false;
        _hasMore = true;
        _filter = null;
        _isShowFilter = false;
        _sortColumnDirection = "desc";
        _columnDirection = "descending";
        _bloc.add(GetRisksEvent(
          pageSize: _pageSize,
          skip: _skip,
          isStart: true,
          sortColumnDirection: _sortColumnDirection,
          columnDirection: _columnDirection,
        ));
      },
      child: BlocConsumer<RisksBloc, RisksState>(
        listener: (context, state) {
          if (state is GetRisksSuccessState) {
            if (_skip == 0) {
              _risks.clear();
            }
            _risks.addAll(state.risks);
            _isLoadingMore = false;
            _hasMore = state.risks.length ==
                _pageSize; // أقل من pageSize يعني مفيش بيانات تانية
            hideLoading();
          } else if (state is GetRisksErrorState) {
            _showMessageDialog(
              message: state.errorMessage,
              icon: ImagePaths.warning,
            );
            hideLoading();
          } else if (state is SortRisksState) {
            _risks.clear();
            _risks.addAll(state.milstones);
            hideLoading();
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: buildAppBarWidget(
              context,
              title: S.of(context).risks,
              isHaveBackButton: widget.isShowBackButton,
              centredTitle: !widget.isShowBackButton,
              onBackButtonPressed: () => Navigator.pop(context),
              actionWidget: BellNotificationWidget(
                totalApprovals: totalApprovals,
              ),
            ),
            body: state is GetRisksLoadingState
                ? const RisksSkeleton()
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
                              _bloc.add(GetRisksEvent(
                                pageSize: _pageSize,
                                skip: _skip,
                                isStart: true,
                                searchValue: controller.text,
                                departmentId: _filter?.departmentId,
                                statusId: _filter?.statusId,
                                sortColumnDirection: _sortColumnDirection,
                                columnDirection: _columnDirection,
                              ));
                            },
                            onClear: () {
                              _skip = 0;
                              controller.clear();
                              _bloc.add(GetRisksEvent(
                                pageSize: _pageSize,
                                skip: _skip,
                                isStart: true,
                                departmentId: _filter?.departmentId,
                                statusId: _filter?.statusId,
                                sortColumnDirection: _sortColumnDirection,
                                columnDirection: _columnDirection,
                              ));
                            },
                            searchText: S.of(context).search,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              BuildOptionsPropsWidget(
                                title: S.of(context).sort,
                                image: ImagePaths.icSort,
                                onTap: () => _showSortBottomSheet(context),
                              ),
                              const SizedBox(width: 12),
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
                                  _bloc.add(GetRisksEvent(
                                    pageSize: _pageSize,
                                    skip: _skip,
                                    isStart: true,
                                    searchValue: "",
                                    searchFilterDefinition: "",
                                    departmentId: "",
                                    statusId: -1,
                                    priorityPriority: -1,
                                    sortColumnDirection: _sortColumnDirection,
                                    columnDirection: _columnDirection,
                                  ));
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),
                          _risks.isEmpty
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
                                      if (index == _risks.length && _hasMore) {
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

                                      return RisksCardWidget(
                                        risk: _risks[index],
                                        onTap: (risk) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  RiskDetailsScreen(
                                                id: risk.id,
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    separatorBuilder: (_, __) =>
                                        const SizedBox(height: 8),
                                    itemCount:
                                        _risks.length + (_hasMore ? 1 : 0),
                                  ),
                                ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
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
      onTap: () => Navigator.pop(context),
    );
  }

  void _showSortBottomSheet(BuildContext context) async {
    Sort? selectedSort = await GetSortRisksUseCase(injector())();

    showSortsBottomSheet(
      context: context,
      isFirst: selectedSort != null && selectedSort.id != -1 ? false : true,
      onSortSelected: (value) {
        _bloc.add(GetSortedRiskEvent(sort: value));
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
        _bloc.add(GetRisksEvent(
          pageSize: _pageSize,
          skip: _skip,
          isStart: true,
          sortColumnDirection: _sortColumnDirection,
          columnDirection: _columnDirection,
        ));
      },
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showFilterBottomSheet(
      context: context,
      saveFilter: _filter,
      onFilterSelected: (Filter value) {
        _filter = value;
        _isShowFilter = true;
        setState(() {});
        _skip = 0;
        setState(() {});
        _bloc.add(GetRisksEvent(
          pageSize: _pageSize,
          skip: 0,
          isStart: true,
          statusId: value.statusId,
          departmentId: value.departmentId,
          isShowFilter: _isShowFilter,
          sortColumnDirection: _sortColumnDirection,
          columnDirection: _columnDirection,
        ));
      },
      onReset: () {
        Navigator.pop(context);
        _filter = null;
        _isShowFilter = false;
        setState(() {});
        _skip = 0;
        _sortColumnDirection = "desc";
        _columnDirection = "descending";
        _bloc.add(GetRisksEvent(
          pageSize: _pageSize,
          skip: 0,
          searchValue: "",
          searchFilterDefinition: "",
          departmentId: "",
          statusId: -1,
          priorityPriority: -1,
          isStart: true,
          sortColumnDirection: _sortColumnDirection,
          columnDirection: _columnDirection,
        ));
      },
    );
  }
}
