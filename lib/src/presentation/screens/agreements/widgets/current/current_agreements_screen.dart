import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/core/base/widget/base_stateful_widget.dart';
import 'package:mofa/src/core/resources/image_paths.dart';
import 'package:mofa/src/core/utils/show_comment_bottom_sheet.dart';
import 'package:mofa/src/core/utils/show_filter_bottom_sheet.dart';
import 'package:mofa/src/core/utils/show_massage_dialog_widget.dart';
import 'package:mofa/src/core/utils/show_sort_bottom_sheet.dart';
import 'package:mofa/src/data/sources/remote/mofa/more/request/request_handle_form_approval.dart';
import 'package:mofa/src/di/data_layer_injector.dart';
import 'package:mofa/src/domain/entities/home/form_approval.dart';
import 'package:mofa/src/domain/entities/shared/filter.dart';
import 'package:mofa/src/domain/entities/shared/sort.dart';
import 'package:mofa/src/domain/usecase/sort/get_sort_agreement_use_case.dart';
import 'package:mofa/src/presentation/blocs/agreements/agreements_bloc.dart';
import 'package:mofa/src/presentation/screens/agreements/skeleton/agreements_skeleton.dart';
import 'package:mofa/src/presentation/screens/agreements/widgets/current/agreements_current_card_widget.dart';
import 'package:mofa/src/presentation/widgets/build_options_props_widget.dart';
import 'package:mofa/src/presentation/widgets/custom_empty_list_widget.dart';
import 'package:mofa/src/presentation/widgets/reset_button_widget.dart';
import 'package:mofa/src/presentation/widgets/search_text_field_widget.dart';

class CurrentAgreementsScreen extends BaseStatefulWidget {
  const CurrentAgreementsScreen({super.key});

  @override
  BaseState<CurrentAgreementsScreen> baseCreateState() =>
      _AgreementsScreenState();
}

class _AgreementsScreenState extends BaseState<CurrentAgreementsScreen> {
  final List<FormApproval> _agreements = [];
  final TextEditingController controller = TextEditingController();
  bool isFirst = true;

  AgreementBloc get _bloc => BlocProvider.of<AgreementBloc>(context);
  Filter? _filter;
  int _skip = 0;
  final int _pageSize = 10;
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;
  bool _hasMore = true;
  bool _isShowFilter = false;
  String _sortColumnDirection = "desc";
  String _columnDirection = "descending";

