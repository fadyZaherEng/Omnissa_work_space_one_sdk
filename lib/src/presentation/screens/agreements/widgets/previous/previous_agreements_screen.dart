import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/core/base/widget/base_stateful_widget.dart';
import 'package:mofa/src/core/resources/image_paths.dart';
import 'package:mofa/src/core/utils/format_date.dart';
import 'package:mofa/src/core/utils/show_comment_bottom_sheet.dart';
import 'package:mofa/src/core/utils/show_filter_bottom_sheet.dart';
import 'package:mofa/src/core/utils/show_massage_dialog_widget.dart';
import 'package:mofa/src/core/utils/show_sort_bottom_sheet.dart';
import 'package:mofa/src/data/sources/remote/mofa/more/request/request_task_update.dart';
import 'package:mofa/src/di/data_layer_injector.dart';
import 'package:mofa/src/domain/entities/home/task_update_approval.dart';
import 'package:mofa/src/domain/entities/shared/filter.dart';
import 'package:mofa/src/domain/entities/shared/sort.dart';
import 'package:mofa/src/domain/usecase/sort/get_sort_agreement_use_case.dart';
import 'package:mofa/src/presentation/blocs/agreements/agreements_bloc.dart';
import 'package:mofa/src/presentation/screens/agreements/skeleton/agreements_skeleton.dart';
import 'package:mofa/src/presentation/screens/agreements/widgets/previous/agreements_previous_card_widget.dart';
import 'package:mofa/src/presentation/widgets/build_options_props_widget.dart';
import 'package:mofa/src/presentation/widgets/custom_empty_list_widget.dart';
import 'package:mofa/src/presentation/widgets/reset_button_widget.dart';
import 'package:mofa/src/presentation/widgets/search_text_field_widget.dart';

class PreviousAgreementsScreen extends BaseStatefulWidget {
  const PreviousAgreementsScreen({super.key});

  @override
  BaseState<PreviousAgreementsScreen> baseCreateState() =>
      _AgreementsScreenState();
}

