import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_learning/bloc/login/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginBloc _loginBloc;
  final FocusNode emailFouseNode = FocusNode();
  final FocusNode passwordFouseNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _loginBloc = LoginBloc();
  }

  @override
  void dispose() {
    super.dispose();
    _loginBloc.close();
    emailFouseNode.dispose();
    passwordFouseNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (_) => _loginBloc,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              BlocBuilder<LoginBloc, LoginState>(
                  buildWhen: (current, previous) =>
                      current.email != previous.email,
                  builder: (context, state) {
                    return TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      focusNode: emailFouseNode,
                      onChanged: (value) {
                        context
                            .read<LoginBloc>()
                            .add(EmailChanged(email: value));
                      },
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        enabledBorder: OutlineInputBorder(),
                      ),
                    );
                  }),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<LoginBloc, LoginState>(
                  buildWhen: (current, previous) =>
                      current.password != previous.password,
                  builder: (context, state) {
                    return TextFormField(
                      keyboardType: TextInputType.text,
                      focusNode: passwordFouseNode,
                      onChanged: (value) {
                        context
                            .read<LoginBloc>()
                            .add(PasswordChanged(password: value));
                      },
                      decoration: const InputDecoration(
                        hintText: 'Password',
                        enabledBorder: OutlineInputBorder(),
                      ),
                    );
                  }),
              const SizedBox(
                height: 40,
              ),
              BlocListener<LoginBloc, LoginState>(
                listenWhen: (current, previous) =>
                      current.loginStatus != previous.loginStatus,
                listener: (context, state) {
                  if (state.loginStatus == LoginStatus.error) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                          SnackBar(content: Text(state.message.toString())));
                  }
                  if (state.loginStatus == LoginStatus.loading) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        const SnackBar(
                          content: Text('Submitting...'),
                        ),
                      );
                  }
                  if (state.loginStatus == LoginStatus.success) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        const SnackBar(
                          content: Text('Login Successfull'),
                        ),
                      );
                  }
                },
                child: BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () {
                      context.read<LoginBloc>().add(LoginApi());
                    },
                    child: const Text('Login'),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
