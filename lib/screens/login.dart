import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController smsCodeController = TextEditingController();
  late ConfirmationResult confirmationResult;

  bool showAuthCode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: showAuthCode
          ? Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
              child: Column(
                children: [
                  TextField(
                    controller: smsCodeController,
                    decoration: const InputDecoration(
                      labelText: 'Authentication code',
                      helperText:
                          'Enter the authentication code sent to your phone',
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                      child: const Text('Login'),
                      onPressed: () async {
                        UserCredential result = await confirmationResult
                            .confirm(smsCodeController.text);
                        User? user = result.user;
                        if (user != null) {
                          user.updateDisplayName(nameController.text);
                        }
                      }),
                ],
              ),
            )
          : Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
              child: Column(
                children: [
                  TextField(
                    controller: phoneNumberController,
                    decoration: const InputDecoration(
                      labelText: 'Phone number',
                      helperText: 'Enter your phone number',
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Full name',
                      helperText: 'Enter your full name',
                    ),
                    keyboardType: TextInputType.name,
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    child: const Text('Send auth code'),
                    onPressed: () async {
                      confirmationResult =
                          await FirebaseAuth.instance.signInWithPhoneNumber(
                        '+1${phoneNumberController.text}',
                      );
                      setState(() {
                        showAuthCode = true;
                      });
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
