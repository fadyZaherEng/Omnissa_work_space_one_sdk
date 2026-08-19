import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/core/resources/data_state.dart';
import 'package:mofa/src/core/utils/check_filter_status.dart';
import 'package:mofa/src/core/utils/convert_string_to_date_format.dart';
import 'package:mofa/src/data/sources/remote/api_key.dart';
import 'package:mofa/src/data/sources/remote/mofa/more/entity/remore_milstone_details.dart';
import 'package:mofa/src/data/sources/remote/mofa/more/request/request_update_milstone.dart';
import 'package:mofa/src/di/data_layer_injector.dart';
import 'package:mofa/src/domain/entities/home/milstones.dart';
import 'package:mofa/src/domain/entities/shared/filter.dart';
import 'package:mofa/src/domain/entities/shared/sort.dart';
import 'package:mofa/src/domain/usecase/get_language_use_case.dart';
import 'package:mofa/src/domain/usecase/get_token_use_case.dart';
import 'package:mofa/src/domain/usecase/login/get_username_use_case.dart';
import 'package:mofa/src/domain/usecase/more/get_milstones_use_case.dart';
import 'package:mofa/src/domain/usecase/more/get_task_info_use_case.dart';
import 'package:mofa/src/domain/usecase/more/update_milstone_use_case.dart';
import 'package:mofa/src/domain/usecase/sort/milstones_sort_use_case.dart';
import 'package:mofa/src/domain/usecase/sort/set_sort_milstones_use_case.dart';

part 'milstones_event.dart';

part 'milstones_state.dart';

class MilstonesBloc extends Bloc<MilstonesEvent, MilstonesState> {
  final MilstonesSortUseCase _milstonesSortUseCase;
  final SetSortMilstonesUseCase _setSortMilstonesUseCase;
  final GetMilstonesUseCase _getMilstonesUseCase;
  final GetTaskInfoUseCase _getTaskInfoUseCase;
  final UpdateMilstoneUseCase _updateMilstoneUseCase;

  MilstonesBloc(
    this._milstonesSortUseCase,
    this._setSortMilstonesUseCase,
    this._getMilstonesUseCase,
    this._getTaskInfoUseCase,
    this._updateMilstoneUseCase,
  ) : super(MilstonesInitial()) {
    on<GetMilstonesEvent>(_onGetMilstonesEvent);
    on<SearchMilstonesEvent>(_onSearchMilstonesEvent);
    on<FilterMilstonesEvent>(_onFilterTaskEvent);
    on<GetSortedMilstonesEvent>(_onGetSortedMilstonesEvent);
    on<GetMilstoneInfoEvent>(_onGetMilstoneInfoEvent);
    on<UpdateMilstoneEvent>(_onUpdateMilstoneEvent);
  }

  FutureOr<void> _onGetMilstoneInfoEvent(
      GetMilstoneInfoEvent event, Emitter<MilstonesState> emit) async {
    emit(GetMilstoneInfoLoadingState());
    DataState<RemoteMilstoneDetails> response = await _getTaskInfoUseCase(
      id: event.id,
      pageSize: event.pageSize,
      skip: event.skip,
      sortColumnDirection: event.sortColumnDirection,
      columnDirection: event.columnDirection,
    );
    if (response is DataSuccess) {
      emit(GetMilstoneInfoSuccessState(
          response.data ?? const RemoteMilstoneDetails()));
    } else if (response is DataFailed) {
      emit(GetMilstonesErrorState(response.message ?? ""));
    }
  }

  final List<Milstones> _milstones = [];

  FutureOr<void> _onGetMilstonesEvent(
      GetMilstonesEvent event, Emitter<MilstonesState> emit) async {
    if (event.isStart) {
      emit(GetMilstonesLoadingState());
    }
    DataState<List<Milstones>> response = await _getMilstonesUseCase(
      pageSize: event.pageSize,
      skip: event.skip,
      sortColumnDirection: event.sortColumnDirection,
      columnDirection: event.columnDirection,
    );
    if (response is DataSuccess) {
      _milstones.clear();
      _milstones.addAll(response.data ?? []);
      emit(GetMilstonesSuccessState(_milstones));
    } else if (response is DataFailed) {
      emit(GetMilstonesErrorState(response.message ?? ""));
    }
  }

