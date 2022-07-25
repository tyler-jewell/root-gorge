import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:root_gorge/login/login.dart';

class _AuthButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) => state.status == LoginStatus.gettingSMSCode
          ? ElevatedButton(
              child: const Text('Login'),
              onPressed: () => context.read<LoginCubit>().logInWithSMSCode(),
            )
          : ElevatedButton(
              child: const Text('Send auth code'),
              onPressed: () =>
                  context.read<LoginCubit>().logInWithPhoneNumber(),
            ),
    );
  }
}
