part of 'excel_upload_bloc.dart';

abstract class ExcelUploadState {}
class ExcelUploadInitial extends ExcelUploadState {}
class ExcelUploadLoading extends ExcelUploadState {}
class ExcelUploadLoaded extends ExcelUploadState {
  final String message;
  ExcelUploadLoaded({required this.message});
}
class ExcelUploadError extends ExcelUploadState {
  final Failures failure;

  ExcelUploadError({required this.failure});
}

