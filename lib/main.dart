import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:root_gorge/firebase_options.dart';
import 'package:root_gorge/screens/login.dart';
import 'package:root_gorge/screens/map.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isSignedIn = false;

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() {
        isSignedIn = user != null;
      });
    });
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Field Marker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        bottomSheetTheme:
            const BottomSheetThemeData(backgroundColor: Colors.transparent),
      ),
      home: isSignedIn ? const Map() : const Login(),
    );
  }
}
