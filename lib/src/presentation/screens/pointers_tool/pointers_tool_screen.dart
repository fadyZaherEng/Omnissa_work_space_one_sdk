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
import 'package:mofa/src/domain/entities/home/pointers_tool.dart';
import 'package:mofa/src/domain/entities/shared/filter.dart';
import 'package:mofa/src/domain/entities/shared/sort.dart';
import 'package:mofa/src/domain/usecase/sort/get_sort_pointers_use_case.dart';
import 'package:mofa/src/presentation/blocs/pointers_tool/pointers_tool_bloc.dart';
import 'package:mofa/src/presentation/screens/home/home_screen.dart';
import 'package:mofa/src/presentation/screens/pointers_tool/skeleton/pointer_skeleton.dart';
import 'package:mofa/src/presentation/screens/pointers_tool/widgets/pointers_card_widget.dart';
import 'package:mofa/src/presentation/widgets/bell_notification_widget.dart';
import 'package:mofa/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:mofa/src/presentation/widgets/build_options_props_widget.dart';
import 'package:mofa/src/presentation/widgets/custom_empty_list_widget.dart';
import 'package:mofa/src/presentation/widgets/reset_button_widget.dart';
import 'package:mofa/src/presentation/widgets/search_text_field_widget.dart';

class PointersToolScreen extends BaseStatefulWidget {
  final bool isShowBackButton;

  const PointersToolScreen({
    super.key,
    this.isShowBackButton = false,
  });

  @override
  BaseState<PointersToolScreen> baseCreateState() => _PointersToolScreenState();
}

class _PointersToolScreenState extends BaseState<PointersToolScreen> {
  final List<PointersTool> _pointers = [];
  final TextEditingController controller = TextEditingController();
  Filter? _filter;
  bool _isFirst = true;

  PointersToolBloc get _bloc => BlocProvider.of<PointersToolBloc>(context);
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
    _bloc.add(GetPointersEvent(
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
        _bloc.add(GetPointersEvent(
          pageSize: _pageSize,
          skip: _skip,
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
    return BlocConsumer<PointersToolBloc, PointersToolState>(
      listener: (context, state) {
        if (state is PointersToolSuccessState) {
          if (_skip == 0) {
            _pointers.clear();
          }
          _pointers.addAll(state.pointers);
          _isLoadingMore = false;
          _hasMore = state.pointers.length ==
              _pageSize; // أقل من pageSize يعني مفيش بيانات تانية
          hideLoading();
        } else if (state is PointersToolErrorState) {
          _showMessageDialog(
            message: state.errorMessage,
            icon: ImagePaths.warning,
          );
          hideLoading();
        } else if (state is SearchPointersToolState) {
          _pointers.clear();
          _pointers.addAll(state.pointers);
        } else if (state is SortPointersToolState) {
          _pointers.clear();
          _pointers.addAll(state.pointers);
        } else if (state is FilterPointersToolState) {
          _pointers.clear();
          _pointers.addAll(state.pointers);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: buildAppBarWidget(
            context,
            title: S.of(context).myPointers,
            isHaveBackButton: widget.isShowBackButton,
            centredTitle: !widget.isShowBackButton,
            onBackButtonPressed: () => Navigator.pop(context),
            actionWidget: BellNotificationWidget(
              totalApprovals: totalApprovals,
            ),
          ),
          body: state is PointersToolLoadingState
              ? const PointersSkeleton()
              : RefreshIndicator(
                  onRefresh: () async {
                    _skip = 0;
                    _pointers.clear();
                    _sortColumnDirection = "desc";
                    _columnDirection = "descending";
                    _bloc.add(GetPointersEvent(
                      pageSize: _pageSize,
                      skip: _skip,
                      isStart: true,
                      sortColumnDirection: _sortColumnDirection,
                      columnDirection: _columnDirection,
                    ));
                  },
                  child: SingleChildScrollView(
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
                              _bloc.add(SearchPointersEvent(value));
                            },
                            onClear: () {
                              controller.clear();
                              _bloc.add(SearchPointersEvent(''));
                            },
                            searchText: S.of(context).search,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              if (_pointers.isNotEmpty)
                                BuildOptionsPropsWidget(
                                  title: S.of(context).sort,
                                  image: ImagePaths.icSort,
                                  onTap: () => _showSortBottomSheet(context),
                                ),
                              if (_pointers.isNotEmpty)
                                const SizedBox(width: 12),
                              if (_pointers.isNotEmpty)
                                BuildOptionsPropsWidget(
                                  title: S.of(context).filter,
                                  image: ImagePaths.icFilter,
                                  onTap: () => _showFilterBottomSheet(context),
                                ),
                              const Spacer(),
                              ResetButtonWidget(
                                onTap: () {
                                  _filter = null;
                                  _skip = 0;
                                  _sortColumnDirection = "desc";
                                  _columnDirection = "descending";
                                  _bloc.add(GetPointersEvent(
                                    pageSize: _pageSize,
                                    skip: _skip,
                                    isStart: true,
                                    sortColumnDirection: _sortColumnDirection,
                                    columnDirection: _columnDirection,
                                  ));
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),
                          _pointers.isEmpty
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
                                      if (index == _pointers.length &&
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

                                      return PointersCardWidget(
                                        pointer: _pointers[index],
                                        onTap: (project) {},
                                      );
                                    },
                                    separatorBuilder: (_, __) =>
                                        const SizedBox(height: 8),
                                    itemCount:
                                        _pointers.length + (_hasMore ? 1 : 0),
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
    Sort? selectedSort = await GetSortPointersUseCase(injector())();

    showSortsBottomSheet(
      context: context,
      isFirst: _isFirst,
      selectedSort:
          selectedSort != null && selectedSort.id != -1 ? selectedSort : null,
      onSortSelected: (value) {
        _bloc.add(
          GetSortedPointersToolEvent(sort: value),
        );
        _isFirst = false;
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
        _bloc.add(GetPointersEvent(
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
      onFilterSelected: (Filter filter) {
        _filter = filter;
        _bloc.add(FilterPointersToolEvent(filter: filter));
      },
      onReset: () {
        Navigator.pop(context);
        _filter = null;
        _skip = 0;
        _sortColumnDirection = "desc";
        _columnDirection = "descending";
        _bloc.add(GetPointersEvent(
          pageSize: _pageSize,
          skip: 0,
          isStart: true,
          sortColumnDirection: _sortColumnDirection,
          columnDirection: _columnDirection,
        ));
      },
      saveFilter: _filter,
    );
  }
}
