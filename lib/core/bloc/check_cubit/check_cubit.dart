import 'package:flutter_bloc/flutter_bloc.dart';

part 'check_state.dart';

class CheckCubit extends Cubit<CheckState> {
  CheckCubit() : super(CheckLoaded(false));

  void onChecked(bool check) {
    emit(CheckLoaded(!check));
  }
}
