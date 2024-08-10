part of 'user_list_bloc.dart';

abstract class UserListState {}

class UserListInitial extends UserListState {}

class UserListLoading extends UserListState {}
class UserListLoaded extends UserListState {
  final List<UserEntity> data;
  UserListLoaded({required this.data});

}
class UserListError extends UserListState {
  final Failures failure;
  UserListError({required this.failure});
}

