import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/core/utils/constants.dart';
import 'package:mofa/src/data/sources/remote/mofa/more/request/request_update_tasks.dart';
import 'package:mofa/src/domain/entities/home/status_model.dart';
import 'package:mofa/src/domain/entities/home/task_enum.dart';
import 'package:mofa/src/presentation/widgets/custom_button_widget.dart';
import 'package:mofa/src/presentation/widgets/custom_text_field_widget.dart';
import 'package:mofa/src/presentation/widgets/status_with_marks_widget.dart';

class TaskUpdatesBottomSheetWidget extends StatefulWidget {
  final List<TaskBoardEnum> taskStatus;
  final List<TaskBoardEnum> taskPriority;
  final String taskId;
  final String taskAssigneeId;
  final bool isSubmit;
  final Function(RequestUpdateTasks) onConfirm;
  final bool showDuration;
  final bool showPriority;

  const TaskUpdatesBottomSheetWidget({
    super.key,
    required this.taskStatus,
    required this.taskPriority,
    required this.onConfirm,
    required this.taskId,
    required this.taskAssigneeId,
    required this.isSubmit,
    this.showDuration = true,
    this.showPriority = true,
  });

  @override
  State<TaskUpdatesBottomSheetWidget> createState() =>
      _TaskUpdatesBottomSheetWidgetState();
}

class MaxValueTextInputFormatter extends TextInputFormatter {
  final int max;
  MaxValueTextInputFormatter(this.max);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) return newValue;

    final value = int.tryParse(newValue.text);
    if (value != null && value > max) {
      return TextEditingValue(
        text: max.toString(),
        selection: TextSelection.collapsed(offset: max.toString().length),
      );
    }
    return newValue;
  }
}


class _TaskUpdatesBottomSheetWidgetState
    extends State<TaskUpdatesBottomSheetWidget> {
  TaskBoardEnum selectedStatus = const TaskBoardEnum();
  TaskBoardEnum selectedPriority = const TaskBoardEnum();
  final TextEditingController _percentDoneController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  String? _percentDoneError;
  String? _durationError;
  String? _commentError;

  @override
  void initState() {
    super.initState();
    selectedStatus = widget.taskStatus.first;
    selectedPriority = widget.taskPriority.isNotEmpty
        ? widget.taskPriority.first
        : const TaskBoardEnum(id: -1, name: '');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextFieldWidget(
            controller: _percentDoneController,
            labelTitle: S.of(context).percentDone,
            errorMessage: _percentDoneError,
            textInputType: TextInputType.number,
            // inputFormatters: [
            //   LengthLimitingTextInputFormatter(3),
            //   MaxValueTextInputFormatter(100),
            // ],
            onChange: (value) {
              setState(() {
                if (value.isEmpty) {
                  _percentDoneError = S.of(context).thisFieldIsRequired;
                } else {
                  final numValue = int.tryParse(value) ?? 0;

                  if (numValue > 100) {
                    _percentDoneError = S.of(context).valueCannotExceed100;
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _percentDoneController.text = "100";
                      _percentDoneController.selection =
                          TextSelection.fromPosition(
                        TextPosition(
                            offset: _percentDoneController.text.length),
                      );
                    });
                  } else {
                    _percentDoneError = null;
                  }
                }
              });
            },
          ),
          // CustomTextFieldWidget(
          //   controller: _percentDoneController,
          //   labelTitle: S.of(context).percentDone,
          //   errorMessage: _percentDoneError,
          //   textInputType: TextInputType.number,
          //   inputFormatters: [
          //     LengthLimitingTextInputFormatter(3),
          //     MaxValueTextInputFormatter(100),
          //   ],
          //   onChange: (value) {
          //     setState(() {
          //       if (value.isEmpty) {
          //         _percentDoneError = S.of(context).thisFieldIsRequired;
          //       } else {
          //         _percentDoneError = null;
          //       }
          //     });
          //   },
          // ),

          if (widget.showDuration) ...[
            const SizedBox(height: 12),
            CustomTextFieldWidget(
              controller: _durationController,
              labelTitle: S.of(context).duration,
              textInputType: TextInputType.number,
              errorMessage: _durationError,
              onChange: (value) {
                setState(() {
                  if (value.isEmpty) {
                    _durationError = S.of(context).thisFieldIsRequired;
                  } else {
                    _durationError = null;
                  }
                });
              },
            ),
          ],
          const SizedBox(height: 12),
          CustomTextFieldWidget(
            controller: _commentController,
            labelTitle: S.of(context).comment,
            textInputType: TextInputType.multiline,
            errorMessage: _commentError,
            onChange: (value) {
              setState(() {
                if (value.isEmpty) {
                  _commentError = S.of(context).thisFieldIsRequired;
                } else {
                  _commentError = null;
                }
              });
            },
          ),
          const SizedBox(height: 24),
          _buildLabel(S.of(context).selectTaskStatus),
          const SizedBox(height: 12),
          _buildStatusSelector(),
          if (widget.showPriority) ...[
            const SizedBox(height: 12),
            _buildLabel(S.of(context).selectTaskPriority),
            const SizedBox(height: 12),
            _buildPrioritySelector(),
          ],
          const SizedBox(height: 32),
          CustomButtonWidget(
            onTap: () {
              if (_checkValidation()) {
                widget.onConfirm(
                  RequestUpdateTasks(
                    changes: Changes(
                      actionType: widget.isSubmit ? "submitted" : "noSubmitted",
                    ),
                    tasks: Tasks(
                      updated: [
                        Updated(
                          Id: widget.taskId,
                          DraftPercentDone: int.parse(
                            _percentDoneController.text,
                          ),
                          Duration: widget.showDuration
                              ? int.parse(_durationController.text)
                              : -1,
                          DraftStatus: selectedStatus.id,
                          DraftPriority:
                              widget.showPriority ? selectedPriority.id : -1,
                          AssignmentId: widget.taskAssigneeId,
                          commnet: _commentController.text,
                        ),
                      ],
                    ),
                  ),
                );
                Navigator.pop(context);
              } else {
                setState(() {
                  _percentDoneError = _percentDoneController.text.isEmpty
                      ? S.of(context).thisFieldIsRequired
                      : null;
                  _durationError = _durationController.text.isEmpty
                      ? S.of(context).thisFieldIsRequired
                      : null;
                });
              }
            },
            text: S.of(context).confirm,
            backgroundColor: ColorSchemes.primary,
            height: 54,
          ),
          const SizedBox(height: 16),
        ],
      ),
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
        itemCount: widget.taskStatus.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final status = widget.taskStatus[index];
          return StatusWithMarksWidget(
            status: StatusModel(
              id: status.id,
              name: status.name,
            ),
            isSelected: selectedStatus.id == status.id,
            onTap: (s) => setState(
                () => selectedStatus = selectedStatus.copyWith(id: s.id)),
          );
        },
      ),
    );
  }

  Widget _buildPrioritySelector() {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: widget.taskPriority.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final status = widget.taskPriority[index];
          return StatusWithMarksWidget(
            status: StatusModel(
              id: status.id,
              name: status.name,
            ),
            isSelected: selectedPriority.id == status.id,
            onTap: (s) => setState(
              () => selectedPriority = selectedPriority.copyWith(id: s.id),
            ),
          );
        },
      ),
    );
  }

  bool _checkValidation() {
    if (_percentDoneController.text.isEmpty) {
      return false;
    }
    if (_durationController.text.isEmpty && widget.showDuration) {
      return false;
    }
    return true;
  }
}
