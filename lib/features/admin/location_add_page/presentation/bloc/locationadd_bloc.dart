import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newtok_weather/core/failure/failures.dart';

import '../../domain/usecase/location_add_usecase.dart';

part 'locationadd_event.dart';
part 'locationadd_state.dart';

class LocationAddBloc extends Bloc<LocationAddEvent, LocationAddState> {
  final LocationAddUsecase _locUsecase;
  LocationAddBloc(LocationAddUsecase locUsecase)
      : _locUsecase = locUsecase,
        super(LocationAddInitial()) {
    on<LocationAddEvent>((event, emit) {
      emit(LocationAddLoading());
    });
    on<AddLocation>((event, emit) async {
      final response = await _locUsecase(LocationAddParams(
          country: event.country,
          state: event.state,
          district: event.district,
          city: event.city));
      response.fold(
          (l) => emit(LocationAddError(l)), (r) => emit(LocationAddLoaded(r)));
    });
  }
}
