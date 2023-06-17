import 'package:flutter/material.dart';
import 'admin/admin_article.dart';
import 'screens/signin_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'profile.dart';
import 'package:newhome/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyDT13jcWekuPINhEs2sH-mZgVASoeiwwsM',
          appId: '1:90922324784:web:18e63becaa6020d3832ef5',
          messagingSenderId: '90922324784',
          projectId: 'tubes-apb-a8acc'));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Bulls App',
      home: SignInScreen(),
    );
  }
}
