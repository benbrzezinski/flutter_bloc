import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_form_validation/bloc/auth_bloc.dart';
import 'package:login_form_validation/utils/show_error_snack_bar.dart';
import 'package:login_form_validation/widgets/gradient_button.dart';
import 'package:login_form_validation/widgets/loader.dart';
import 'package:login_form_validation/widgets/login_field.dart';
import 'package:login_form_validation/widgets/social_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            showErrorSnackBar(context, state.error);
            return;
          }

          if (state is AuthSuccess) {
            Navigator.of(context)
                .pushNamedAndRemoveUntil("/user", (route) => false);
          }
        },
        builder: (context, state) {
          if (state is AuthPending || state is AuthSuccess) {
            return const Loader();
          }

          return GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: SingleChildScrollView(
              clipBehavior: Clip.antiAlias,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    bottom: 30,
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/signin_balls.png',
                        filterQuality: FilterQuality.medium,
                        semanticLabel: "colorful balls",
                      ),
                      const Text(
                        'Sign in.',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                        ),
                      ),
                      const SizedBox(height: 50),
                      const SocialButton(
                        iconPath: 'assets/svgs/g_logo.svg',
                        label: 'Continue with Google',
                      ),
                      const SizedBox(height: 15),
                      const SocialButton(
                        iconPath: 'assets/svgs/f_logo.svg',
                        label: 'Continue with Facebook',
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'or',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(height: 15),
                      LoginField(
                        hintText: 'Email',
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 15),
                      LoginField(
                        hintText: 'Password',
                        controller: passwordController,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                      ),
                      const SizedBox(height: 30),
                      GradientButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(
                                AuthLoginRequested(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                ),
                              );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
