import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocation_flutter/business_logic/cubits/togglePassword/toggle_password_cubit.dart';
import 'package:geolocation_flutter/constants/colors.dart';
import 'package:geolocation_flutter/presentation/widgets/text_widget.dart';

import '../../../business_logic/blocs/auth_status/auth_status_bloc.dart';
import '../../../business_logic/blocs/authentication/authentication_bloc.dart';
import '../../../routes.dart' as route;

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _admissionNumberController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final state = context.watch<TogglePasswordCubit>().state;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.topGradientColor,
                AppColors.bottomGradientColor,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ]),
              height: size.height * .85,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Registration',
                    style: TextStyle(
                        fontFamily: 'Ubuntu',
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        color: AppColors.blackColor),
                  ),
                  Container(
                    height: 3.7,
                    width: 40,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.topGradientColor,
                          AppColors.bottomGradientColor,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextField(
                          label: 'Admission Number',
                          controller: _admissionNumberController,
                          prefixIcon: const Icon(Icons.person_2_sharp),
                          placeholder: '123456'),
                      const SizedBox(height: 14),
                      CustomTextField(
                        label: 'First Name',
                        controller: _usernameController,
                        prefixIcon: const Icon(Icons.person_2_sharp),
                        placeholder: 'John (as per the school email)',
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      CustomTextField(
                        label: 'School Email',
                        controller: _emailController,
                        prefixIcon: const Icon(Icons.email_rounded),
                        placeholder: 'john.doe@strathmore.edu',
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      CustomTextField(
                        label: 'Enter Password',
                        controller: _passwordController,
                        password: true,
                        prefixIcon: const Icon(Icons.lock_outline),
                        obsecurePassword: state.passwordSignUpVisible,
                        placeholder: '********',
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      CustomTextField(
                        label: 'Confirm Password',
                        controller: _confirmPasswordController,
                        password: true,
                        prefixIcon: const Icon(Icons.lock_outline),
                        obsecurePassword: state.passwordSignUpVisible,
                        placeholder: '********',
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          gradient: const LinearGradient(
                            colors: [
                              AppColors.topGradientColor,
                              AppColors.bottomGradientColor,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            fixedSize: Size(size.width, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            //check if the email fit this format textnumber@daystar.ac.ke with regular expression and also check if all fields are filled
                            if (_emailController.text.isEmpty ||
                                _passwordController.text.isEmpty ||
                                _usernameController.text.isEmpty ||
                                _admissionNumberController.text.isEmpty ||
                                _confirmPasswordController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please fill all the fields'),
                                ),
                              );
                            } else {
                              //validate the email
                              if (!RegExp(r"^[a-zA-Z0-9.]+@(strathmore.edu)$")
                                  .hasMatch(_emailController.text)) {
                                Fluttertoast.showToast(
                                    msg: 'Please enter a valid Strathmore email');
                              } else {
                                if (_passwordController.text !=
                                    _confirmPasswordController.text) {
                                  Fluttertoast.showToast(
                                      msg: 'Passwords do not match');
                                } else {
                                  BlocProvider.of<AuthBloc>(context)
                                      .add(Register(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                    firstName: _usernameController.text,
                                    lastName: _usernameController.text,
                                    admisionNumber:
                                        _admissionNumberController.text,
                                  ));
                                }
                              }
                            }
                          },
                          child: BlocConsumer<AuthBloc, AuthState>(
                            listener: (context, state) {
                              if (state is AuthenticationError) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(state.errorMessage),
                                  ),
                                );
                              } else if (state is AuthenticationSuccess) {
                                context
                                    .read<AuthStatusBloc>()
                                    .add(CheckUserStatus());
                              } else if (state is RegistrationInProgress) {
                                Fluttertoast.showToast(msg: 'Loading...');
                              }
                            },
                            builder: (context, state) {
                              if (state is RegistrationInProgress) {
                                return const CircularProgressIndicator(
                                    color: AppColors.white);
                              } else {
                                return const Text(
                                  'Register',
                                  style: TextStyle(
                                      fontFamily: 'Ubuntu',
                                      fontSize: 20,
                                      color: AppColors.white),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(route.login);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 15),
                          // text span for the text login

                          child: const Text.rich(
                            TextSpan(
                              text: 'Already have an account? ',
                              style: TextStyle(
                                fontFamily: 'Ubuntu',
                                fontSize: 16,
                                color: AppColors.blackColor,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Login',
                                  style: TextStyle(
                                    fontFamily: 'Ubuntu',
                                    fontSize: 16,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
