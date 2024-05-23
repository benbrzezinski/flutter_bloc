import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_form_validation/bloc/auth_bloc.dart';
import 'package:login_form_validation/utils/show_error_snack_bar.dart';
import 'package:login_form_validation/widgets/loader.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            showErrorSnackBar(context, state.error);
            return;
          }

          if (state is AuthInitial) {
            Navigator.of(context)
                .pushNamedAndRemoveUntil("/", (route) => false);
          }
        },
        builder: (context, state) {
          if (state is AuthPending || state is AuthInitial) {
            return const Loader();
          }

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: state is AuthSuccess
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Email: ${state.uid.split("-")[0]}"),
                        const SizedBox(
                          height: 10,
                        ),
                        Text("Password: ${state.uid.split("-")[1]}"),
                        const SizedBox(
                          height: 30,
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            context.read<AuthBloc>().add(AuthLogoutRequested());
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(20),
                          ),
                          label: const Text("Logout"),
                          icon: const Icon(Icons.logout),
                        )
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("User login failed :("),
                        const SizedBox(
                          height: 30,
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamedAndRemoveUntil("/", (route) => false);
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(20),
                          ),
                          label: const Text("Back to login page"),
                          icon: const Icon(Icons.arrow_back_ios_new),
                        ),
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }
}
