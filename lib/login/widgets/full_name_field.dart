import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:root_gorge/login/login.dart';

class FullNameField extends StatelessWidget {
  const FullNameField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.fullName != current.fullName,
      builder: (context, state) {
        return TextField(
          decoration: const InputDecoration(
            labelText: 'Full name',
            helperText: 'Enter your full name',
          ),
          keyboardType: TextInputType.name,
          onChanged: (name) => context.read<LoginCubit>().fullNameChanged(name),
        );
      },
    );
  }
}
