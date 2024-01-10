import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocation_flutter/business_logic/blocs/auth_status/auth_status_bloc.dart';
import 'package:geolocation_flutter/business_logic/cubits/togglePassword/toggle_password_cubit.dart';
import 'package:geolocation_flutter/constants/colors.dart';
import 'package:geolocation_flutter/presentation/widgets/text_widget.dart';

import '../../../business_logic/blocs/authentication/authentication_bloc.dart';
import '../../../routes.dart' as route;

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<TogglePasswordCubit>().state;
    final size = MediaQuery.of(context).size;
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
              height: size.height * .55,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Login',
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
                        controller: _usernameController,
                        prefixIcon: const Icon(Icons.person_2_sharp),
                        placeholder: '123456',
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      CustomTextField(
                        label: 'Enter Password',
                        controller: _passwordController,
                        obsecurePassword: state.passwordLoginVisible,
                        password: true,
                        login: true,
                        prefixIcon: const Icon(Icons.lock_outline),
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
                                end: Alignment.bottomRight)),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            fixedSize: Size(size.width, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            if (_usernameController.text.isEmpty ||
                                _passwordController.text.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: 'All fields are required!');
                            } else {
                              context.read<AuthBloc>().add(Login(
                                    username: _usernameController.text,
                                    password: _passwordController.text,
                                  ));
                            }

                            // Navigator.pushReplacementNamed(
                            //     context, route.dashboard);
                          },
                          child: BlocConsumer<AuthBloc, AuthState>(
                            listener: (context, state) {
                              if (state is AuthenticationError) {
                                Fluttertoast.showToast(msg: state.errorMessage);
                              } else if (state is AuthenticationSuccess) {
                                context
                                    .read<AuthStatusBloc>()
                                    .add(CheckUserStatus());
                                // Navigator.pushReplacementNamed(
                                //     context, route.dashboard);
                              } else if (state is LoginInProgress) {
                                Fluttertoast.showToast(msg: 'Logging in...');
                              }
                            },
                            builder: (context, state) {
                              if (state is LoginInProgress) {
                                return const CircularProgressIndicator(
                                  color: AppColors.white,
                                );
                              } else {
                                return const Text('Login',
                                    style: TextStyle(
                                        fontFamily: 'Ubuntu',
                                        fontSize: 20,
                                        color: AppColors.white));
                              }
                            },
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Container(
                              margin: const EdgeInsets.only(top: 15),
                              child: const Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontWeight: FontWeight.bold,
                                  textBaseline: TextBaseline.alphabetic,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(route.signUp);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(top: 15),
                              child: const Text('Create an account',
                                  style: TextStyle(
                                      fontFamily: 'Ubuntu',
                                      fontWeight: FontWeight.bold,
                                      textBaseline: TextBaseline.alphabetic,
                                      color: AppColors.primary)),
                            ),
                          ),
                        ],
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