class _AgreementsScreenState extends BaseState<PreviousAgreementsScreen>
    with SingleTickerProviderStateMixin {
  final List<TaskUpdateApproval> _agreements = [];
  final TextEditingController controller = TextEditingController();

  AgreementBloc get _bloc => BlocProvider.of<AgreementBloc>(context);
  Filter? _filter;
  int _skip = 0;
  final int _pageSize = 10;
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;
  bool _hasMore = true;
  late TabController _tabController;
  bool _isShowFilter = false;
  String _sortColumnDirection = "desc";
  String _columnDirection = "descending";

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.index = 0;
    super.initState();
    _bloc.add(GetPreviousAgreementsEvent(
      pageSize: _pageSize,
      skip: _skip,
      isStart: true,
      departmentId: _filter?.departmentId,
      statusId: _filter?.statusId,
      priorityPriority: -1,
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
        _bloc.add(GetPreviousAgreementsEvent(
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
    return BlocConsumer<AgreementBloc, AgreementState>(
      listener: (context, state) {
        if (state is GetPreviousAgreementSuccessState) {
          _agreements.clear();
          _agreements.addAll(state.agreements);
          hideLoading();
        } else if (state is GetPreviousAgreementErrorState) {
          _showMessageDialog(
            message: state.errorMessage,
            icon: ImagePaths.warning,
          );
          hideLoading();
        } else if (state is SearchPreviousAgreementState) {
          if (_skip == 0) {
            _agreements.clear();
          }
          _agreements.addAll(state.agreements);
          _isLoadingMore = false;
          _hasMore = state.agreements.length ==
              _pageSize; // أقل من pageSize يعني مفيش بيانات تانية
        } else if (state is SortPreviousAgreementState) {
          _agreements.clear();
          _agreements.addAll(state.agreements);
        } else if (state is FilterPreviousAgreementsState) {
          _agreements.clear();
          _agreements.addAll(state.agreements);
        } else if (state is HandleTaskUpdateApprovalSuccessState) {
          _showMessageDialog(
            message: state.message,
            icon: ImagePaths.success,
          );
        } else if (state is HandleTaskUpdateApprovalErrorState) {
          _showMessageDialog(
            message: state.errorMessage,
            icon: ImagePaths.warning,
          );
        }
      },
      builder: (context, state) {
        return _assignmentsWidget(state);
      },
    );
  }

  Widget _assignmentsWidget(state, {bool isDetails = false}) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          _isShowFilter = false;
          _skip = 0;
          _agreements.clear();
          _isLoadingMore = false;
          _hasMore = true;
          _filter = null;
          _sortColumnDirection = "desc";
          _columnDirection = "descending";
          _bloc.add(GetPreviousAgreementsEvent(
            pageSize: _pageSize,
            skip: 0,
            isStart: true,
            columnDirection: _columnDirection,
            sortColumnDirection: _sortColumnDirection,
          ));
        },
        child: Scaffold(
          body: state is GetPreviousAgreementsLoadingState
              ? const AgreementsSkeleton()
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
                            _bloc.add(GetPreviousAgreementsEvent(
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
                            _bloc.add(GetPreviousAgreementsEvent(
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
                            if (_agreements.isNotEmpty)
                              BuildOptionsPropsWidget(
                                title: S.of(context).sort,
                                image: ImagePaths.icSort,
                                onTap: () => _showSortBottomSheet(context),
                              ),
                            if (_agreements.isNotEmpty)
                              const SizedBox(width: 12),
                            // BuildOptionsPropsWidget(
                            //   title: S.of(context).filter,
                            //   image: ImagePaths.icFilter,
                            //   onTap: () => _showFilterBottomSheet(context),
                            // ),
                            const Spacer(),
                            ResetButtonWidget(
                              onTap: () {
                                _skip = 0;
                                _sortColumnDirection = "desc";
                                _columnDirection = "descending";
                                _bloc.add(GetPreviousAgreementsEvent(
                                  pageSize: _pageSize,
                                  skip: _skip,
                                  isStart: true,
                                  columnDirection: _columnDirection,
                                  sortColumnDirection: _sortColumnDirection,
                                ));
                              },
                            ),
                          ],
                        ),
                        if (_agreements.isNotEmpty) const SizedBox(height: 32),
                        _agreements.isEmpty
                            ? Center(
                                child: InkWell(
                                  onTap: () => _bloc.add(
                                    GetPreviousAgreementsEvent(
                                      pageSize: _pageSize,
                                      skip: 0,
                                      columnDirection: _columnDirection,
                                      sortColumnDirection: _sortColumnDirection,
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 70),
                                      CustomEmptyListWidget(
                                        imagePath: ImagePaths.emptyProject,
                                        text: S.of(context).noRecordFound,
                                      ),
                                    ],
                                  ),
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
                                  physics: const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    if (index == _agreements.length &&
                                        _hasMore) {
                                      return const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 16),
                                        child: Center(
                                          child: SpinKitDoubleBounce(
                                            color: ColorSchemes.primary,
                                          ),
                                        ),
                                      );
                                    }
                                    if (isDetails) {
                                      return _detailsWidget(_agreements[index]);
                                    }
                                    return AgreementsPreviousCardWidget(
                                      agreement: _agreements[index],
                                      onTap: (agreement) {},
                                      onAcceptTap: (agreement) {
                                        _showCommentBottomSheet(
                                          request: RequestTaskUpdate(
                                            comment: "",
                                            isApproved: true,
                                            taskId: agreement.taskId,
                                            recordId: agreement.requestId,
                                            wfTaskId: agreement.id,
                                          ),
                                          context: context,
                                          actionType: "approved",
                                        );
                                      },
                                      onDeclineTap: (agreement) {
                                        _showCommentBottomSheet(
                                          request: RequestTaskUpdate(
                                            comment: "",
                                            isApproved: false,
                                            taskId: agreement.taskId,
                                            recordId: agreement.requestId,
                                            wfTaskId: agreement.id,
                                          ),
                                          context: context,
                                          actionType: "declined",
                                        );
                                      },
                                    );
                                  },
                                  separatorBuilder: (_, __) =>
                                      const SizedBox(height: 8),
                                  itemCount:
                                      _agreements.length + (_hasMore ? 1 : 0),
                                ),
                              ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
        ),
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
    Sort? selectedSort = await GetSortAgreementUseCase(injector())();
    showSortsBottomSheet(
      context: context,
      isFirst: selectedSort != null && selectedSort.id != -1 ? false : true,
      selectedSort:
          selectedSort != null && selectedSort.id != -1 ? selectedSort : null,
      onSortSelected: (Sort value) {
        _bloc.add(GetSortedPreviousAgreementsEvent(sort: value));
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
        _bloc.add(GetPreviousAgreementsEvent(
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
        _bloc.add(GetPreviousAgreementsEvent(
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
        _bloc.add(GetPreviousAgreementsEvent(
          pageSize: _pageSize,
          skip: 0,
          isStart: true,
          columnDirection: _columnDirection,
          sortColumnDirection: _sortColumnDirection,
        ));
      },
      saveFilter: _filter,
    );
  }

  void _showCommentBottomSheet({
    required BuildContext context,
    required RequestTaskUpdate request,
    required String actionType,
  }) {
    showCommentBottomSheet(
      context: context,
      onSend: (comment) {
        Navigator.pop(context);
        _bloc.add(
          HandleTaskUpdateApproval(
            request: RequestTaskUpdate(
              taskId: request.taskId,
              wfTaskId: request.wfTaskId,
              recordId: request.recordId,
              comment: comment,
              isApproved: request.isApproved,
            ),
            actionType: actionType,
          ),
        );
      },
    );
  }

  Widget _detailsWidget(TaskUpdateApproval task) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorSchemes.border, width: 0.75),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabeledValue(context, S.of(context).taskName, task.taskName),
          _buildLabeledValue(
              context, S.of(context).taskDescription, task.assignmentComments),
          _buildLabeledValue(context, S.of(context).status, task.taskStatusStr),
          _buildLabeledValue(
              context, S.of(context).startDate, formatDate(task.taskStartDate)),
          _buildLabeledValue(
              context, S.of(context).endDate, formatDate(task.taskEndDate)),
          _buildLabeledValue(
              context, S.of(context).projectPriority, task.taskPriorityStr),
          const SizedBox(height: 12),
          // _buildLabeledValue(context, S.of(context).completionPercentage, "${task.completionPercent}%"),
          // _buildLabeledValue(context, S.of(context).notes, task.notes ?? "-"),
        ],
      ),
    );
  }

  Widget _buildLabeledValue(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: ColorSchemes.gray,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(width: 16),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: ColorSchemes.black,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }
}
