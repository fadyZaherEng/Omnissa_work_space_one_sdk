import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'initiatives_details_event.dart';
part 'initiatives_details_state.dart';

class InitiativesDetailsBloc
    extends Bloc<InitiativesDetailsEvent, InitiativesDetailsState> {
  InitiativesDetailsBloc() : super(InitiativesDetailsInitial()) {
    on<InitiativesDetailsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
