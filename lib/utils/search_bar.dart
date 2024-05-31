import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchBar extends StatelessWidget {
   SearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //SearchBar
      padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: TextFormField(
        decoration: InputDecoration(
            labelText: 'Search Destination',
            labelStyle:  TextStyle(
                color: Color.fromRGBO(0, 0, 0, 1), fontSize: 14),
            enabledBorder:  OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromRGBO(0, 0, 0, 0.1),
                  width: 2.0,
                ),
                borderRadius: BorderRadius.all(Radius.circular(12))),
            focusedBorder:  OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromRGBO(0, 0, 0, 0.3),
                  width: 2,
                ),
                borderRadius: BorderRadius.all(Radius.circular(12))),
            suffixIcon: IconButton(
              onPressed: () {},
              icon: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 8),
                child: SvgPicture.asset(
                  "assets/images/icon-search.svg",
                  width: 24,
                  height: 24,
                ),
              ),
            )),
      ),
    );
  }
}
