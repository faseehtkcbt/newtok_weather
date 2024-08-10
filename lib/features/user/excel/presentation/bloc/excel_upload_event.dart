part of 'excel_upload_bloc.dart';

abstract class ExcelUploadEvent {}

class UploadExcel extends ExcelUploadEvent{
  final File? file;

  UploadExcel({required this.file});
}