import 'package:flutter/material.dart';
import 'package:newhome/reusable_widget.dart';
import 'package:newhome/screens/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('weather-icons/background_basic.jpeg'))),
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
            child: Column(
              children: <Widget>[
                Container(
                  child: CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage('weather-icons/Logo.png'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Name", Icons.person_outline, false,
                    _userNameTextController),
                const SizedBox(
                  height: 10,
                ),
                reusableTextField("Username", Icons.person_outline, false,
                    _userNameTextController),
                const SizedBox(
                  height: 10,
                ),
                reusableTextField(
                    "Email", Icons.person_outline, false, _emailTextController),
                const SizedBox(
                  height: 10,
                ),
                reusableTextField("Password", Icons.lock_outlined, true,
                    _passwordTextController),
                const SizedBox(
                  height: 20,
                ),
                firebaseUIButton(context, "REGISTER", () {
                  FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text)
                      .then((value) {
                    print("Created New Account");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignInScreen()));
                  }).onError((error, stackTrace) {
                    print("Error ${error.toString()}");
                  });
                }),
                signUpOption()
              ],
            ),
          ))),
    );
  }
  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Sudah memiliki akun?",
            style: TextStyle(color: Colors.black)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignInScreen()));
          },
          child: const Text(
            " LOGIN",
            style: TextStyle(color: Color.fromARGB(255, 21, 94, 99), fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
