// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter03/pages/signup/signup.dart';
import 'package:flutter03/pages/forgot_password/forgot_password.dart'; // Import the forgot password page
import 'package:flutter03/services/auth_service.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: _signup(context),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(76, 82, 202, 1),
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.zero, // Remove all padding to avoid gaps
          child: Column(
            children: [
              // Background with animation
              Container(
                height: MediaQuery.of(context).size.height *
                    0.4, // Adjust height to 40% of screen height
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/background.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 30,
                      width: 80,
                      height: 200,
                      child: FadeInUp(
                        duration: const Duration(seconds: 1),
                        child: Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/light-1.png'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 140,
                      width: 80,
                      height: 150,
                      child: FadeInUp(
                        duration: const Duration(milliseconds: 1200),
                        child: Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/light-2.png'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 40,
                      top: 40,
                      width: 80,
                      height: 150,
                      child: FadeInUp(
                        duration: const Duration(milliseconds: 1300),
                        child: Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/clock.png'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      child: FadeInUp(
                        duration: const Duration(milliseconds: 1600),
                        child: Container(
                          margin: const EdgeInsets.only(top: 50),
                          child: const Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Form Fields and Sign In Button
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 60.0), // Adjusted padding
                child: Column(
                  children: <Widget>[
                    FadeInUp(
                      duration: const Duration(milliseconds: 1800),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color:
                                      const Color.fromRGBO(180, 180, 232, 1)),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(143, 148, 251, .2),
                                  blurRadius: 20.0,
                                  offset: Offset(0, 10),
                                )
                              ],
                            ),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          color:
                                              Color.fromRGBO(255, 255, 255, 1)),
                                    ),
                                  ),
                                  child: TextField(
                                    controller: _emailController,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Email Address",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color:
                                      const Color.fromRGBO(180, 180, 232, 1)),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(143, 148, 251, .2),
                                  blurRadius: 20.0,
                                  offset: Offset(0, 10),
                                )
                              ],
                            ),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller: _passwordController,
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Password",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    FadeInUp(
                      duration: const Duration(milliseconds: 1900),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromRGBO(103, 110, 240, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          minimumSize: const Size(double.infinity, 60),
                          elevation: 0,
                        ),
                        onPressed: () async {
                          String email = _emailController.text.trim();
                          String password = _passwordController.text.trim();

                          if (email.isEmpty || password.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text("Email and password cannot be empty"),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }

                          try {
                            await AuthService().signin(
                              email: email,
                              password: password,
                              context: context,
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text("Login failed. Please try again."),
                                backgroundColor: Colors.redAccent,
                              ),
                            );
                          }
                        },
                        child: const Text(
                          "Sign In",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 70),
                    FadeInUp(
                      duration: const Duration(milliseconds: 2000),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgotPasswordPage(),
                            ),
                          );
                        },
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: Color.fromRGBO(62, 71, 246, 1),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signup(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            const TextSpan(
              text: "New User? ",
              style: TextStyle(
                color: Color(0xff6A6A6A),
                fontWeight: FontWeight.normal,
                fontSize: 16,
              ),
            ),
            TextSpan(
              text: "Create Account",
              style: const TextStyle(
                color: Color.fromRGBO(62, 71, 246, 1),
                fontWeight: FontWeight.normal,
                fontSize: 16,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignupPage(),
                    ),
                  );
                },
            ),
          ],
        ),
      ),
    );
  }
}
