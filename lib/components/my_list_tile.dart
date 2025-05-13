import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyListTile extends StatelessWidget {
  final String title;
  final String subTitle;
  const MyListTile({super.key, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(16),
        ),
        child: ListTile(
          title: Text(
            title,
            style: GoogleFonts.sora(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            subTitle,
            style: GoogleFonts.sora(
              fontSize: 13,
              fontWeight: FontWeight.w900,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
      ),
    );
  }
}
