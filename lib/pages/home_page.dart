import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_media_procet/components/my_drawer.dart';
import 'package:social_media_procet/components/my_list_tile.dart';
import 'package:social_media_procet/components/my_post_button.dart';
import 'package:social_media_procet/components/my_textfield.dart';
import 'package:social_media_procet/database/firestore.dart';
import 'package:social_media_procet/pages/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  //text controller

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirestoreDatabase database = FirestoreDatabase();

  final TextEditingController newPostController = TextEditingController();

  void postMessage() {
    if (newPostController.text.isNotEmpty) {
      String message = newPostController.text;
      database.addPost(message);
    }

    //clear textfield
    newPostController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),

      drawer: MyDrawer(),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            //Textfields box for user to type
            Row(
              children: [
                //textfield
                Expanded(
                  child: MyTextfield(
                    hintText: "Let's Say Something...",
                    obscureText: false,
                    controller: newPostController,
                  ),
                ),
                SizedBox(width: 10),

                //Post button
                MyPostButton(
                  onTap: () {
                    postMessage();
                  },
                ),
              ],
            ),
            SizedBox(height: 20),

            //Posts
            StreamBuilder(
              stream: database.getPostsStream(),
              builder: (context, snapshot) {
                //show loading circle
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                //get all posts
                final posts = snapshot.data!.docs;

                //no data?
                if (posts.isEmpty) {
                  return const Center(child: Text('No posts found'));
                }

                //return as a list
                return Expanded(
                  child: ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index];

                      String message = post['PostMessage'];
                      String userEmail = post['UserEmail'];
                      Timestamp timestamp = post['TimeStamp'];

                      return MyListTile(title: message, subTitle: userEmail);
                    },
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
