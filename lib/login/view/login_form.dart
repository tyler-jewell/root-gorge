import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:root_gorge/login/login.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.failure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
              ),
            );
        }
      },
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) => state.status == LoginStatus.inProgress
            ? Column(
                children: [
                  _PhoneNumberField(),
                  const SizedBox(height: 15),
                  _FullNameField(),
                  const SizedBox(height: 15),
                  _AuthButton(),
                ],
              )
            : Column(
                children: [
                  _SMSCodeField(),
                  const SizedBox(height: 15),
                  _AuthButton(),
                ],
              ),
      ),
    );
  }
}

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

class _FullNameField extends StatelessWidget {
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

class _SMSCodeField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.all(
            MediaQuery.of(context).size.width * 0.1,
          ),
          child: Column(
            children: [
              TextField(
                onChanged: (smsCode) =>
                    context.read<LoginCubit>().smsCodeChanged(smsCode),
                decoration: const InputDecoration(
                  labelText: 'Authentication code',
                  helperText:
                      'Enter the authentication code sent to your phone',
                ),
                keyboardType: TextInputType.phone,
              ),
            ],
          ),
        );
      },
    );
  }
}

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
