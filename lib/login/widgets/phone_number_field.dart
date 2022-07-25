import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:root_gorge/login/login.dart';

class _PhoneNumberField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) =>
          previous.phoneNumber != current.phoneNumber,
      builder: (context, state) {
        return TextField(
          decoration: const InputDecoration(
            labelText: 'Phone number',
            helperText: 'Enter your phone number',
          ),
          keyboardType: TextInputType.phone,
          onChanged: (phone) =>
              context.read<LoginCubit>().phoneNumberChanged(phone),
        );
      },
    );
  }
}
