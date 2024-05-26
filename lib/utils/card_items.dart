import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CardItems extends StatelessWidget {
  const CardItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        //Card Element
        padding: EdgeInsets.all(4),
        height: 90,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Color.fromRGBO(0, 0, 0, 0.1),
            )),
        child: Row(
          children: [
            ////Left
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Color.fromRGBO(0, 0, 0, 0.1),
                  )),
              width: 80,
              height: 80,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.asset(
                  "assets/images/background.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            //// Mid
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tour Tittle",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 3, horizontal: 4),
                            child: Icon(
                              FontAwesomeIcons.locationDot,
                              size: 15,
                              color:
                                  Color.fromRGBO(107, 107, 107, 1),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              "Tour Location; city, province",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 11),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            ////Right
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    "assets/images/icon-edit.svg",
                    width: 30,
                    height: 30,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    "assets/images/icon-delete.svg",
                    width: 30,
                    height: 30,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
