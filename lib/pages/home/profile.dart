// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter03/pages/home/home.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<DocumentSnapshot> _userData;

  @override
  void initState() {
    super.initState();
    _userData = fetchUserData();
  }

  Future<DocumentSnapshot> fetchUserData() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return await FirebaseFirestore.instance.collection('users').doc(uid).get();
  }

  void _navigateToPersonalInfo(Map<String, dynamic> userData) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PersonalInfoScreen(
          name: userData['name'] ?? '',
          email: userData['email'] ?? '',
          phone: userData['phoneNumber'] ?? '',
          pan: userData['panCard'] ?? '',
        ),
      ),
    );
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacementNamed('/');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: _userData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        Map<String, dynamic> userData =
            snapshot.data!.data() as Map<String, dynamic>;

        return Scaffold(
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    radius: 36,
                    backgroundColor: Colors.blue[700],
                    child: Text(
                      userData['name'][0].toUpperCase(),
                      style: const TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ),
                  title: Text(
                    userData['name'],
                    style: const TextStyle(fontSize: 24),
                  ),
                  subtitle: const Text('RI user'),
                  onTap: () {},
                  trailing: const SizedBox(height: 30),
                ),
                const SizedBox(height: 15),
                const Divider(),
                const ListTile(
                  title: Text(
                    'Personal Information',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.email),
                  title: const Text('Email'),
                  subtitle: Text(userData['email']),
                ),
                ListTile(
                  leading: const Icon(Icons.phone),
                  title: const Text('Phone Number'),
                  subtitle: Text(userData['phoneNumber']),
                ),
                ListTile(
                  leading: const Icon(Icons.credit_card),
                  title: const Text('PAN Card Number'),
                  subtitle: Text(userData['panCard']),
                ),
                const ListTile(
                  title: Text(
                    'Settings',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.update),
                  title: const Text('Update Profile'),
                  onTap: () => _navigateToPersonalInfo(userData),
                ),
                ListTile(
                    leading: const Icon(Icons.password),
                    title: const Text('Change Password'),
                    onTap: () {}),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text(
                    'Logout',
                    style: TextStyle(color: Colors.red),
                  ),
                  onTap: _logout,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}

class PersonalInfoScreen extends StatelessWidget {
  final String name;
  final String email;
  final String phone;
  final String pan;

  const PersonalInfoScreen({
    super.key,
    required this.name,
    required this.email,
    required this.phone,
    required this.pan,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController =
        TextEditingController(text: name);
    final TextEditingController phoneController =
        TextEditingController(text: phone);
    final TextEditingController panController =
        TextEditingController(text: pan);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const Text(
                'Update your personal information',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(Icons.phone),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: panController,
                decoration: InputDecoration(
                  labelText: 'PAN Card Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(Icons.credit_card),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .update({
                    'name': usernameController.text,
                    'phoneNumber': phoneController.text,
                    'panCard': panController.text,
                  }).then((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Profile updated successfully!')),
                    );
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                      (route) => false,
                    );
                  }).catchError((error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Failed to update profile: $error')),
                    );
                  });
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.blue[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  minimumSize: const Size(double.infinity, 60),
                ),
                child: const Text(
                  'Update Profile',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
