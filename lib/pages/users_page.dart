import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users Page'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),

      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("users").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No users found'));
          } else {
            final users = snapshot.data!.docs;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];



                //get data from each user
                String username = user['username'];
                String email = user['email'];



                return ListTile(
                  title: Text(username),
                  subtitle: Text(email),
                );
              },
            );
          }
        },
      ),
    );
  }
}
