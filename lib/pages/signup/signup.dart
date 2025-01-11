import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter03/services/auth_service.dart'; // Import your AuthService
import 'package:animate_do/animate_do.dart';

class SignupPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController panCardController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  final AuthService _authService = AuthService();

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
                          margin: EdgeInsets.only(top: 50),
                          child: Center(
                            child: Text(
                              "Signup",
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
              // Form Fields and Sign Up Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                child: Column(
                  children: <Widget>[
                    FadeInUp(
                      duration: Duration(milliseconds: 1800),
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Color.fromRGBO(255, 255, 255, 1)),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(143, 148, 251, .2),
                              blurRadius: 20.0,
                              offset: Offset(0, 10),
                            )
                          ],
                        ),
                        child: Column(
                          children: <Widget>[
                            _name(),
                            const SizedBox(height: 20),
                            _emailAddress(),
                            const SizedBox(height: 20),
                            _password(),
                            const SizedBox(height: 20),
                            _panCard(),
                            const SizedBox(height: 20),
                            _phoneNumber(),
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
                        onPressed: () {
                          _authService.signup(
                            name: nameController.text.trim(),
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                            panCard: panCardController.text.trim(),
                            phoneNumber: phoneNumberController.text.trim(),
                            context: context,
                          );
                        },
                        child: Text(
                          "Signup",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: 70),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

Widget _name() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Name', style: GoogleFonts.raleway(color: Colors.black, fontSize: 16)),
      const SizedBox(height: 16),
      TextField(
        controller: nameController,
        decoration: InputDecoration(
          filled: true,
          hintText: 'Enter your name',
          //hintStyle: TextStyle(color: Color(0xff6A6A6A), fontSize: 14),
          fillColor: Color.fromARGB(255, 255, 255, 255),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 1.5), // Border color and width
            borderRadius: BorderRadius.circular(14),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 1.5), // Border when enabled
            borderRadius: BorderRadius.circular(14),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green, width: 2.0), // Border when focused
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    ],
  );
}

Widget _emailAddress() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Email Address', style: GoogleFonts.raleway(color: Colors.black, fontSize: 16)),
      const SizedBox(height: 16),
      TextField(
        controller: emailController,
        decoration: InputDecoration(
          filled: true,
          hintText: 'Enter your email',
          //hintStyle: TextStyle(color: Color(0xff6A6A6A), fontSize: 14),
          fillColor: Color.fromARGB(255, 255, 255, 255),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 1.5), // Border color and width
            borderRadius: BorderRadius.circular(14),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 1.5), // Border when enabled
            borderRadius: BorderRadius.circular(14),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green, width: 2.0), // Border when focused
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    ],
  );
}

Widget _password() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Password', style: GoogleFonts.raleway(color: Colors.black, fontSize: 16)),
      const SizedBox(height: 16),
      TextField(
        obscureText: true,
        controller: passwordController,
        decoration: InputDecoration(
          filled: true,
          hintText: 'Enter your password',
          fillColor: Color.fromARGB(255, 255, 255, 255),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 1.5), // Border color and width
            borderRadius: BorderRadius.circular(14),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 1.5), // Border when enabled
            borderRadius: BorderRadius.circular(14),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green, width: 2.0), // Border when focused
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    ],
  );
}

Widget _panCard() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('PAN Card', style: GoogleFonts.raleway(color: Colors.black, fontSize: 16)),
      const SizedBox(height: 16),
      TextField(
        controller: panCardController,
        decoration: InputDecoration(
          filled: true,
          hintText: 'Enter your PAN card number',
          //hintStyle: TextStyle(color: Color(0xff6A6A6A), fontSize: 14),
          fillColor: Color.fromARGB(255, 255, 255, 255),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 1.5), // Border color and width
            borderRadius: BorderRadius.circular(14),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 1.5), // Border when enabled
            borderRadius: BorderRadius.circular(14),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green, width: 2.0), // Border when focused
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    ],
  );
}

Widget _phoneNumber() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Phone Number', style: GoogleFonts.raleway(color: Colors.black, fontSize: 16)),
      const SizedBox(height: 16),
      TextField(
        controller: phoneNumberController,
        decoration: InputDecoration(
          filled: true,
          hintText: 'Enter your phone number',
          //hintStyle: TextStyle(color: Color(0xff6A6A6A), fontSize: 14),
          fillColor: Color.fromARGB(255, 255, 255, 255),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 1.5), // Border color and width
            borderRadius: BorderRadius.circular(14),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 1.5), // Border when enabled
            borderRadius: BorderRadius.circular(14),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green, width: 2.0), // Border when focused
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    ],
  );
}
}
