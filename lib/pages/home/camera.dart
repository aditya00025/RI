import 'package:flutter/material.dart';
// import 'package:flutter_unity_widget/flutter_unity_widget.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(204, 255, 255, 255),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Coming Soon!', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            const Text('Tap the button below for Amazing visualizations'),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.black, // Set the text color to white
              ),
              onPressed: () {
                // Future functionality: Capture image
              },
              child: const Text('Open ARVR Camera'),
            ),

            // Uncomment if you want to show a loading indicator
            // CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
