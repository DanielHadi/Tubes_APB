import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newhome/admin/admin_article.dart';
import 'package:newhome/nav_bar.dart';
import 'package:newhome/reusable_widget.dart';
import 'package:newhome/screens/reset_password.dart';
import 'signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('weather-icons/background_basic.jpeg'))),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
                logoWidget("weather-icons/Logo.png"),
                const SizedBox(
                  height: 30,
                ),
                reusableTextField(
                    "Email", Icons.person_outline, false, _emailTextController),
                const SizedBox(
                  height: 10,
                ),
                reusableTextField("Kata Sandi", Icons.lock_outline, true,
                    _passwordTextController),
                const SizedBox(
                  height: 20,
                ),
                forgetPassword(context),
                firebaseUIButton(context, "LOGIN", () {
                  FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text)
                      .then((value) {
                    // Mengambil data pengguna saat ini
                    User? user = FirebaseAuth.instance.currentUser;

                    // Mengambil dokumen pengguna dari koleksi 'users' berdasarkan ID pengguna
                    FirebaseFirestore.instance
                        .collection('users')
                        .where('email', isEqualTo: user!.email)
                        .get()
                        .then((docSnapshot) {
                      if (docSnapshot.docs.isNotEmpty) {
                        DocumentReference docRef =
                            docSnapshot.docs[0].reference;
                        docRef.get().then((value) {
                          if (value.exists) {
                            Map<String, dynamic> userData =
                                value.data() as Map<String, dynamic>;
                            bool isAdmin = userData['isAdmin'] ?? false;

                            if (isAdmin) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Berhasil Login sebagai Admin!')));
                              Future.delayed(const Duration(seconds: 1), () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AdminArticlePage()));
                              });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Berhasil Login!')));

                              Future.delayed(const Duration(seconds: 1), () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const CustomNavBar()));
                              });
                            }
                          }
                        });
                      }
                    });
                  }).onError((error, stackTrace) {
                    print("Error ${error.toString()}");
                  });
                }),
                signUpOption()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Belum memiliki akun?",
            style: TextStyle(color: Colors.black)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: const Text(
            " REGISTER",
            style: TextStyle(
                color: Color.fromARGB(255, 21, 94, 99),
                fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Widget forgetPassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: const Text(
          "Lupa Kata Sandi?",
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.right,
        ),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => ResetPassword())),
      ),
    );
  }
}
