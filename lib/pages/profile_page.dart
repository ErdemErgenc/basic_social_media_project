import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_media_procet/auth/user_model.dart';
import 'package:social_media_procet/components/avatar.dart';
import 'package:social_media_procet/components/my_backButton.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  //current logged in user
  final User? user = FirebaseAuth.instance.currentUser;

  //future to fetch user details

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    final userId = user?.uid;
    if (userId != null) {
      return await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
    } else {
      throw Exception('User not logged in');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: getUserDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('User not found'));
          } else {
            final userData = snapshot.data!.data()!;
            return Padding(
              padding: const EdgeInsets.all(16.0),

              child: Center(
                child: Column(
                  children: [
                    Column(
                      children: [
                        //Avatar
                        Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: SpinningAvatar(),
                        ),

                        SizedBox(height: 20),

                        Text(
                          'Username: ${userData['username']}',
                          style: GoogleFonts.oswald().copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Email: ${userData['email']}',
                          style: GoogleFonts.sora().copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
