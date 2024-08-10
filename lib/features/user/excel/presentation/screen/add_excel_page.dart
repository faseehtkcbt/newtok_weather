import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newtok_weather/core/color_pallette/app_pallette.dart';
import 'package:newtok_weather/core/utils/loader.dart';
import 'package:newtok_weather/core/utils/snackbar.dart';
import 'package:newtok_weather/features/user/excel/presentation/bloc/excel_upload_bloc.dart';

import '../../../../../core/utils/app_text.dart';
import '../../../../../core/utils/appbar_title.dart';
import '../bloc/select_excel_cubit.dart';

class AddExcelPage extends StatefulWidget {
  const AddExcelPage({super.key});

  @override
  State<AddExcelPage> createState() => _AddExcelPageState();
}

class _AddExcelPageState extends State<AddExcelPage> {
  File? file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppbarTitle(title: 'Excel Upload'),
      ),
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.all(20),
        child: BlocConsumer<ExcelUploadBloc, ExcelUploadState>(
          listener: (context, state) {
            if (state is ExcelUploadLoaded) {
              showAppSnackBar(context, "Excel successfully added !!! ");
              Navigator.pop(context);
            }
            if (state is ExcelUploadError) {
              showAppSnackBar(context, state.failure.message);
            }
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is ExcelUploadLoading) {
              return const Center(
                child: Loader(),
              );
            }
            return Column(
              children: [
                BlocConsumer<SelectExcelCubit, SelectExcelState>(
                  listener: (context, excelSelect) {
                    if (excelSelect is SelectExcelError) {
                      showAppSnackBar(context, excelSelect.failure.message);
                    }
                    // TODO: implement listener
                  },
                  builder: (context, excelSelect) {
                    if (excelSelect is SelectExcelLoading) {
                      return const SizedBox(
                        height: 200,
                        child: Center(
                          child: Loader(),
                        ),
                      );
                    }
                    if (excelSelect is SelectExcelLoaded) {
                      file = excelSelect.file;
                      return DottedBorder(
                        color: AppPellete.borderColor,
                        dashPattern: const [10, 4],
                        radius: const Radius.circular(10),
                        borderType: BorderType.RRect,
                        strokeCap: StrokeCap.round,
                        child: Container(
                          height: 200,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.folder_open,
                                size: 40,
                              ),
                              SizedBox(height: 15),
                              Text(
                                excelSelect.file?.path.split('/').last ?? '',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return GestureDetector(
                      onTap: () {
                        context.read<SelectExcelCubit>().pickExcel();
                      },
                      child: DottedBorder(
                        color: AppPellete.borderColor,
                        dashPattern: const [10, 4],
                        radius: const Radius.circular(10),
                        borderType: BorderType.RRect,
                        strokeCap: StrokeCap.round,
                        child: Container(
                          height: 200,
                          width: double.infinity,
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.folder_open,
                                size: 40,
                              ),
                              SizedBox(height: 15),
                              Text(
                                'Select your excel',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(500, 50)),
                      onPressed: () {
                        if (file != null) {
                          context
                              .read<ExcelUploadBloc>()
                              .add(UploadExcel(file: file));
                        } else {
                          showAppSnackBar(
                              context, 'Select an excel file first');
                        }
                      },
                      child: AppText(
                        text: "Upload",
                        fontWeight: FontWeight.w600,
                        textStyle: Theme.of(context).textTheme.bodyMedium,
                        textColor: AppPellete.textWhiteColor,
                      )),
                ),
              ],
            );
          },
        ),
      )),
    );
  }
}
