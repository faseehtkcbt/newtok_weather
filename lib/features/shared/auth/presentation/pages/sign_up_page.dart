import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newtok_weather/core/constants/constants.dart';
import 'package:newtok_weather/core/utils/app_drop_text_form.dart';
import '../../../../../config/route/routes.dart';
import '../../../../../core/bloc/check_cubit/check_cubit.dart';
import '../../../../../core/color_pallette/app_pallette.dart';
import '../../../../../core/utils/app_text.dart';
import '../../../../../core/utils/app_text_form_field.dart';
import '../../../../../core/utils/email_validation.dart';
import '../../../../../core/utils/loader.dart';
import '../../../../../core/utils/snackbar.dart';
import '../bloc/auth_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPswdController = TextEditingController();
  final emailController = TextEditingController();
  String? _selectedRole;
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    usernameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPswdController.clear();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, authState) {
          if (authState is AuthSuccess<String>) {
            showAppSnackBar(context, authState.message);
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.signInPage, (route) => false);
          }
          if (authState is AuthError) {
            showAppSnackBar(context, authState.error);
          }
        },
        builder: (context, authState) {
          if (authState is AuthLoading) {
            return const Center(child: Loader());
          }
          return SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: 'Hello!',
                      textStyle: Theme.of(context).textTheme.titleMedium,
                      textSize: 40,
                      textColor: AppPellete.themeColor,
                    ),
                    AppText(
                      text: 'SignUp to get Started',
                      textStyle: Theme.of(context).textTheme.bodyMedium,
                      textColor: AppPellete.textGreyColor,
                      textSize: 16,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    AppText(
                      text: 'UserName*',
                      textStyle: Theme.of(context).textTheme.bodyMedium,
                      textSize: 14,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    AppTextFormField(
                      controller: usernameController,
                      hintText: 'User Name',
                      textInputType: TextInputType.name,
                      filterPattern: RegExp('[a-z A-Z.]'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter the user name";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    AppText(
                      text: 'Email*',
                      textStyle: Theme.of(context).textTheme.bodyMedium,
                      textSize: 14,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    AppTextFormField(
                      controller: emailController,
                      textInputType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter an email address";
                        } else if (validateEmail(value)) {
                          return "Please enter a valid email address";
                        }
                        return null;
                      },
                      hintText: 'Email',
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    AppText(
                      text: 'Role*',
                      textStyle: Theme.of(context).textTheme.bodyMedium,
                      textSize: 14,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    AppDropTextForm(hintText: 'Select your role', dropDownList: Constants.roles, onChanged: (value){
                      _selectedRole = value;
                    }),
                    const SizedBox(
                      height: 10,
                    ),
                    AppText(
                      text: 'Password*',
                      textStyle: Theme.of(context).textTheme.bodyMedium,
                      textSize: 14,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    BlocProvider(
                      create: (context) => CheckCubit(),
                      child: BlocBuilder<CheckCubit, CheckState>(
                        builder: (context, state) {
                          if (state is CheckLoaded) {
                            return AppTextFormField(
                              controller: passwordController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter a password";
                                } else if (value.length < 8) {
                                  return "Password must contain least 8 characters";
                                }
                                return null;
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              hintText: 'Password',
                              textInputType: TextInputType.visiblePassword,
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    context
                                        .read<CheckCubit>()
                                        .onChecked(state.isChecked);
                                  },
                                  child: state.isChecked
                                      ? const Icon(Icons.visibility_rounded)
                                      : const Icon(
                                          Icons.visibility_off_rounded)),
                              isObscure: state.isChecked,
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    AppText(
                      text: 'Confirm Password*',
                      textStyle: Theme.of(context).textTheme.bodyMedium,
                      textSize: 14,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    BlocProvider(
                      create: (context) => CheckCubit(),
                      child: BlocBuilder<CheckCubit, CheckState>(
                        builder: (context, state) {
                          if (state is CheckLoaded) {
                            return AppTextFormField(
                              controller: confirmPswdController,
                              hintText: 'Confirm Password',
                              isObscure: state.isChecked,
                              textInputType: TextInputType.visiblePassword,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter a password";
                                } else if (value.length < 8) {
                                  return "Password must contain least 8 characters";
                                } else if (value != passwordController.text) {
                                  return "Password and Confirm password are must be same";
                                }
                                return null;
                              },
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    context
                                        .read<CheckCubit>()
                                        .onChecked(state.isChecked);
                                  },
                                  child: state.isChecked
                                      ? const Icon(Icons.visibility_rounded)
                                      : const Icon(
                                          Icons.visibility_off_rounded)),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              fixedSize: const Size(500, 50)),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(RegisterEvent(
                                  name: usernameController.text,
                                  password: passwordController.text,
                                  email: emailController.text,role: _selectedRole ?? ''));
                            }
                          },
                          child: AppText(
                            text: "Sign Up",
                            fontWeight: FontWeight.w600,
                            textStyle: Theme.of(context).textTheme.bodyMedium,
                            textColor: AppPellete.textWhiteColor,
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushNamedAndRemoveUntil(
                          context, Routes.signInPage, (route) => false),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppText(
                            text: "Already have an Account? ",
                            textStyle: Theme.of(context).textTheme.bodyMedium,
                            textSize: 13,
                          ),
                          AppText(
                            text: "Login ",
                            textSize: 13,
                            textStyle: Theme.of(context).textTheme.bodyMedium,
                            fontWeight: FontWeight.w600,
                            textColor: AppPellete.themeColor,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ));
        },
      ),
    );
  }
}
