import 'package:flutter/material.dart';

class WhiteContainer extends StatelessWidget {
  final String text;
 final IconData? icon;
  const WhiteContainer({Key? key, required this.text,this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 30,vertical: 13),
        child: Row(
          children: [
            Text(
              text , // Adding asterisk (*) to indicate required
              style: TextStyle(
                // Your text style here
                color: Color(0xff000000), // Change color as needed
                fontSize: 16, // Adjust font size as needed
                fontWeight: FontWeight.w300, // Adjust font weight as needed
              ),
            ),
            Spacer(),
            Icon(icon,color: Color(0xffDEDADA),)
          ],
        ),
      ),
    );
  }
}
