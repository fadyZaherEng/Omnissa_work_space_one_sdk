import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/core/resources/image_paths.dart';
import 'package:mofa/src/core/utils/constants.dart';
import 'package:mofa/src/core/utils/select_date.dart';
import 'package:mofa/src/domain/entities/home/department.dart';
import 'package:mofa/src/domain/entities/home/owner.dart';
import 'package:mofa/src/domain/entities/home/status_model.dart';
import 'package:mofa/src/domain/entities/shared/filter.dart';
import 'package:mofa/src/presentation/widgets/bottom_sheet_widget.dart';
import 'package:mofa/src/presentation/widgets/custom_button_widget.dart';
import 'package:mofa/src/presentation/widgets/status_with_marks_widget.dart';

class FilterBottomSheetWidget extends StatefulWidget {
  final List<StatusModel> status;
  final List<Department> departments;
  final List<GetOwner>? owners;
  final bool isProjects;
  final Function(Filter) onFilterSelected;
  final Filter? saveFilter;

  const FilterBottomSheetWidget({
    super.key,
    required this.status,
    required this.departments,
    required this.onFilterSelected,
    this.saveFilter,
    this.owners,
    this.isProjects = false,
  });

  @override
  State<FilterBottomSheetWidget> createState() =>
      _FilterBottomSheetWidgetState();
}

class _FilterBottomSheetWidgetState extends State<FilterBottomSheetWidget> {
  late Filter filter;
  DateTime? fromDate;
  DateTime? toDate;

