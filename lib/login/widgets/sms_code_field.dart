import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:root_gorge/login/login.dart';

class SMSCodeField extends StatelessWidget {
  const SMSCodeField({super.key});

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
