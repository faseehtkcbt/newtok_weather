import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newtok_weather/core/failure/failures.dart';

import '../../domain/usecase/excel_upload_usecase.dart';

part 'excel_upload_event.dart';
part 'excel_upload_state.dart';

class ExcelUploadBloc extends Bloc<ExcelUploadEvent, ExcelUploadState> {
  final ExcelUploadUsecase _usecase;
  ExcelUploadBloc(ExcelUploadUsecase usecase) :_usecase = usecase, super(ExcelUploadInitial()) {
    on<ExcelUploadEvent>((event, emit) {
      emit(ExcelUploadLoading());
    });
    on<UploadExcel>((event,emit)async{
      final response = await _usecase(ExcelUploadParams(file: event.file));
      response.fold(
              (l) => emit(ExcelUploadError(failure: l)), (r) => emit(ExcelUploadLoaded(message: r)));
    });
  }
}