  // Helper to check if a field contains the search text
  bool _containsIgnoreCase(String value, String searchText) =>
      value.toLowerCase().contains(searchText);

  FutureOr<void> _onSearchMilstonesEvent(
      SearchMilstonesEvent event, Emitter<MilstonesState> emit) {
    emit(GetMilstonesLoadingState());
    final searchText = event.search.trim().toLowerCase();
    if (searchText.isEmpty) {
      emit(GetMilstonesSuccessState(_milstones));
    } else {
      final filteredMilstones = _milstones.where((milstones) {
        return _containsIgnoreCase(
                milstones.name.toLowerCase().trim(), searchText) ||
            _containsIgnoreCase(
                milstones.startDate.toLowerCase().trim(), searchText) ||
            _containsIgnoreCase(
                milstones.endDate.toLowerCase().trim(), searchText) ||
            _containsIgnoreCase(
                milstones.weight.toString().toLowerCase().trim(), searchText) ||
            _containsIgnoreCase(
                milstones.percentDone.toString().toLowerCase().trim(),
                searchText) ||
            _containsIgnoreCase(
                milstones.baselineEndDate.toLowerCase().trim().toString(),
                searchText) ||
            _containsIgnoreCase(milstones.id.toLowerCase().trim(), searchText);
      }).toList();

      emit(SearchMilstonesSuccessState(filteredMilstones));
    }
  }

  FutureOr<void> _onGetSortedMilstonesEvent(
      GetSortedMilstonesEvent event, Emitter<MilstonesState> emit) {
    // emit(GetMilstonesLoadingState());
    _setSortMilstonesUseCase(event.sort);
    final sort = event.sort;
    // final sortedMilstones =
    //     _milstonesSortUseCase.sortMilstones(_milstones, sort);
    // emit(SortMilstonesState(milstones: sortedMilstones));
  }

  FutureOr<void> _onFilterTaskEvent(
      FilterMilstonesEvent event, Emitter<MilstonesState> emit) {
    emit(GetMilstonesLoadingState());

    final Filter filter = event.filter;

    final filteredMilstones = _milstones.where((milstones) {
      final matchesStatus = milstones.name == filter.statusId.toString();
      final matchesDepartment = milstones.id == filter.departmentId.toString();
      final matchesStartDate =
          isMoreThenOrEqualDate(filter.startDate, milstones.startDate);
      final matchesEndDate = isLessThenDate(filter.endDate, milstones.endDate);

      return checkFilterStatus(
        matchesStatus,
        matchesDepartment,
        matchesStartDate,
        matchesEndDate,
        filter,
      );
    }).toList();

    emit(FilterMilstonesState(milstones: filteredMilstones));
  }

  FutureOr<void> _onUpdateMilstoneEvent(
      UpdateMilstoneEvent event, Emitter<MilstonesState> emit) async {
    emit(UpdateMilstoneLoadingState());
    // final response = await _updateMilstoneUseCase(
    //   requestUpdateMilstone: event.requestUpdateMilstone,
    // );
    Dio dio = Dio();
    final response = await dio.post(
      "${APIKeys.baseUrlDevelopment}${APIKeys.updateMilestone}",
      queryParameters: {
        "userEmail": GetUserNameUseCase(injector())(),
        "isEnglish": GetLanguageUseCase(injector())() == "en",
      },
      data: {
        "id": event.requestUpdateMilstone.id,
        "note": event.requestUpdateMilstone.note,
      },
      options: Options(
        headers: {
          "Authorization": "Bearer ${GetTokenUseCase(injector())()}",
          "Content-Type": "application/json",
        },
        responseType: ResponseType.plain, // 👈 prevent Dio from JSON-decoding
      ),
    );

    dynamic parsed;
    try {
      parsed = jsonDecode(response.data);
    } catch (e) {
      parsed = response.data; // fallback to raw string
    }

    print("UpdateMilstoneEvent: ${parsed.toString()}");
    if (response.statusCode == 200) {
      emit(UpdateMilstoneSuccessState(massage: S.current.success ?? ""));
    } else {
      emit(UpdateMilstoneErrorState(massage: response.statusMessage ?? ""));
    }
  }
}
