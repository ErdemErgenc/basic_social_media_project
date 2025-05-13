import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                child: Icon(
                  Icons.sunny,
                  size: 50,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),

              SizedBox(height: 20),

              //home page
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: ListTile(
                  leading: Icon(
                    Icons.home,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  title: Text(
                    'H O M E',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);

                    // Navigate to the home page

                    Navigator.pushNamed(context, '/home');
                  },
                ),
              ),

              //profile page
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: ListTile(
                  leading: Icon(
                    Icons.person,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  title: Text(
                    'P R O F I L E',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);

                    // Navigate to the profile page

                    Navigator.pushNamed(context, '/profile_page');
                  },
                ),
              ),

              //user page
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: ListTile(
                  leading: Icon(
                    Icons.group,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  title: Text(
                    'U S E R S',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);

                    // Navigate to the user page

                    Navigator.pushNamed(context, '/users_page');
                  },
                ),
              ),
            ],
          ),

          //Logout
          Padding(
            padding: const EdgeInsets.only(left: 15, bottom: 25),
            child: ListTile(
              leading: Icon(
                Icons.logout,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              title: Text(
                'L O G O U T',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.pop(context);

                // Logout the user

                logout();
              },
            ),
          ),
        ],
      ),
    );
  }
}
