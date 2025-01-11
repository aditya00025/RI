import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:flutter03/services/auth_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});

  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(76, 82, 202, 1),
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              // Background with animation
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
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
                        duration: Duration(seconds: 1),
                        child: Container(
                          decoration: BoxDecoration(
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
                        duration: Duration(milliseconds: 1200),
                        child: Container(
                          decoration: BoxDecoration(
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
                        duration: Duration(milliseconds: 1300),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/clock.png'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      child: FadeInUp(
                        duration: Duration(milliseconds: 1600),
                        child: Container(
                          margin: EdgeInsets.only(top: 100),
                          child: Center(
                            child: Text(
                              "Forgot Password",
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
              // Form Fields and Reset Password Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 60.0),
                child: Column(
                  children: <Widget>[
                    FadeInUp(
                      duration: Duration(milliseconds: 1800),
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Color.fromRGBO(23, 28, 125, 1)),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(143, 148, 251, .2),
                              blurRadius: 20.0,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                // border: Border(
                                //   bottom: BorderSide(color: Color.fromRGBO(255, 255, 255, 1)),
                                // ),
                              ),
                              child: TextField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Email Address",
                                  hintStyle: TextStyle(color: Colors.grey[700]),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    FadeInUp(
                      duration: Duration(milliseconds: 1900),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(103, 110, 240, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          minimumSize: Size(double.infinity, 60),
                          elevation: 0,
                        ),
                        onPressed: () async {
                          String email = _emailController.text.trim();

                          if (email.isEmpty) {
                            Fluttertoast.showToast(
                              msg: "Please enter your email",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.SNACKBAR,
                              backgroundColor: Colors.black54,
                              textColor: Colors.white,
                              fontSize: 14.0,
                            );
                            return;
                          }

                          try {
                            await AuthService().resetPassword(email: email);
                            Fluttertoast.showToast(
                              msg: "Password reset email sent!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.SNACKBAR,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 14.0,
                            );
                            Navigator.pop(context);
                          } catch (e) {
                            Fluttertoast.showToast(
                              msg: "Error sending reset email. Please try again.",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.SNACKBAR,
                              backgroundColor: Colors.redAccent,
                              textColor: Colors.white,
                              fontSize: 14.0,
                            );
                          }
                        },
                        child: Text(
                          "Reset Password",
                          style: TextStyle(color: Colors.white),
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
}
