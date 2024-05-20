import 'package:flutter/material.dart';

class WhiteContainerPassword extends StatefulWidget {
  final String text;
  final IconData? icon;

  const WhiteContainerPassword({Key? key, required this.text, this.icon}) : super(key: key);

  @override
  _WhiteContainerPasswordState createState() => _WhiteContainerPasswordState();
}

class _WhiteContainerPasswordState extends State<WhiteContainerPassword> {
  bool _isPasswordVisible = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

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
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        child: Row(
          children: [
            Text(
              _isPasswordVisible ? widget.text : '•' * widget.text.length,
              style: TextStyle(
                color: Color(0xff000000),
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: IconButton(
                
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Color(0xffDEDADA),
                  size: 30,
                ),
                onPressed: _togglePasswordVisibility,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
