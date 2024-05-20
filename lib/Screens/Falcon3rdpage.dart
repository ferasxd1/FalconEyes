import 'package:falconeyes/Screens/Falcon4thpage.dart';
import 'package:falconeyes/Screens/Falcon5thpage.dart';
import 'package:falconeyes/Widgets/ButtonWidget.dart';
import 'package:falconeyes/ui/home_view.dart';
import 'package:flutter/material.dart';

class FalconListScreen extends StatefulWidget {
  const FalconListScreen({super.key});

  @override
  State<FalconListScreen> createState() => _FalconListScreenState();
}

class _FalconListScreenState extends State<FalconListScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xffE8E8E8),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 220,
            decoration: BoxDecoration(
                color: Color(0xff3685CD),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                )),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      "assets/logo.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    "the list".toUpperCase(),
                    style: TextStyle(
                      color: Color(
                        0xffffffff,
                      ),
                      fontSize: 45,
                      fontWeight: FontWeight.w500,
                      fontFamily: "sans-serif",
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 100),
            child: Column(
              children: [
                GestureDetector(
                   onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeView()),
                      );
                    },
                  child: ButtonWidget(
                    buttonText: 'Object  detection',
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NotficationScreen()),
                      );
                    },
                    child: ButtonWidget(
                      buttonText: 'Notifications',
                    )),
                SizedBox(
                  height: 50,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyAccount()),
                    );
                  },
                  child: ButtonWidget(
                    buttonText: 'My Account',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
