import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemCard extends StatelessWidget {
  final String location;
  ItemCard(this.location, 
  // {required this.onUpdate, required this.onDelete}
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Text(location,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600, fontSize: 16,
            ),
            ),
          )
        ],
      ),
    );
  }
}