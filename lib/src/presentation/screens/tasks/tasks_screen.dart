import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/core/base/widget/base_stateful_widget.dart';
import 'package:mofa/src/core/resources/image_paths.dart';
import 'package:mofa/src/core/utils/show_Task_updates_bottom_sheet.dart';
import 'package:mofa/src/core/utils/show_filter_bottom_sheet.dart';
import 'package:mofa/src/core/utils/show_massage_dialog_widget.dart';
import 'package:mofa/src/core/utils/show_sort_bottom_sheet.dart';
import 'package:mofa/src/data/sources/remote/mofa/more/request/request_update_tasks.dart';
import 'package:mofa/src/di/data_layer_injector.dart';
import 'package:mofa/src/domain/entities/home/task.dart';
import 'package:mofa/src/domain/entities/home/task_enum.dart';
import 'package:mofa/src/domain/entities/shared/filter.dart';
import 'package:mofa/src/domain/entities/shared/sort.dart';
import 'package:mofa/src/domain/usecase/sort/get_sort_tasks_use_case.dart';
import 'package:mofa/src/presentation/blocs/tasks/tasks_bloc.dart';
import 'package:mofa/src/presentation/screens/home/home_screen.dart';
import 'package:mofa/src/presentation/screens/pointers_tool/skeleton/pointer_skeleton.dart';
import 'package:mofa/src/presentation/screens/tasks/widgets/task_details_screen.dart';
import 'package:mofa/src/presentation/screens/tasks/widgets/task_card_widget.dart';
import 'package:mofa/src/presentation/widgets/bell_notification_widget.dart';
import 'package:mofa/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:mofa/src/presentation/widgets/build_options_props_widget.dart';
import 'package:mofa/src/presentation/widgets/custom_empty_list_widget.dart';
import 'package:mofa/src/presentation/widgets/reset_button_widget.dart';
import 'package:mofa/src/presentation/widgets/search_text_field_widget.dart';

class TasksScreen extends BaseStatefulWidget {
  final bool isShowBackButton;

  const TasksScreen({
    super.key,
    this.isShowBackButton = false,
  });

  @override
  BaseState<TasksScreen> baseCreateState() => _TasksScreenState();
}

class _TasksScreenState extends BaseState<TasksScreen> {
  final List<Task> _tasks = [];
  final TextEditingController controller = TextEditingController();
  Filter? _filter;

