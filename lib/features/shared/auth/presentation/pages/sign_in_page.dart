import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/route/routes.dart';
import '../../../../../core/bloc/check_cubit/check_cubit.dart';
import '../../../../../core/color_pallette/app_pallette.dart';
import '../../../../../core/entity/user_entity.dart';
import '../../../../../core/utils/app_text.dart';
import '../../../../../core/utils/app_text_form_field.dart';
import '../../../../../core/utils/email_validation.dart';
import '../../../../../core/utils/loader.dart';
import '../../../../../core/utils/snackbar.dart';
import '../bloc/auth_bloc.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, authState) {
          if (authState is AuthSuccess<UserEntity>) {
            showAppSnackBar(context,
                "Hello ${authState.message.name} .Successfully registered !!! ");
            if(authState.message.role == 'Admin'){
              Navigator.pushNamedAndRemoveUntil(
                  context, Routes.adminDashboard, (route) => false);
            }
            else if(authState.message.role == 'User'){
              Navigator.pushNamedAndRemoveUntil(
                  context, Routes.userDashboard, (route) => false);
            }
            // Navigator.pushNamedAndRemoveUntil(
            //     context, Routes.selectCountryPage, (route) => false);
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
                      text: 'Hello',
                      textStyle: Theme.of(context).textTheme.titleMedium,
                      textColor: AppPellete.themeColor,
                      textSize: 40,
                    ),
                    AppText(
                      text: 'Again!',
                      textStyle: Theme.of(context).textTheme.titleMedium,
                      textSize: 35,
                    ),
                    AppText(
                      text: 'Welcome back you\'ve \nbeen missed',
                      textStyle: Theme.of(context).textTheme.bodyMedium,
                      textSize: 16,
                      textColor: AppPellete.textGreyColor,
                      maxLines: 2,
                    ),
                    const SizedBox(
                      height: 50,
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
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              fixedSize: const Size(500, 50)),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(LoginEvent(
                                  password: passwordController.text,
                                  email: emailController.text));
                            }
                          },
                          child: AppText(
                            text: "Sign In",
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
                          context, Routes.signUpPage, (route) => false),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppText(
                            text: "Don't have an Account? ",
                            textStyle: Theme.of(context).textTheme.bodyMedium,
                            textSize: 13,
                          ),
                          AppText(
                            text: "Sign Up ",
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
