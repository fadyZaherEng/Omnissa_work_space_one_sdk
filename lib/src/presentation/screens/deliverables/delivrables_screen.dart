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
import 'package:mofa/src/domain/entities/home/deliverables.dart';
import 'package:mofa/src/domain/entities/shared/filter.dart';
import 'package:mofa/src/domain/entities/shared/sort.dart';
import 'package:mofa/src/domain/usecase/sort/get_sort_deliverables_use_case.dart';
import 'package:mofa/src/presentation/blocs/deliverables/delivrables_bloc.dart';
import 'package:mofa/src/presentation/blocs/deliverables/delivrables_event.dart';
import 'package:mofa/src/presentation/blocs/deliverables/delivrables_state.dart';
import 'package:mofa/src/presentation/screens/deliverables/delivery_details_screen.dart';
import 'package:mofa/src/presentation/screens/deliverables/widgets/delivrables_card_widget.dart';
import 'package:mofa/src/presentation/screens/home/home_screen.dart';
import 'package:mofa/src/presentation/screens/pointers_tool/skeleton/pointer_skeleton.dart';
import 'package:mofa/src/presentation/widgets/bell_notification_widget.dart';
import 'package:mofa/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:mofa/src/presentation/widgets/build_options_props_widget.dart';
import 'package:mofa/src/presentation/widgets/custom_empty_list_widget.dart';
import 'package:mofa/src/presentation/widgets/reset_button_widget.dart';
import 'package:mofa/src/presentation/widgets/search_text_field_widget.dart';

class DeliverablesScreen extends BaseStatefulWidget {
  final bool isShowBackButton;

  const DeliverablesScreen({
    super.key,
    this.isShowBackButton = false,
  });

  @override
  BaseState<DeliverablesScreen> baseCreateState() => _DeliverablesScreenState();
}

class _DeliverablesScreenState extends BaseState<DeliverablesScreen> {
  final List<Deliverbles> _deliverables = [];
  final TextEditingController controller = TextEditingController();
  Filter? _filter;
  bool _isShowFilter = false;

