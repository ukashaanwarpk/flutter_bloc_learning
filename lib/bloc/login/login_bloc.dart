import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
part 'login_state.dart';
part 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState()) {
    on<EmailChanged>(_emailChanged);
    on<PasswordChanged>(_passwordChanged);
    on<LoginApi>(_loginApi);
  }

  void _emailChanged(EmailChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _passwordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _loginApi(LoginApi event, Emitter<LoginState> emit) async {
    state.copyWith(loginStatus: LoginStatus.loading);

    Map data = {'email': state.email, 'password': state.password};

    try {
      final response =
          await http.post(Uri.parse('https://reqres.in/api/login'), body: data);

      final jsonData = jsonDecode(response.body.toString());

      if (response.statusCode == 200) {
        emit(state.copyWith(
            loginStatus: LoginStatus.success, message: 'Login Successful'));
      } else {
        emit(state.copyWith(
            loginStatus: LoginStatus.error, message: jsonData['error']));
      }
    } catch (e) {
      debugPrint('The error in _loginApi $e');
      emit(
        state.copyWith(
          loginStatus: LoginStatus.error,
          message: e.toString(),
        ),
      );
    }
  }
}
