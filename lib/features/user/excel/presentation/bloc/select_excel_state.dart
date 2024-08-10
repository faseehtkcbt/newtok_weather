part of 'select_excel_cubit.dart';

abstract class SelectExcelState {}

class SelectExcelInitial extends SelectExcelState {}

final class SelectExcelLoading extends SelectExcelState {}

final class SelectExcelLoaded extends SelectExcelState {
  File? file;
  SelectExcelLoaded(this.file);
}

final class SelectExcelError extends SelectExcelState {
  final Failures failure;
  SelectExcelError({required this.failure});
}
