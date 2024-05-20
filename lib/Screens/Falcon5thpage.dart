import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:falconeyes/Widgets/white_container_password.dart';
import 'package:falconeyes/Widgets/white_container_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  late Stream<DocumentSnapshot> userStream;
  late FirebaseFirestore _firestore;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    String collectionName = "Users";

    _firestore = FirebaseFirestore.instance;
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    userStream = _firestore.collection(collectionName).doc(uid).snapshots();
  }

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
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_ios_outlined,
                          size: 50,
                          color: Color(
                            0xffffffff,
                          ),
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.menu,
                        size: 50,
                        color: Color(
                          0xffffffff,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "My Account".toUpperCase(),
                    style: TextStyle(
                      color: Color(
                        0xffffffff,
                      ),
                      fontSize: 45,
                      fontWeight: FontWeight.w500,
                      fontFamily: "sans-serif",
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      height: 60,
                      width: 70,
                      child: Image.asset(
                        "assets/logo.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 45),
            child: StreamBuilder<DocumentSnapshot>(
              stream: userStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data == null) {
                  return const Center(child: Text('No data found!'));
                }

                var userData = snapshot.data!.data() as Map<String, dynamic>;
                return Column(
                  children: [
                    WhiteContainer(text: userData['driver_id'] ?? ""),
                    SizedBox(
                      height: 25,
                    ),
                    WhiteContainer(text: userData['name'] ?? ""),
                    SizedBox(
                      height: 25,
                    ),
                    WhiteContainer(text: userData['email'] ?? ""),
                    SizedBox(
                      height: 25,
                    ),
                    WhiteContainer(text: userData['phone_number'] ?? ""),
                    SizedBox(
                      height: 25,
                    ),
                    WhiteContainerPassword(
                      text: userData['password'] ?? "",
                      icon: Icons.visibility_off,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    ));
  }
}
