import 'package:flutter/material.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/core/resources/image_paths.dart';
import 'package:mofa/src/di/data_layer_injector.dart';
import 'package:mofa/src/domain/entities/shared/steps.dart';
import 'package:mofa/src/domain/usecase/get_language_use_case.dart';
import 'package:mofa/src/presentation/widgets/build_option_widget.dart';
import 'package:mofa/src/presentation/widgets/custom_button_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StepsWidget extends StatefulWidget {
  final List<Steps> steps;
  final List<Widget> pages;
  final bool isBackgroundColor;
  final bool isStepBackgroundColor;
  final bool isAnotherSpace;
  final bool isShowOptionsForAll;
  final bool isLandmarkStatusSaved;
  final Color? backgroundColor;
  final double? height;
  final void Function(int)? onStepTapped;
  final void Function()? onSortTapped;
  final void Function(int) onLandMarkStatusTapped;
  final void Function(int) onLandMarkStatusCleared;
  int selectedId;

  StepsWidget({
    super.key,
    required this.steps,
    required this.pages,
    required this.isLandmarkStatusSaved,
    this.isBackgroundColor = true,
    this.isAnotherSpace = true,
    this.isStepBackgroundColor = true,
    this.backgroundColor,
    this.height,
    this.onStepTapped,
    this.onSortTapped,
    this.isShowOptionsForAll = false,
    required this.onLandMarkStatusTapped,
    this.selectedId = 0,
    required this.onLandMarkStatusCleared,
  });

  @override
  State<StepsWidget> createState() => _StepsWidgetState();
}

class _StepsWidgetState extends State<StepsWidget> {
  final PageController _pageController = PageController(initialPage: 0);
  int _selectedId = 0;

  @override
  void initState() {
    super.initState();
    if (widget.steps.isEmpty ||
        widget.pages.isEmpty ||
        widget.steps.length != widget.pages.length) {
      return;
    }
    _selectedId = widget.steps.first.id;
    _pageController.addListener(() {
      setState(() {});
    });
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (widget.isLandmarkStatusSaved) {
      await Future.delayed(const Duration(milliseconds: 300));
      setState(() {
        _pageController.jumpToPage(2);
        widget.onStepTapped?.call(widget.steps[2].id);
        _selectedId = widget.steps[2].id;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.steps.length != widget.pages.length ||
        widget.steps.isEmpty ||
        widget.pages.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      children: [
        Container(
          height: widget.height ?? 100,
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: 12,
            vertical: widget.isAnotherSpace ? 16 : 0,
          ),
          decoration: BoxDecoration(
            color: widget.isBackgroundColor
                ? ColorSchemes.stepBackgroundColor
                : Colors.transparent,
          ),
          child: Column(
            children: [
              _buildProgressLineWidget(),
              const SizedBox(height: 4),
              _buildStepsTitleWidget(context),
            ],
          ),
        ),
        if (widget.isAnotherSpace) const SizedBox(height: 8),
        if ((_selectedId != 0 &&
                _selectedId != 2 &&
                _selectedId != 1 &&
                _selectedId != 3 &&
                _selectedId != 4 &&
                _selectedId != 5) &&
            widget.isShowOptionsForAll)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                BuildOptionWidget(
                  title: S.of(context).sort,
                  image: ImagePaths.icSort,
                  onTap: () => widget.onSortTapped?.call(),
                ),
              ],
            ),
          ),
        if (_selectedId == 2)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: SizedBox(
              height: 35,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final List<String> labels = [
                    S.of(context).notStarted,
                    S.of(context).onTrack,
                    S.of(context).late,
                    S.of(context).veryLate,
                    S.of(context).completed,
                  ];

                  final bool isSelected =
                      injector<SharedPreferences>().getInt('landmark_status') ==
                          index;

                  return IntrinsicWidth(
                    child: CustomButtonWidget(
                      isPaddingVertical: false,
                      onTap: () {
                        if (isSelected) {
                          widget.onLandMarkStatusCleared(index);
                          //save selected index to shared preference
                          injector<SharedPreferences>()
                              .setInt('landmark_status', -1);
                          return;
                        }
                        setState(() {
                          widget.selectedId = index;
                          //save selected index to shared preference
                          injector<SharedPreferences>()
                              .setInt('landmark_status', widget.selectedId);
                          widget.onLandMarkStatusTapped(++index);
                          //refresh ui to jump to third page
                          _pageController.jumpToPage(2);
                        });
                      },
                      backgroundColor:
                          isSelected ? ColorSchemes.primary : ColorSchemes.gray,
                      text: labels[index],
                      height: 35,
                      textStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(
                            color: ColorSchemes.white,
                            fontWeight: isSelected ? FontWeight.w700 : null,
                            fontSize: GetLanguageUseCase(injector())() == "en"
                                ? 10
                                : 12,
                          ),
                    ),
                  );
                },
              ),
            ),
          ),
        if (_selectedId != 0 || widget.isShowOptionsForAll)
          const SizedBox(height: 8),
        _buildStepsWidget(),
      ],
    );
  }

  bool _isClicked = false;

  Widget _buildProgressLineWidget() {
    return Container(
      height: 14,
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? ColorSchemes.white,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: Row(
        children: widget.steps.asMap().entries.map((entry) {
          final index = entry.key;
          final step = entry.value;
          return Expanded(
            child: InkWell(
              onTap: () {
                if (!_isClicked) {
                  setState(() {
                    _isClicked = true;
                    _pageController.jumpToPage(index);
                    widget.onStepTapped?.call(step.id);
                    _selectedId = step.id;
                  });
                  Future.delayed(const Duration(milliseconds: 600), () {
                    setState(() {
                      _isClicked = false;
                    });
                  });
                }
              },
              child: Container(
                height: 14,
                decoration: BoxDecoration(
                  color: step.id == _selectedId
                      ? ColorSchemes.stepSelectedColor
                      : widget.isStepBackgroundColor
                          ? ColorSchemes.white
                          : Colors.transparent,
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Container(
                    width: 7,
                    height: 7,
                    margin: EdgeInsets.symmetric(
                      horizontal: step.id == _selectedId
                          ? 8
                          : widget.steps.length > 5
                              ? 16
                              : 24,
                    ),
                    decoration: BoxDecoration(
                      color: step.id == _selectedId
                          ? ColorSchemes.white
                          : ColorSchemes.gray,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildStepsTitleWidget(BuildContext context) {
    return Row(
      children: widget.steps.asMap().entries.map((entry) {
        final step = entry.value;
        final isSelected = step.id == _selectedId;
        return Expanded(
          child: Column(
            children: [
              if (step.name.trim().isNotEmpty)
                Text(
                  step.name.trim(),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: widget.pages.length > 4 &&
                              GetLanguageUseCase(injector())() == "ar"
                          ? 12
                          : widget.pages.length > 4 &&
                                  GetLanguageUseCase(injector())() == "en"
                              ? 8
                              : 15,
                      color: isSelected
                          ? ColorSchemes.stepSelectedColor
                          : ColorSchemes.gray,
                      fontWeight:
                          isSelected ? FontWeight.w800 : FontWeight.w400),
                ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildStepsWidget() {
    return Expanded(
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.pages.length,
        onPageChanged: (index) {
          setState(() {
            _pageController.jumpToPage(index);
            widget.onStepTapped?.call(widget.steps[index].id);
            _selectedId = widget.steps[index].id;
          });
        },
        itemBuilder: (context, index) => widget.pages[index],
      ),
    );
  }
}
