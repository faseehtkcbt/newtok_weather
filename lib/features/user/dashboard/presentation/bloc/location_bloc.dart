import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newtok_weather/core/entity/location_entity.dart';
import 'package:newtok_weather/core/failure/failures.dart';
import 'package:newtok_weather/core/usecase/usecase.dart';
import '../../domain/usecase/get_location_usecase.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final GetLocationUsecase _locationUsecase;
  LocationBloc(GetLocationUsecase locationUsecase)
      : _locationUsecase = locationUsecase,
        super(LocationInitial()) {
    on<LocationEvent>((event, emit) {
      emit(LocationLoading());
    });
    on<GetLocation>((event, emit) async {
      final response = await _locationUsecase(NoParam());
      response.fold((l) => emit(LocationError(failure: l)),
          (r) => emit(LocationLoaded(data: r)));
    });
  }
}
