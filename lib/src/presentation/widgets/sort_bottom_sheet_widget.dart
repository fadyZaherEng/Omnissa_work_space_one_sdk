import 'package:flutter/material.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/domain/entities/shared/sort.dart';
import 'package:mofa/src/presentation/widgets/custom_button_widget.dart';
import 'package:mofa/src/presentation/widgets/custom_radio_button_widget.dart';

class SortBottomSheetWidget extends StatefulWidget {
  final List<Sort> sorts;
  final Sort selectedSort;
  final Function(Sort) onSortSelected;
  final bool isFirst;

  const SortBottomSheetWidget({
    super.key,
    required this.sorts,
    required this.selectedSort,
    required this.onSortSelected,
    required this.isFirst,
  });

  @override
  State<SortBottomSheetWidget> createState() => _SortBottomSheetWidgetState();
}

class _SortBottomSheetWidgetState extends State<SortBottomSheetWidget> {
  late Sort initialSort;

  @override
  void initState() {
    super.initState();
    if (widget.isFirst) {
      initialSort = const Sort(id: -1, name: "");
    } else {
      initialSort = widget.selectedSort;
    }
    // initialSort = const Sort(id: -1, name: "");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: widget.sorts.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: () {
                      setState(() {
                        initialSort = widget.sorts[index];
                      });
                      debugPrint(initialSort.name);
                    },
                    child: Row(
                      children: [
                        Text(
                          widget.sorts[index].name,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    letterSpacing: -0.24,
                                    color: ColorSchemes.black,
                                  ),
                        ),
                        const Expanded(child: SizedBox()),
                        CustomRadioButtonWidget(
                          isSelected: initialSort.id == widget.sorts[index].id,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  widget.sorts[index].id != 4
                      ? Container(
                          color: ColorSchemes.border,
                          height: 1.5,
                          width: double.infinity,
                        )
                      : const SizedBox.shrink(),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        CustomButtonWidget(
          onTap: () {
            Navigator.pop(context);
            widget.onSortSelected(initialSort);
          },
          text: S.of(context).confirm,
          backgroundColor: ColorSchemes.primary,
          height: 54,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
