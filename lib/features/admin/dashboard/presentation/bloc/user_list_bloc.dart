import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newtok_weather/core/entity/user_entity.dart';
import 'package:newtok_weather/core/failure/failures.dart';

import '../../../../../core/usecase/usecase.dart';
import '../../domain/usecase/get_users_usecase.dart';

part 'user_list_event.dart';
part 'user_list_state.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  final GetUsersUsecase _getUsers;
  UserListBloc(GetUsersUsecase getUsers) :_getUsers = getUsers, super(UserListInitial()) {
    on<UserListEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetUsers>((event, emit) async {
      final response = await _getUsers(NoParam());
      response.fold((l) => emit(UserListError(failure: l)),
              (r) => emit(UserListLoaded(data: r)));
    });
  }
}
