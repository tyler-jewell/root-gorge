import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:root_gorge/login/login.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
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
        builder: (context, state) => state.authCodeSent
            ? Column(
                children: const [
                  SMSCodeField(),
                  SizedBox(height: 15),
                  LoginButton(),
                ],
              )
            : Column(
                children: const [
                  PhoneNumberField(),
                  SizedBox(height: 15),
                  FullNameField(),
                  SizedBox(height: 15),
                  SendAuthButton(),
                ],
              ),
      ),
    );
  }
}
