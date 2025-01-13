// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ExplorePage extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();

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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    elevation: 5, // Add shadow effect
                    borderRadius: BorderRadius.circular(
                        30), // Match the search bar's border radius
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        hintText: 'Where to?',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              BorderSide.none, // Remove the border outline
                        ),
                        filled: true, // Optional: Add a background color
                        fillColor: Colors
                            .white, // Optional: Background color for contrast
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // StreamBuilder for Firestore data
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('properties')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return const Center(child: Text('Error loading data'));
                    }

                    final properties = snapshot.data?.docs ?? [];

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: properties.length,
                      itemBuilder: (context, index) {
                        final property = properties[index];
                        final title = property['title'] ?? 'No Title';
                        final price = property['price'] ?? 'No Price';
                        final imageUrl = property['imageUrl']?.isNotEmpty ==
                                true
                            ? property['imageUrl']
                            : 'assets/images/images.png'; // Fallback to default

                        return PropertyTile(
                          title: title,
                          price: price,
                          imageUrl: imageUrl,
                        );
                      },
                    );
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

class PropertyTile extends StatelessWidget {
  final String title;
  final String price;
  final String imageUrl;

  const PropertyTile({
    super.key,
    required this.title,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PropertyDetailsPage(
              title: title,
              price: price,
              imageUrl: imageUrl,
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: title,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(15),
                ),
                child: Image.network(
                  imageUrl,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 200,
                      color: Colors.grey[200],
                      child: const Center(
                        child: Icon(Icons.error, color: Colors.red, size: 40),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    price,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow, size: 20),
                      SizedBox(width: 4),
                      Text(
                        '4.8 (150 reviews)', // Replace with dynamic values
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PropertyDetailsPage extends StatelessWidget {
  final String title;
  final String price;
  final String imageUrl;

  const PropertyDetailsPage({
    super.key,
    required this.title,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            children: [
              Stack(
                children: [
                  Hero(
                    tag: title,
                    child: Image.network(
                      imageUrl,
                      width: double.infinity,
                      height: 400,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 400,
                          color: Colors.grey[200],
                          child: const Center(
                            child:
                                Icon(Icons.error, color: Colors.red, size: 40),
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    top: 40,
                    left: 16,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                  ),
                  const Positioned(
                    top: 40,
                    right: 16,
                    child: IconButton(
                      onPressed: null,
                      icon: Icon(Icons.favorite_border, color: Colors.white),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      child: const Row(
                        children: [
                          Icon(Icons.menu, color: Colors.white, size: 16),
                          SizedBox(width: 4),
                          Text(
                            'TAKE A TOUR',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      price,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Divider(color: Colors.grey),
                    const SizedBox(height: 16),
                    const Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'This is a placeholder description for the property. '
                      'Update this section to include real data fetched from Firestore.',
                      style: TextStyle(fontSize: 16, height: 1.5),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Amenities',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      children: [
                        Icon(Icons.pool, color: Colors.blue, size: 28),
                        SizedBox(width: 10),
                        Text('Swimming Pool', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      children: [
                        Icon(Icons.wifi, color: Colors.blue, size: 28),
                        SizedBox(width: 10),
                        Text('Free Wi-Fi', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Booking Successful')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: Colors.blue,
                      ),
                      child: const Text(
                        'BOOK NOW',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
