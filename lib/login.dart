import 'regist.dart';
import 'nav_bar.dart';
import 'package:flutter/material.dart';
import 'reusable_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Login createState() => Login();
}

class Login extends State<LoginScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('weather-icons/background_basic.jpeg'),
            fit: BoxFit.cover,
          )),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(screenWidth * 0.0025,
                    screenHeight * 0.15, 0, screenHeight * 0.05),
                child: CircleAvatar(
                  radius: 100,
                  backgroundImage: AssetImage('weather-icons/Logo.png'),
                ),
              ),
              reusableTextField("Username", Icons.person, false, _emailTextController),
              SizedBox(height: 10,),
              reusableTextField("Password", Icons.lock, true, _passwordTextController),
              Stack(
                children: [
                  // Align(
                  //   alignment: Alignment.topRight,
                  //   child: Container(
                  //     padding: EdgeInsets.fromLTRB(0, 0, screenWidth * 0.1, 0),
                  //     child: TextButton(
                  //       style: TextButton.styleFrom(
                  //         foregroundColor: Color.fromARGB(255, 116, 114, 114),
                  //       ),
                  //       child: Text(
                  //         "Lupa Sandi?",
                  //         style: TextStyle(
                  //             fontFamily: 'Roboto',
                  //             decoration: TextDecoration.underline),
                  //       ),
                  //       onPressed: () => key,
                  //     ),
                  //   ),
                  // ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                        padding: EdgeInsets.fromLTRB(
                            0, screenHeight * 0.1, 0, screenHeight * 0.195),
                        child: SizedBox(
                          width: screenWidth * 0.7,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 21, 94, 99),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                )),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CustomNavBar(),
                                  ));
                            },
                            child: const Text('LOGIN',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        )),
                  ),
                  Positioned(
                      bottom: screenHeight * 0.14,
                      left: screenWidth * 0.25,
                      child: Row(
                        children: [
                          const Text(
                            'Belum punya akun?',
                            style: TextStyle(fontFamily: 'Roboto'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Register()));
                            },
                            child: const Text(
                              'REGISTER',
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ))
                ],
              )
            ],
          )),
    ));
  }
}
