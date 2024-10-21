import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:google_fonts/google_fonts.dart';

// Home Widget - main stateful widget with BottomNavigationBar
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0; // Start with the Explore tab (index 0)

  @override
  void initState() {
    super.initState();
  }

  // Fetches user data from Firestore using the current user's UID
  Future<DocumentSnapshot> fetchUserData() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return await FirebaseFirestore.instance.collection('users').doc(uid).get();
  }

  // Screens for each tab in the BottomNavigationBar
  final List<Widget> _screens = [
    ExplorePage(), // Explore page
    const Center(child: Text('Camera Screen')), // Placeholder for Camera screen
    const ProfileScreen(), // Profile page with user details
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: _screens[_currentIndex], // Display the screen based on current tab
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // Active tab index
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Update the selected tab index
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Explore', // Explore tab
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: 'Camera', // Camera tab
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile', // Profile tab
          ),
        ],
        selectedItemColor: Colors.red[800], // Color for selected tab
        unselectedItemColor: Colors.black87, // Color for unselected tabs
        type: BottomNavigationBarType.fixed, // Prevent shifting behavior
      ),
    );
  }
}

// ExplorePage - a page for property exploration and recommendations
class ExplorePage extends StatelessWidget {
  final TextEditingController searchController = TextEditingController(); // Search field controller

  ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search Bar UI
                TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Try "Apartment in Mumbai"', // Search hint
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Horizontal List of Categories
                const Text(
                  'What can we help you find?',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 120, // Set the height for the horizontal list
                  color: Colors.white,
                  child: ListView(
                    scrollDirection: Axis.horizontal, // Scroll horizontally
                    children: const [
                      CategoryTile(title: "Flats", icon: Icons.house),
                      CategoryTile(title: "Bungalows", icon: Icons.bungalow),
                      CategoryTile(title: "Apartments", icon: Icons.apartment),
                      CategoryTile(title: "Cottages", icon: Icons.cottage),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Vertical List of Recommendations
                const Text(
                  'Recommended for you',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true, // Prevents the list from taking full space
                  physics: const NeverScrollableScrollPhysics(), // Prevent scrolling inside list
                  itemCount: 5, // Number of items in the list
                  itemBuilder: (context, index) {
                    return const PropertyTile(); // Property recommendation tile
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// CategoryTile - represents individual categories in ExplorePage
class CategoryTile extends StatelessWidget {
  final String title;
  final IconData icon;

  const CategoryTile({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: 120,
        height: 20,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: const Color.fromARGB(255, 0, 0, 0), size: 40),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(color: Color.fromARGB(255, 17, 0, 0)),
            ),
          ],
        ),
      ),
    );
  }
}

// PropertyTile - represents individual property recommendations in ExplorePage
class PropertyTile extends StatelessWidget {
  const PropertyTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images.jpg', // Placeholder image
            width: double.infinity,
            height: 250, // Set height for the image
            fit: BoxFit.cover, // Fit the image to the container
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Entire Cottage - Cozy Stay', // Property title
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'From ₹10,000/night', // Property price
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.yellow[600], size: 18),
                    const SizedBox(width: 4),
                    const Text('4.8', style: TextStyle(fontSize: 16)), // Property rating
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ProfileScreen - screen to display and manage user profile details
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<DocumentSnapshot> _userData; // Holds user data from Firestore
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _panController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _userData = fetchUserData(); // Fetch user data when screen is initialized
  }

  // Fetch user data based on the current user's UID
  Future<DocumentSnapshot> fetchUserData() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return await FirebaseFirestore.instance.collection('users').doc(uid).get();
  }

  Future<void> _updateUserInfo() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'name': _usernameController.text,
      'email': _emailController.text,
      'phoneNumber': _phoneController.text,
      'panCard': _panController.text,
    });
    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile updated successfully!')),
    );
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut(); // Sign out the user
    // You can navigate to the login screen here if needed
    Navigator.of(context).pop(); // Go back to the previous screen (if necessary)
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: _userData, // Fetch user data asynchronously
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator()); // Loading indicator
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}')); // Error message
        }

        // Extract user data from the snapshot
        Map<String, dynamic> userData = snapshot.data!.data() as Map<String, dynamic>;

        // Populate text controllers with user data
        _usernameController.text = userData['name'] ?? '';
        _emailController.text = userData['email'] ?? '';
        _phoneController.text = userData['phoneNumber'] ?? '';
        _panController.text = userData['panCard'] ?? '';

        return Scaffold(
          appBar: AppBar(title: const Text('Profile')), // Profile screen title
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Input fields for user details
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _phoneController,
                  decoration: const InputDecoration(labelText: 'Phone Number'),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _panController,
                  decoration: const InputDecoration(labelText: 'PAN Card Number'),
                ),
                const SizedBox(height: 30),
                
                // Update Profile button
                ElevatedButton(
                  onPressed: _updateUserInfo, // Update user information
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15), // Button padding
                    backgroundColor: Colors.red[800], // Button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // Rounded corners
                    ),
                    minimumSize: const Size(double.infinity, 60), // Full-width button

                  ),
                  child: Text(
                    'Update Profile',
                    style: GoogleFonts.poppins(fontSize: 16, color: Colors.white), // Button text style
                  ),
                ),
                const SizedBox(height: 16),

                // Logout button
                ElevatedButton(
                  onPressed: _logout, // Logout the user
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15), // Button padding
                    backgroundColor: const Color.fromARGB(255, 84, 56, 225), // Button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // Rounded corners
                    ),
                    minimumSize: const Size(double.infinity, 60), // Full-width button
                  ),
                  child: Text(
                    'Logout',
                    style: GoogleFonts.poppins(fontSize: 16, color: Colors.white), // Button text style
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