  DelivrablesBloc get _bloc => BlocProvider.of<DelivrablesBloc>(context);
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
    _bloc.add(GetDelivrablesEvent(
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
        _bloc.add(GetDelivrablesEvent(
          pageSize: _pageSize,
          skip: _skip,
          departmentId: _filter?.departmentId ?? "",
          statusId: _filter?.statusId ?? -1,
          assignTo: "",
          // _filter?.assignTo ?? "",
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
    return RefreshIndicator(
      onRefresh: () async {
        _deliverables.clear();
        _skip = 0;
        _isShowFilter = false;
        _sortColumnDirection = "desc";
        _columnDirection = "descending";
        _bloc.add(GetDelivrablesEvent(
          pageSize: _pageSize,
          skip: _skip,
          isStart: true,
          departmentId: "",
          searchValue: "",
          searchFilterDefinition: "",
          statusId: -1,
          assignTo: "",
          columnDirection: _columnDirection,
          sortColumnDirection: _sortColumnDirection,
        ));
        _isLoadingMore = false;
        _hasMore = true;
        _filter = null;
      },
      child: BlocConsumer<DelivrablesBloc, DelivrablesState>(
        listener: (context, state) {
          if (state is GetDelivrablesSuccessState) {
            if (_skip == 0) {
              _deliverables.clear();
            }
            _deliverables.addAll(state.delivrables);
            _isLoadingMore = false;
            _hasMore = state.delivrables.length ==
                _pageSize; // أقل من pageSize يعني مفيش بيانات تانية
            hideLoading();

          } else if (state is GetDelivrablesErrorState) {
            _showMessageDialog(
              message: state.errorMessage,
              icon: ImagePaths.warning,
            );
            hideLoading();

          } else if (state is SearchDelivrablesSuccessState) {
            if (_skip == 0) {
              _deliverables.clear();
            }
            _deliverables.addAll(state.delivrables);
            _isLoadingMore = false;
            _hasMore = state.delivrables.length ==
                _pageSize; // أقل من pageSize يعني مفيش بيانات تانية
          } else if (state is SortDelivrablesState) {
            _deliverables.clear();
            _deliverables.addAll(state.delivrables);
          } else if (state is FilterDelivrablesState) {
            _deliverables.clear();
            _deliverables.addAll(state.delivrables);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: buildAppBarWidget(
              context,
              title: S.of(context).deliverables,
              isHaveBackButton: true,
              centredTitle: true,
              onBackButtonPressed: () => Navigator.pop(context),
              actionWidget: BellNotificationWidget(
                totalApprovals: totalApprovals,
              ),
            ),
            body: state is GetDelivrablesLoadingState
                ? const PointersSkeleton()
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
                              _bloc.add(GetDelivrablesEvent(
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
                              _bloc.add(GetDelivrablesEvent(
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
                              if (_deliverables.isNotEmpty)
                                BuildOptionsPropsWidget(
                                  title: S.of(context).sort,
                                  image: ImagePaths.icSort,
                                  onTap: () => _showSortBottomSheet(context),
                                ),
                              if (_deliverables.isNotEmpty)
                                const SizedBox(width: 12),
                              if (_deliverables.isNotEmpty)
                                BuildOptionsPropsWidget(
                                  title: S.of(context).filter,
                                  image: ImagePaths.icFilter,
                                  onTap: () => _showFilterBottomSheet(context),
                                ),
                              const Spacer(),
                              ResetButtonWidget(
                                onTap: () {
                                  _sortColumnDirection = "desc";
                                  _columnDirection = "descending";
                                  _skip = 0;
                                  _isShowFilter = false;
                                  _filter = null;
                                  _bloc.add(GetDelivrablesEvent(
                                    pageSize: _pageSize,
                                    skip: 0,
                                    isStart: true,
                                    searchValue: "",
                                    searchFilterDefinition: "",
                                    departmentId: "",
                                    statusId: -1,
                                    assignTo: "",
                                    columnDirection: _columnDirection,
                                    sortColumnDirection: _sortColumnDirection,
                                  ));
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),
                          _deliverables.isEmpty
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
                                      if (index == _deliverables.length &&
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

                                      return DelivrableCardWidget(
                                        deliverables: _deliverables[index],
                                        onTap: (deliverables) {
                                          _bloc.add(
                                            GetDeliverableInfoEvent(
                                              id: deliverables.id,
                                            ),
                                          );
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DeliveryDetailsScreen(
                                                deliverableId: deliverables.id,
                                                isShowBackButton: true,
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    separatorBuilder: (_, __) =>
                                        const SizedBox(height: 8),
                                    itemCount: _deliverables.length +
                                        (_hasMore ? 1 : 0),
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
    Sort? selectedSort = await GetSortDeliverablesUseCase(injector())();

    showSortsBottomSheet(
      context: context,
      isFirst: selectedSort != null && selectedSort.id != -1 ? false : true,
      selectedSort:
          selectedSort != null && selectedSort.id != -1 ? selectedSort : null,
      onSortSelected: (value) {
        _bloc.add(
          GetSortedDelivrablesEvent(
            sort: value,
          ),
        );
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
        _bloc.add(GetDelivrablesEvent(
          pageSize: _pageSize,
          skip: 0,
          isStart: true,
          departmentId: _filter?.departmentId ?? "",
          statusId: _filter?.statusId ?? -1,
          assignTo: "",
          // _filter?.assignTo ?? "",
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
        _bloc.add(GetDelivrablesEvent(
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
        _bloc.add(GetDelivrablesEvent(
          pageSize: _pageSize,
          skip: 0,
          searchValue: "",
          searchFilterDefinition: "",
          departmentId: "",
          statusId: -1,
          assignTo: "",
          isStart: true,
          isShowFilter: _isShowFilter,
          columnDirection: _columnDirection,
          sortColumnDirection: _sortColumnDirection,
        ));
      },
      saveFilter: _filter,
    );
  }
}