  @override
  void initState() {
    widget.departments.insert(
      0,
      Department(name: S.current.chooseDepartment),
    );
    super.initState();
    String statusName =
        widget.status.isNotEmpty ? widget.status.first.name : "";
    String departmentName =
        widget.departments.isNotEmpty ? widget.departments.first.name : "";
    int statusId = widget.status.isNotEmpty ? widget.status.first.id : 0;
    String departmentId = widget.departments.isNotEmpty
        ? widget.departments.first.id.toString()
        : "";
    String ownerName = widget.owners?.isNotEmpty ?? false
        ? widget.owners?.first.name ?? ""
        : "";
    filter = Filter(
      startDate: widget.saveFilter?.startDate ?? "",
      endDate: widget.saveFilter?.endDate ?? "",
      statusName: widget.saveFilter?.statusName ?? statusName,
      departmentName: widget.saveFilter?.departmentName ?? departmentName,
      statusId: widget.saveFilter?.statusId ?? -1,
      departmentId: widget.saveFilter?.departmentId ?? "",
      ownerId: widget.saveFilter?.ownerId ?? "",
      ownerName: widget.saveFilter?.ownerName ?? ownerName,
    );
    widget.saveFilter != null
        ? fromDate = filter.startDate.isNotEmpty
            ? DateTime.parse(filter.startDate)
            : null
        : null;
    widget.saveFilter != null
        ? toDate =
            filter.endDate.isNotEmpty ? DateTime.parse(filter.endDate) : null
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        _buildLabel(S.of(context).status),
        const SizedBox(height: 12),
        _buildStatusSelector(),
        const SizedBox(height: 24),
        _buildLabel(S.of(context).department),
        const SizedBox(height: 12),
        _buildDepartment(),
        if (widget.owners != null) const SizedBox(height: 24),
        if (widget.owners != null) _buildLabel(S.of(context).owner),
        if (widget.owners != null) const SizedBox(height: 12),
        if (widget.owners != null) _buildOwner(),
        if (widget.owners != null) const SizedBox(height: 12),
        // _buildLabel(S.of(context).date),
        // const SizedBox(height: 12),
        // _buildDateRangePicker(),
        // const SizedBox(height: 24),
        const Spacer(),
        CustomButtonWidget(
          onTap: () {
            Navigator.pop(context);
            widget.onFilterSelected(filter);
          },
          text: S.of(context).confirm,
          backgroundColor: ColorSchemes.primary,
          height: 54,
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            letterSpacing: -0.24,
            fontWeight: Constants.fontWeightSemiBold,
            color: ColorSchemes.black,
          ),
    );
  }

  Widget _buildStatusSelector() {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: widget.status.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final status = widget.status[index];
          return StatusWithMarksWidget(
            status: status,
            isSelected: filter.statusId == status.id,
            onTap: (s) => setState(
              () => filter = filter.copyWith(
                statusId: s.id,
                statusName: s.name,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDepartment() {
    Department selectedDepartment = widget.departments.firstWhere(
      (dept) => dept.id == filter.departmentId,
      orElse: () => const Department(),
    );

    return InkWell(
      onTap: () {
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          enableDrag: false,
          isScrollControlled: true,
          builder: (context) => Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 8,
              right: 8,
            ),
            child: BottomSheetWidget(
              titleLabel: S.of(context).chooseDepartment,
              isPadding: false,
              height: 400,
              content: ListView.separated(
                padding:
                    EdgeInsets.zero, // ✅ شيل الـ default padding بتاع ListView
                itemCount: widget.departments
                    .map((e) =>
                        e.name != S.of(context).chooseDepartment ||
                        e.name.isEmpty)
                    .toList()
                    .length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final department = widget.departments[index];
                  if (department.name == S.of(context).chooseDepartment ||
                      department.name.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  return InkWell(
                    onTap: () {
                      setState(() {
                        filter = filter.copyWith(
                          departmentId: department.id,
                          departmentName: department.name,
                        );
                        selectedDepartment = department;
                      });
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      // margin: index == 0
                      //     ? const EdgeInsets.only(top: 12)
                      //     : const EdgeInsets.symmetric(horizontal: 0),
                      color: ColorSchemes.secondary,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          // vertical: 8,
                          horizontal: 16,
                        ),
                        child: Text(
                          department.name,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    letterSpacing: -0.24,
                                    color: ColorSchemes.black,
                                  ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ).then((value) {
          //refresh bottom sheet state after pop
          setState(() {});
        });
      },
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          border: Border.all(color: ColorSchemes.searchBackground),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                selectedDepartment.name,
                style: selectedDepartment.id == ""
                    ? Theme.of(context).textTheme.bodySmall?.copyWith(
                          letterSpacing: -0.24,
                          color: ColorSchemes.gray,
                        )
                    : Theme.of(context).textTheme.bodyMedium?.copyWith(
                          letterSpacing: -0.24,
                          color: ColorSchemes.black,
                        ),
              ),
            ),
            Container(
              color: ColorSchemes.searchBackground,
              width: 45,
              height: 45,
              child: Center(
                child: SvgPicture.asset(
                  ImagePaths.arrowDown,
                  width: 20,
                  height: 20,
                  fit: BoxFit.scaleDown,
                  color: ColorSchemes.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateRangePicker() {
    return Row(
      children: [
        Expanded(child: _buildDatePicker(S.of(context).from, fromDate, true)),
        const SizedBox(width: 15),
        Expanded(child: _buildDatePicker(S.of(context).to, toDate, false)),
      ],
    );
  }

  Widget _buildDatePicker(String label, DateTime? date, bool isFrom) {
    return GestureDetector(
      onTap: () => selectDate(context, isFrom, (picked) {
        setState(() {
          if (isFrom) {
            fromDate = picked;
            filter = filter.copyWith(startDate: picked.toIso8601String());
          } else {
            toDate = picked;
            filter = filter.copyWith(endDate: picked.toIso8601String());
          }
        });
      }),
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          border: Border.all(color: ColorSchemes.searchBackground),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                date != null ? DateFormat('yyyy/MM/dd').format(date) : label,
                style: date == null
                    ? Theme.of(context).textTheme.bodySmall?.copyWith(
                          letterSpacing: -0.24,
                          color: ColorSchemes.gray,
                        )
                    : Theme.of(context).textTheme.bodyMedium?.copyWith(
                          letterSpacing: -0.24,
                          color: ColorSchemes.black,
                        ),
              ),
            ),
            Container(
              color: ColorSchemes.searchBackground,
              width: 45,
              height: 45,
              child: Center(
                child: SvgPicture.asset(
                  ImagePaths.calendar,
                  width: 20,
                  height: 20,
                  fit: BoxFit.scaleDown,
                  color: ColorSchemes.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOwner() {
    GetOwner? selectedOwner = widget.owners?.firstWhere(
      (owner) => owner.id == filter.ownerId,
      orElse: () => const GetOwner(),
    );
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          enableDrag: false,
          isScrollControlled: true,
          builder: (context) => Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 8,
              right: 8,
            ),
            child: BottomSheetWidget(
              titleLabel: S.of(context).chooseOwner,
              isPadding: false,
              height: 400,
              content: ListView.separated(
                itemCount: widget.owners?.length ?? 0,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final owner = widget.owners?[index] ?? const GetOwner();
                  return InkWell(
                    onTap: () {
                      setState(() {
                        filter = filter.copyWith(
                          ownerId: owner.id,
                          ownerName: owner.name,
                        );
                        selectedOwner = owner;
                      });
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      margin: index == 0
                          ? const EdgeInsets.only(top: 12)
                          : const EdgeInsets.symmetric(horizontal: 0),
                      color: ColorSchemes.secondary,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        child: Text(
                          owner.name,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    letterSpacing: -0.24,
                                    color: ColorSchemes.black,
                                  ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          border: Border.all(color: ColorSchemes.searchBackground),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                selectedOwner != null && selectedOwner.name.isNotEmpty
                    ? selectedOwner.name
                    : S.of(context).chooseOwner,
                style: (selectedOwner?.id ?? "").isEmpty
                    ? Theme.of(context).textTheme.bodySmall?.copyWith(
                          letterSpacing: -0.24,
                          color: ColorSchemes.gray,
                        )
                    : Theme.of(context).textTheme.bodyMedium?.copyWith(
                          letterSpacing: -0.24,
                          color: ColorSchemes.black,
                        ),
              ),
            ),
            Container(
              color: ColorSchemes.searchBackground,
              width: 45,
              height: 45,
              child: Center(
                child: SvgPicture.asset(
                  ImagePaths.arrowDown,
                  width: 20,
                  height: 20,
                  fit: BoxFit.scaleDown,
                  color: ColorSchemes.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
