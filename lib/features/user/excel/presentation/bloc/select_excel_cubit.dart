import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newtok_weather/core/failure/failures.dart';

part 'select_excel_state.dart';

class SelectExcelCubit extends Cubit<SelectExcelState> {
  SelectExcelCubit() : super(SelectExcelInitial());

  void pickExcel() async {
    emit(SelectExcelLoading());
    try {
      File? _file;
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx', 'xls'],
      );
      if (result != null) {
        _file = File(result.files.single.path!);
        emit(SelectExcelLoaded(_file));
      } else {
        emit(SelectExcelError(failure: Failures(message: 'Try Again!!')));
      }
    } catch (e) {
      emit(SelectExcelError(failure: Failures(message: e.toString())));
    }
  }
}
