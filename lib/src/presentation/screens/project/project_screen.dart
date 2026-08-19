import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/config/routes/routes_manager.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/core/base/widget/base_stateful_widget.dart';
import 'package:mofa/src/core/resources/image_paths.dart';
import 'package:mofa/src/core/utils/show_filter_bottom_sheet.dart';
import 'package:mofa/src/core/utils/show_massage_dialog_widget.dart';
import 'package:mofa/src/core/utils/show_sort_bottom_sheet.dart';
import 'package:mofa/src/di/data_layer_injector.dart';
import 'package:mofa/src/domain/entities/home/department.dart';
import 'package:mofa/src/domain/entities/home/owner.dart';
import 'package:mofa/src/domain/entities/home/project.dart';
import 'package:mofa/src/domain/entities/home/status_model.dart';
import 'package:mofa/src/domain/entities/shared/filter.dart';
import 'package:mofa/src/domain/entities/shared/sort.dart';
import 'package:mofa/src/domain/usecase/sort/get_sort_project_use_case.dart';
import 'package:mofa/src/presentation/blocs/project/project_bloc.dart';
import 'package:mofa/src/presentation/screens/home/home_screen.dart';
import 'package:mofa/src/presentation/screens/project/skeleton/project_skeleton.dart';
import 'package:mofa/src/presentation/screens/project/widgets/project_card_widget.dart';
import 'package:mofa/src/presentation/widgets/bell_notification_widget.dart';
import 'package:mofa/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:mofa/src/presentation/widgets/build_options_props_widget.dart';
import 'package:mofa/src/presentation/widgets/custom_empty_list_widget.dart';
import 'package:mofa/src/presentation/widgets/reset_button_widget.dart';
import 'package:mofa/src/presentation/widgets/search_text_field_widget.dart';

class ProjectsScreen extends BaseStatefulWidget {
  final bool isShowBackButton;

  const ProjectsScreen({
    super.key,
    this.isShowBackButton = false,
  });

