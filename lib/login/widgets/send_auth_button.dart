import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:root_gorge/login/login.dart';

class SendAuthButton extends StatelessWidget {
  const SendAuthButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text('Send auth code'),
      onPressed: () => context.read<LoginCubit>().logInWithPhoneNumber(),
    );
  }
}
