import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginRequested>(_onAuthLoginRequested);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
  }

  void _onAuthLoginRequested(
      AuthLoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthPending());

    final email = event.email;
    final password = event.password;

    if (!email.contains("@")) {
      emit(AuthFailure("Email must contain - @"));
      return;
    }

    if (password.length < 6) {
      emit(AuthFailure("Password cannot be less than 6 characters"));
      return;
    }

    try {
      await Future.delayed(const Duration(seconds: 1), () {
        emit(AuthSuccess("$email-$password"));
      });
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  void _onAuthLogoutRequested(
      AuthLogoutRequested event, Emitter<AuthState> emit) async {
    emit(AuthPending());

    try {
      await Future.delayed(const Duration(seconds: 1), () {
        emit(AuthInitial());
      });
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