  @override
  void initState() {
    super.initState();
    _bloc.add(GetCurrentAgreementsEvent(
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
        _bloc.add(GetCurrentAgreementsEvent(
          pageSize: _pageSize,
          skip: _skip,
          columnDirection: _columnDirection,
          sortColumnDirection: _sortColumnDirection,
          departmentId: _filter?.departmentId,
          statusId: _filter?.statusId,
          priorityPriority: -1,
          //_filter?.priorityId,
          isShowFilter: _isShowFilter,
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
        if (state is GetCurrentAgreementSuccessState) {
          if (_skip == 0) {
            _agreements.clear();
          }
          _agreements.addAll(state.agreements);
          _isLoadingMore = false;
          _hasMore = state.agreements.length ==
              _pageSize; // أقل من pageSize يعني مفيش بيانات تانية
          hideLoading();
        } else if (state is GetCurrentAgreementErrorState) {
          _showMessageDialog(
            message: state.errorMessage,
            icon: ImagePaths.warning,
          );
          hideLoading();
        } else if (state is SearchCurrentAgreementState) {
          _agreements.clear();
          _agreements.addAll(state.agreements);
        } else if (state is SortCurrentAgreementState) {
          _agreements.clear();
          _agreements.addAll(state.agreements);
        } else if (state is FilterCurrentAgreementsState) {
          _agreements.clear();
          _agreements.addAll(state.agreements);
        } else if (state is HandleFormApprovalSuccessState) {
          _showMessageDialog(
            message: state.message,
            icon: ImagePaths.success,
          );
        } else if (state is HandleFormApprovalErrorState) {
          _showMessageDialog(
            message: state.errorMessage,
            icon: ImagePaths.warning,
          );
        }
      },
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async {
            _isShowFilter = false;
            _skip = 0;
            _agreements.clear();
            _isLoadingMore = false;
            _hasMore = true;
            _filter = null;
            _sortColumnDirection = "desc";
            _columnDirection = "descending";
            _bloc.add(GetCurrentAgreementsEvent(
              pageSize: _pageSize,
              skip: 0,
              isStart: true,
              columnDirection: _columnDirection,
              sortColumnDirection: _sortColumnDirection,
            ));
          },
          child: Scaffold(
            body: state is GetCurrentAgreementsLoadingState
                ? const AgreementsSkeleton()
                : SafeArea(
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
                                setState(() {
                                  controller.text = value;
                                });
                              },
                              onTapSearch: () {
                                _skip = 0;
                                _bloc.add(GetCurrentAgreementsEvent(
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
                                _bloc.add(GetCurrentAgreementsEvent(
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
                                if(_agreements.isNotEmpty)
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
                                //     _skip = 0;
                                //     _sortColumnDirection = "desc";
                                //     _columnDirection = "descending";
                                //     _bloc.add(GetCurrentAgreementsEvent(
                                //       pageSize: _pageSize,
                                //       skip: _skip,
                                //       isStart: true,
                                //       columnDirection: _columnDirection,
                                //       sortColumnDirection: _sortColumnDirection,
                                //     ));
                                //   },
                                // ),
                              ],
                            ),
                            if(_agreements.isNotEmpty)
                            const SizedBox(height: 32),
                            _agreements.isEmpty
                                ? Center(
                                    child: InkWell(
                                      onTap: () =>
                                          _bloc.add(GetCurrentAgreementsEvent(
                                        pageSize: _pageSize,
                                        skip: 0,
                                            columnDirection: _columnDirection,
                                        sortColumnDirection: _sortColumnDirection,
                                      )),
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
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      itemBuilder: (context, index) {
                                        if (index == _agreements.length &&
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

                                        return AgreementsCurrentCardWidget(
                                          agreement: _agreements[index],
                                          onTap: (agreement) {},
                                          onAcceptTap: (ActionsList action) {
                                            _showCommentBottomSheet(
                                              context: context,
                                              taskId: _agreements[index].taskId,
                                              action: action,
                                            );
                                          },
                                        );
                                      },
                                      separatorBuilder: (_, __) =>
                                          const SizedBox(height: 8),
                                      itemCount: _agreements.length +
                                          (_hasMore ? 1 : 0),
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
    Sort? selectedSort = await GetSortAgreementUseCase(injector())();
    showSortsBottomSheet(
      context: context,
      isFirst: selectedSort != null && selectedSort.id != -1 ? false : true,
      selectedSort:
          selectedSort != null && selectedSort.id != -1 ? selectedSort : null,
      onSortSelected: (Sort value) {
        _bloc.add(GetSortedCurrentAgreementsEvent(sort: value));
        isFirst = false;
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
        setState(() {
        });
        _skip = 0;
        _bloc.add(GetCurrentAgreementsEvent(
          pageSize: _pageSize,
          skip: _skip,
          isStart: true,
          departmentId: _filter?.departmentId,
          statusId: _filter?.statusId,
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
        _bloc.add(GetCurrentAgreementsEvent(
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
        _isShowFilter = false;
        setState(() {});
        _skip = 0;
        _sortColumnDirection = "desc";
        _columnDirection = "descending";
        _bloc.add(GetCurrentAgreementsEvent(
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
    required String taskId,
    required ActionsList action,
  }) {
    showCommentBottomSheet(
      context: context,
      onSend: (comment) {
        Navigator.pop(context);
        _bloc.add(
          HandleFormApprovalEvent(
            request: RequestHandleFormApproval(
              ActionName: action.nameEn,
              Comment: comment,
              TaskId: taskId,
            ),
          ),
        );
      },
    );
  }
}
