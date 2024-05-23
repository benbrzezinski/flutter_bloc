import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_form_validation/app_bloc_observer.dart';
import 'package:login_form_validation/bloc/auth_bloc.dart';
import 'package:login_form_validation/screens/login_screen.dart';
import 'package:login_form_validation/colors/palette.dart';
import 'package:login_form_validation/screens/user_screen.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Palette.backgroundColor,
        ),
        initialRoute: "/",
        routes: {
          "/": (context) => const LoginScreen(),
          "/user": (context) => const UserScreen(),
        },
      ),
    );
  }
}
