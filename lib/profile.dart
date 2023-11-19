import 'package:flutter/material.dart';

void main() {
  runApp(ProfileApp());
}

class ProfileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('assets/profile_image.jpg'),
            ),
            Text(
              'John Doe',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Software Developer',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Text(
              'Contact: john@example.com',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Bio: A passionate developer with a love for coding.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            PortfolioItem(
              title: 'Project 1',
              description: 'Description of Project 1.',
            ),
            PortfolioItem(
              title: 'Project 2',
              description: 'Description of Project 2.',
              certificateImageURL:
              'https://ibb.co/6Pc65X4', // Certificate image URL
            ),
            // Add more portfolio items as needed.
          ],
        ),
      ),
    );
  }
}

class PortfolioItem extends StatelessWidget {
  final String title;
  final String description;
  final String? certificateImageURL; // Certificate image URL (optional)

  PortfolioItem({
    required this.title,
    required this.description,
    this.certificateImageURL,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(title),
            subtitle: Text(description),
          ),
          if (certificateImageURL != null)
            Image.network(
              certificateImageURL!,
              fit: BoxFit.cover,
              height: 200, // Adjust the height as needed
            ),
          // Add more details or links to the project as needed.
        ],
      ),
    );
  }
}
