import 'package:flutter/material.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/domain/entities/shared/sort.dart';
import 'package:mofa/src/presentation/widgets/bottom_sheet_widget.dart';
import 'package:mofa/src/presentation/widgets/sort_bottom_sheet_widget.dart';

Future showSortsBottomSheet({
  required BuildContext context,
  double? height,
  List<Sort>? sorts,
  Sort? selectedSort,
  required Function(Sort) onSortSelected,
  required bool isFirst,
}) async {
  List<Sort> initialSorts = [
    Sort(id: 1, name: S.of(context).ascending),
    Sort(id: 2, name: S.of(context).descending),
    Sort(id: 3, name: S.of(context).recentlyAdded),
    Sort(id: 4, name: S.of(context).oldest),
  ];
  selectedSort = selectedSort ?? initialSorts.first;
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
        titleLabel: S.of(context).sort,
        height: height ?? 382,
        content: SortBottomSheetWidget(
          sorts: sorts ?? initialSorts,
          selectedSort: selectedSort ?? initialSorts.first,
          onSortSelected: onSortSelected,
          isFirst: isFirst,
        ),
      ),
    ),
  );
}
