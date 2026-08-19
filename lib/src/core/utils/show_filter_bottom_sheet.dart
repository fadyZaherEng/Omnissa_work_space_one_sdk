import 'package:flutter/material.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/domain/entities/home/department.dart';
import 'package:mofa/src/domain/entities/home/owner.dart';
import 'package:mofa/src/domain/entities/home/status_model.dart';
import 'package:mofa/src/domain/entities/shared/filter.dart';
import 'package:mofa/src/presentation/blocs/home/home_bloc.dart';
import 'package:mofa/src/presentation/widgets/bottom_sheet_widget.dart';
import 'package:mofa/src/presentation/widgets/filter_bottom_sheet_widget.dart';

Future showFilterBottomSheet({
  required BuildContext context,
  double? height,
  List<StatusModel>? status,
  List<GetOwner>? owners,
  bool isProjects = false,
  List<Department>? departments,
  Filter? saveFilter,
  required Function(Filter) onFilterSelected,
  required Function() onReset,
}) async {
  return await showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    enableDrag: false,
    isScrollControlled: true,
    builder: (context) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 8,
        left: 8,
        right: 8,
      ),
      child: BottomSheetWidget(
        titleLabel: S.of(context).filter,
        height: owners != null ? 450 : 370,
        isReset: true,
        onReset: onReset,
        content: FilterBottomSheetWidget(
          status: status ??
              statusStore.where((element) => element.name.isNotEmpty).toList(),
          departments: departments ??
              departmentsStore
                  .where((element) => element.name.isNotEmpty)
                  .toList(),
          onFilterSelected: onFilterSelected,
          saveFilter: saveFilter,
          isProjects: isProjects,
          owners: owners,
        ),
      ),
    ),
  );
}