  @override
  BaseState<ProjectsScreen> baseCreateState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends BaseState<ProjectsScreen> {
  final List<Project> _projects = [];
  final TextEditingController controller = TextEditingController();

  ProjectBloc get _bloc => BlocProvider.of<ProjectBloc>(context);
  Filter? _filter;
  bool _isFilter = false;
  List<StatusModel> _status = [];
  List<Department> _departments = [];
  List<GetOwner> _owners = [];
  int _skip = 0;
  final int _pageSize = 10;
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;
  bool _hasMore = true;
  String _sortColumnDirection = "desc";
  String _columnDirection = "descending";

  @override
  void initState() {
    _bloc.add(GetProjectsEvent(
      pageSize: _pageSize,
      skip: _skip,
      isStart: true,
      searchValue: "",
      searchFilterDefinition: "",
      sortColumnDirection: _sortColumnDirection,
      columnDirection: _columnDirection,
    ));
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (!_isLoadingMore && _hasMore) {
        _isLoadingMore = true;
        _skip += _pageSize;
        _bloc.add(GetProjectsEvent(
          pageSize: _pageSize,
          skip: _skip,
          isFilter: _isFilter,
          owner: _filter?.ownerId,
          departmentId: _filter?.departmentId,
          status: _filter?.statusId,
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
    return BlocConsumer<ProjectBloc, ProjectState>(
      listener: (context, state) {
        if (state is GetProjectsSuccessState) {
          if (_skip == 0) {
            _projects.clear();
          }
          _projects.addAll(state.projects);
          _isLoadingMore = false;
          _hasMore = state.projects.length ==
              _pageSize; // أقل من pageSize يعني مفيش بيانات تانية
          _status = List.from(state.status);
          _departments = List.from(state.departments);
          _owners = List.from(state.owners);
          hideLoading();
        } else if (state is GetProjectsErrorState) {
          _showMessageDialog(
            message: state.errorMessage,
            icon: ImagePaths.warning,
          );
          hideLoading();
        } else if (state is SearchProjectState) {
          if (_skip == 0) {
            _projects.clear();
          }
          _projects.addAll(state.projects);
          _isLoadingMore = false;
          _hasMore = state.projects.length ==
              _pageSize; // أقل من pageSize يعني مفيش بيانات تانية
          hideLoading();
        } else if (state is SortProjectState) {
          _projects.clear();
          _projects.addAll(state.projects);
          hideLoading();
        } else if (state is FilterProjectsState) {
          _projects.clear();
          _projects.addAll(state.projects);
        }
      },
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async {
            _skip = 0;
            _projects.clear();
            _isLoadingMore = false;
            _hasMore = true;
            _filter = null;
            _isFilter = false;
            _sortColumnDirection = "desc";
            _columnDirection = "descending";
            _bloc.add(GetProjectsEvent(
              pageSize: _pageSize,
              skip: _skip,
              isStart: true,
              sortColumnDirection: _sortColumnDirection,
              columnDirection: _columnDirection,
            ));
          },
          child: Scaffold(
            appBar: buildAppBarWidget(
              context,
              title: S.of(context).projects,
              isHaveBackButton: widget.isShowBackButton,
              centredTitle: !widget.isShowBackButton,
              onBackButtonPressed: () => Navigator.pop(context),
              actionWidget: BellNotificationWidget(
                totalApprovals: totalApprovals,
              ),
            ),
            body: state is GetProjectsSkeletonState
                ? const ProjectSkeleton()
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
                            onChange: (value) async {
                              setState(() {
                                controller.text = value;
                              });
                              // await Future.delayed(const Duration(seconds: 2));
                              // _bloc.add(GetProjectsEvent(
                              //   pageSize: _pageSize,
                              //   skip: 0,
                              //   isStart: true,
                              //   status: _filter?.statusId,
                              //   departmentId: _filter?.departmentId,
                              //   owner: _filter?.ownerId,
                              //   isFilter: _isFilter,
                              //   searchValue: value,
                              // ));
                              // _bloc.add(SearchProjectEvent(search: value));
                            },
                            onClear: () {
                              _skip = 0;
                              _sortColumnDirection = "desc";
                              _columnDirection = "descending";
                              _bloc.add(GetProjectsEvent(
                                pageSize: _pageSize,
                                skip: 0,
                                isStart: true,
                                status: _filter?.statusId,
                                departmentId: _filter?.departmentId,
                                owner: _filter?.ownerId,
                                isFilter: _isFilter,
                                searchValue: '',
                                sortColumnDirection: _sortColumnDirection,
                                columnDirection: _columnDirection,
                              ));
                              controller.clear();
                              // _bloc.add(SearchProjectEvent(search: ''));
                            },
                            onTapSearch: () {
                              _skip = 0;
                              _bloc.add(GetProjectsEvent(
                                pageSize: _pageSize,
                                skip: 0,
                                isStart: true,
                                status: _filter?.statusId,
                                departmentId: _filter?.departmentId,
                                owner: _filter?.ownerId,
                                isFilter: _isFilter,
                                searchValue: controller.text,
                                sortColumnDirection: _sortColumnDirection,
                                columnDirection: _columnDirection,
                              ));
                            },
                            searchText: S.of(context).search,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              if (_projects.isNotEmpty)
                                BuildOptionsPropsWidget(
                                  title: S.of(context).sort,
                                  image: ImagePaths.icSort,
                                  onTap: () => _showSortBottomSheet(context),
                                ),
                              if (_projects.isNotEmpty)
                                const SizedBox(width: 12),
                              if (_projects.isNotEmpty)
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
                                  _projects.clear();
                                  _isFilter = false;
                                  setState(() {});
                                  _sortColumnDirection = "desc";
                                  _columnDirection = "descending";

                                  _bloc.add(GetProjectsEvent(
                                    pageSize: _pageSize,
                                    skip: _skip,
                                    isStart: true,
                                    isFilter: false,
                                    owner: null,
                                    departmentId: null,
                                    status: null,
                                    sortColumnDirection: _sortColumnDirection,
                                    columnDirection: _columnDirection,
                                  ));
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),
                          _projects.isEmpty
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
                                      if (index == _projects.length &&
                                          _hasMore) {
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

                                      return ProjectCardWidget(
                                        project: _projects[index],
                                        onTap: (project) {
                                          Navigator.pushNamed(
                                            context,
                                            Routes.projectDetails,
                                            arguments: {
                                              'projectId': project.id
                                            },
                                          );
                                        },
                                      );
                                    },
                                    separatorBuilder: (_, __) =>
                                        const SizedBox(height: 8),
                                    itemCount:
                                        _projects.length + (_hasMore ? 1 : 0),
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
    Sort? selectedSort = await GetSortProjectUseCase(injector())();
    showSortsBottomSheet(
      context: context,
      isFirst: selectedSort != null && selectedSort.id != -1 ? false : true,
      selectedSort:
          selectedSort != null && selectedSort.id != -1 ? selectedSort : null,
      onSortSelected: (Sort value) {
        showLoading();
        _bloc.add(GetSortedProjectsEvent(sort: value));
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
        _bloc.add(GetProjectsEvent(
          pageSize: _pageSize,
          skip: _skip,
          isStart: true,
          searchValue: "",
          searchFilterDefinition: "",
          sortColumnDirection: _sortColumnDirection,
          columnDirection: _columnDirection,
        ));
      },
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showFilterBottomSheet(
      context: context,
      status: _status,
      departments: _departments,
      owners: _owners,
      onFilterSelected: (Filter filter) {
        _filter = filter;
        _isFilter = true;
        _skip = 0;

        setState(() {});
        // _bloc.add(FilterProjectsEvent(filter: filter));
        debugPrint(
            "filter: ${filter.departmentId} ${filter.statusId} ${filter.ownerId}");
        _bloc.add(GetProjectsEvent(
          pageSize: _pageSize,
          skip: 0,
          isStart: true,
          status: filter.statusId,
          departmentId: filter.departmentId,
          owner: filter.ownerId,
          isFilter: _isFilter,
          sortColumnDirection: _sortColumnDirection,
          columnDirection: _columnDirection,
        ));
      },
      onReset: () {
        Navigator.pop(context);
        _filter = null;
        _skip = 0;
        _isFilter = false;
        setState(() {});
        _isFilter = false;
        _sortColumnDirection = "desc";
        _columnDirection = "descending";

        _bloc.add(GetProjectsEvent(
          pageSize: _pageSize,
          skip: 0,
          isStart: true,
          searchValue: "",
          searchFilterDefinition: "",
          sortColumnDirection: _sortColumnDirection,
          columnDirection: _columnDirection,
        ));
      },
      saveFilter: _filter,
    );
  }
}
