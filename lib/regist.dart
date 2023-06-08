import 'login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class Register extends StatelessWidget {
  
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
              fit: BoxFit.cover
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(screenWidth * 0.0025, screenHeight * 0.15, 0, screenHeight * 0.005),
                child: CircleAvatar(
                  radius: 100,
                  backgroundImage: AssetImage('weather-icons/Logo.png'),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(screenWidth * 0.1,screenHeight * 0.025,screenWidth * 0.1, screenHeight * 0.01),
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0)
                    ),
                    hintText: "Firstname"
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(screenWidth * 0.1,0,screenWidth * 0.1, screenHeight * 0.01),
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0)
                    ),
                    hintText: "Lastname"
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(screenWidth * 0.1,0,screenWidth * 0.1, screenHeight * 0.01),
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0)
                    ),
                    hintText: "Email"
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(screenWidth * 0.1,0,screenWidth * 0.1, screenHeight * 0.03),
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0)
                    ),
                    hintText: "Password"
                  ),
                ),
              ),
              Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0,0,0,screenWidth * 0.28),
                          child: SizedBox(
                            width: screenWidth * 0.7,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromARGB(255, 21, 94, 99),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                )
                              ),
                              onPressed: () => key,
                              child: const Text(
                                'REGISTER',style: TextStyle(fontWeight: FontWeight.bold)
                              ),
                            ),
                          )
                    ),
                  ),
                  Positioned(
                    top: screenHeight * 0.05,
                    left: screenWidth * 0.28,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0,0,0,0),
                      child: Row(
                        children: [
                              const Text(
                                'Sudah ada akun?',
                                style: TextStyle(
                                  fontFamily: 'Roboto'
                                  ),
                                ),
                              TextButton(
                                onPressed: (){
                                  Navigator.push(
                                    context, MaterialPageRoute(
                                      builder: (context) => LoginScreen()
                    
                                    )
                                  );
                                },
                                child: const Text(
                                  'LOGIN',style: TextStyle(fontWeight: FontWeight.bold)
                                ),
                              )
                            ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      )
    );
  }
}
