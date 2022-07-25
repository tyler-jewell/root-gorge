import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:root_gorge/login/login.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text('Login'),
      onPressed: () => context.read<LoginCubit>().logInWithSMSCode(),
    );
  }
}
