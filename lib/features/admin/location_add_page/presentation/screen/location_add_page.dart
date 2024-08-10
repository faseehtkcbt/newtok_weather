import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newtok_weather/features/admin/location_add_page/presentation/bloc/locationadd_bloc.dart';

import '../../../../../core/color_pallette/app_pallette.dart';
import '../../../../../core/utils/app_text.dart';
import '../../../../../core/utils/app_text_form_field.dart';
import '../../../../../core/utils/loader.dart';
import '../../../../../core/utils/snackbar.dart';

class LocationAddPage extends StatefulWidget {
  const LocationAddPage({super.key});

  @override
  State<LocationAddPage> createState() => _LocationAddPageState();
}

class _LocationAddPageState extends State<LocationAddPage> {
  final formKey = GlobalKey<FormState>();
  final countryController = TextEditingController();
  final stateController = TextEditingController();
  final cityController = TextEditingController();
  final districtController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: BlocConsumer<LocationAddBloc, LocationAddState>(
        listener: (context, location) {
          if (location is LocationAddLoaded) {
            showAppSnackBar(context, "Location successfully added !!! ");
            Navigator.pop(context);
          }
          if (location is LocationAddError) {
            showAppSnackBar(context, location.failure.message);
          }
        },
        builder: (context, location) {
          if (location is LocationAddLoading) {
            return const Center(child: Loader());
          }
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: 'Location Service',
                      textStyle: Theme.of(context).textTheme.titleMedium,
                      textSize: 25,
                      textColor: AppPellete.themeColor,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    AppText(
                      text: 'Country*',
                      textStyle: Theme.of(context).textTheme.bodyMedium,
                      textSize: 14,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    AppTextFormField(
                      controller: countryController,
                      hintText: 'Country',
                      textInputType: TextInputType.name,
                      filterPattern: RegExp('[a-zA-Z]'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter the country";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    AppText(
                      text: 'State*',
                      textStyle: Theme.of(context).textTheme.bodyMedium,
                      textSize: 14,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    AppTextFormField(
                      controller: stateController,
                      hintText: 'State',
                      textInputType: TextInputType.name,
                      filterPattern: RegExp('[a-zA-Z]'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter the state";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    AppText(
                      text: 'District*',
                      textStyle: Theme.of(context).textTheme.bodyMedium,
                      textSize: 14,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    AppTextFormField(
                      controller: districtController,
                      hintText: 'District',
                      textInputType: TextInputType.name,
                      filterPattern: RegExp('[a-zA-Z]'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter the district";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    AppText(
                      text: 'City*',
                      textStyle: Theme.of(context).textTheme.bodyMedium,
                      textSize: 14,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    AppTextFormField(
                      controller: cityController,
                      hintText: 'City',
                      textInputType: TextInputType.name,
                      filterPattern: RegExp('[a-zA-Z]'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter the city";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              fixedSize: const Size(500, 50)),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              context.read<LocationAddBloc>().add(AddLocation(
                                  country: countryController.text,
                                  state: stateController.text,
                                  district: districtController.text,
                                  city: cityController.text));
                            }
                          },
                          child: AppText(
                            text: "Add Location",
                            fontWeight: FontWeight.w600,
                            textStyle: Theme.of(context).textTheme.bodyMedium,
                            textColor: AppPellete.textWhiteColor,
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      )),
    );
  }
}