  TasksBloc get _bloc => BlocProvider.of<TasksBloc>(context);
  final List<TaskBoardEnum> _taskStatus = [];
  final List<TaskBoardEnum> _taskPriority = [];
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
    _bloc.add(GetTasksEvent(
      pageSize: _pageSize,
      skip: _skip,
      isStart: true,
      searchValue: '',
      searchFilterDefination: '',
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
        _bloc.add(GetTasksEvent(
          pageSize: _pageSize,
          skip: _skip,
          searchValue: controller.text,
          searchFilterDefination: "",
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
        _sortColumnDirection = "desc";
        _columnDirection = "descending";
        _bloc.add(GetTasksEvent(
          pageSize: _pageSize,
          skip: _skip,
          isStart: true,
          searchValue: "",
          searchFilterDefination: "",
          sortColumnDirection: _sortColumnDirection,
          columnDirection: _columnDirection,
        ));
      },
      child: BlocConsumer<TasksBloc, TasksState>(
        listener: (context, state) {
          if (state is GetTasksSuccessState) {
            if (_skip == 0) {
              _tasks.clear();
            }
            _tasks.addAll(state.tasks);
            _isLoadingMore = false;
            _hasMore = state.tasks.length ==
                _pageSize; // أقل من pageSize يعني مفيش بيانات تانية
            hideLoading();

            if (state.taskPriority.isNotEmpty) {
              _taskPriority.clear();
              _taskPriority.addAll(state.taskPriority);
            }
            if (state.taskStatus.isNotEmpty) {
              _taskStatus.clear();
              _taskStatus.addAll(state.taskStatus);
            }
          } else if (state is GetTasksErrorState) {
            _showMessageDialog(
              message: state.errorMessage,
              icon: ImagePaths.warning,
            );
            hideLoading();
          } else if (state is SearchTasksSuccessState) {
            _tasks.clear();
            _tasks.addAll(state.tasks);
          } else if (state is SortTasksState) {
            _tasks.clear();
            _tasks.addAll(state.tasks);
          } else if (state is FilterTasksState) {
            _tasks.clear();
            _tasks.addAll(state.tasks);
          } else if (state is TaskUpdatesSuccessState) {
            _showMessageDialog(
              message: state.message,
              icon: ImagePaths.success,
            );
          } else if (state is TaskUpdatesErrorState) {
            _showMessageDialog(
              message: state.errorMessage,
              icon: ImagePaths.warning,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: buildAppBarWidget(
              context,
              title: S.of(context).tasks,
              isHaveBackButton: widget.isShowBackButton,
              centredTitle: !widget.isShowBackButton,
              onBackButtonPressed: () => Navigator.pop(context),
              actionWidget: BellNotificationWidget(
                totalApprovals: totalApprovals,
              ),
            ),
            body: state is GetTasksLoadingState
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
                              _bloc.add(GetTasksEvent(
                                pageSize: _pageSize,
                                skip: _skip,
                                isStart: true,
                                searchValue: controller.text,
                                searchFilterDefination: "",
                                sortColumnDirection: _sortColumnDirection,
                                columnDirection: _columnDirection,
                              ));
                            },
                            onClear: () {
                              _skip = 0;
                              controller.clear();
                              _bloc.add(GetTasksEvent(
                                pageSize: _pageSize,
                                skip: _skip,
                                isStart: true,
                                searchValue: "",
                                searchFilterDefination: "",
                                sortColumnDirection: _sortColumnDirection,
                                columnDirection: _columnDirection,
                              ));
                            },
                            searchText: S.of(context).search,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              if (_tasks.isNotEmpty)
                                BuildOptionsPropsWidget(
                                  title: S.of(context).sort,
                                  image: ImagePaths.icSort,
                                  onTap: () => _showSortBottomSheet(context),
                                ),
                              // const SizedBox(width: 12),
                              // BuildOptionsPropsWidget(
                              //   title: S.of(context).filter,
                              //   image: ImagePaths.icFilter,
                              //   onTap: () => _showFilterBottomSheet(context),
                              // ),
                              // const Spacer(),
                              // ResetButtonWidget(
                              //   onTap: () {
                              //     _filter = null;
                              //     _skip = 0;
                              //     _sortColumnDirection = "desc";
                              //     _columnDirection = "descending";
                              //     _bloc.add(GetTasksEvent(
                              //       skip: _skip,
                              //       pageSize: _pageSize,
                              //       isStart: true,
                              //       searchValue: '',
                              //       searchFilterDefination: '',
                              //       sortColumnDirection: _sortColumnDirection,
                              //       columnDirection: _columnDirection,
                              //     ));
                              //   },
                              // ),
                            ],
                          ),
                          const SizedBox(height: 32),
                          _tasks.isEmpty
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
                                      if (index == _tasks.length && _hasMore) {
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
                                      return TaskCardWidget(
                                        tasks: _tasks[index],
                                        onTap: (task) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  TaskDetailsScreen(
                                                task: task,
                                                taskStatus: _taskStatus,
                                              ),
                                            ),
                                          ).then((value) {
                                            _skip = 0;
                                            _bloc.add(GetTasksEvent(
                                              pageSize: _pageSize,
                                              skip: _skip,
                                              isStart: true,
                                              searchValue: "",
                                              searchFilterDefination: "",
                                              sortColumnDirection:
                                                  _sortColumnDirection,
                                              columnDirection: _columnDirection,
                                            ));
                                          });
                                        },
                                        submitBottomSheet:
                                            (bool isSubmit, Task task) {
                                          _submitTaskUpdate(
                                            task: task,
                                            isSubmit: isSubmit,
                                          );
                                        },
                                      );
                                    },
                                    separatorBuilder: (_, __) =>
                                        const SizedBox(height: 8),
                                    itemCount:
                                        _tasks.length + (_hasMore ? 1 : 0),
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

  void _submitTaskUpdate({
    required Task task,
    required bool isSubmit,
  }) {
    if (task.wfStatusColor.label == "Submitted" ||
        task.wfStatusColor.label == "مرسلة") {
      _showResubmissionConfirmation(
        isSubmit: isSubmit,
        task: task,
      );
    } else {
      showTaskUpdatesBottomSheet(
        context: context,
        taskStatus: _taskStatus,
        taskPriority: _taskPriority,
        taskId: task.id,
        showDuration: true,
        showPriority: true,
        taskAssigneeId: task.assignmentId,
        isSubmit: isSubmit,
        onConfirm: (RequestUpdateTasks requestUpdateTasks) {
          _bloc.add(
            TaskUpdateEvent(
              requestUpdateTasks: requestUpdateTasks,
              skip: _skip,
              pageSize: _pageSize,
            ),
          );
        },
      );
    }
  }

  void _showResubmissionConfirmation({
    required bool isSubmit,
    required Task task,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(S.of(context).confirmResubmission),
        content: Text(S.of(context).resubmitTaskWarning),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              S.of(context).cancel,
              style: const TextStyle(
                color: ColorSchemes.gray,
                fontSize: 16,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              showTaskUpdatesBottomSheet(
                context: context,
                taskStatus: _taskStatus,
                taskPriority: _taskPriority,
                taskId: task.id,
                showDuration: true,
                showPriority: true,
                taskAssigneeId: task.assignmentId,
                isSubmit: isSubmit,
                onConfirm: (RequestUpdateTasks requestUpdateTasks) {
                  _bloc.add(
                    TaskUpdateEvent(
                      requestUpdateTasks: requestUpdateTasks,
                      skip: _skip,
                      pageSize: _pageSize,
                    ),
                  );
                },
              );
            },
            child: Text(
              S.of(context).confirm,
              style: const TextStyle(
                color: ColorSchemes.primary,
                fontSize: 16,
              ),
            ),
          ),
        ],
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
        _skip = 0;
        _sortColumnDirection = "desc";
        _columnDirection = "descending";
        _bloc.add(GetTasksEvent(
          pageSize: _pageSize,
          skip: _skip,
          isStart: true,
          searchValue: "",
          searchFilterDefination: "",
          sortColumnDirection: _sortColumnDirection,
          columnDirection: _columnDirection,
        ));
      },
    );
  }

  void _showSortBottomSheet(BuildContext context) async {
    Sort? selectedSort = await GetSortTasksUseCase(injector())();

    showSortsBottomSheet(
      context: context,
      isFirst: selectedSort != null && selectedSort.id != -1 ? false : true,
      selectedSort:
          selectedSort != null && selectedSort.id != -1 ? selectedSort : null,
      onSortSelected: (value) {
        _bloc.add(GetSortedTasksEvent(sort: value));
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

        _bloc.add(GetTasksEvent(
          pageSize: _pageSize,
          skip: _skip,
          isStart: true,
          searchValue: '',
          searchFilterDefination: '',
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
        _bloc.add(FilterTasksEvent(filter: filter));
      },
      onReset: () {
        Navigator.pop(context);
        _filter = null;
        _sortColumnDirection = "desc";
        _columnDirection = "descending";
        _bloc.add(GetTasksEvent(
          skip: 0,
          pageSize: _pageSize,
          searchValue: "",
          searchFilterDefination: "",
          sortColumnDirection: _sortColumnDirection,
          columnDirection: _columnDirection,
        ));
      },
      saveFilter: _filter,
    );
  }
}
