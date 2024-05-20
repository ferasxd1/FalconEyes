import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NotficationScreen extends StatefulWidget {
  const NotficationScreen({super.key});

  @override
  State<NotficationScreen> createState() => _NotficationScreenState();
}

class _NotficationScreenState extends State<NotficationScreen> {
  late Stream<DocumentSnapshot> userStream;
  late FirebaseFirestore _firestore;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    String collectionName = "Detection";

    _firestore = FirebaseFirestore.instance;
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    userStream = _firestore.collection(collectionName).doc(uid).snapshots();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xffE8E8E8),
      body: SingleChildScrollView(
        child: Column(
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
                          onTap: (){
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
                      "NOTIFICATIONS",
                      style: TextStyle(
                        color: Color(
                          0xffffffff,
                        ),
                        fontSize: 35,
                        fontWeight: FontWeight.w500,
                        fontFamily: "sans-serif",
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        height: 60,
                        width: 70,
                        child: Image.asset("assets/logo.png",
                                     fit: BoxFit.fill,

                                     ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30,),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("10:30AM ; Cat ; 15 meters",style: TextStyle(
                    color: Color(0xff000000,),fontSize: 30,fontWeight: FontWeight.w300
                  ),),
                  SizedBox(height: 30,),
                  Text("8:55PM ; Human ; 20 meters",textAlign: TextAlign.center,style: TextStyle(
                      color: Color(0xff000000,),fontSize: 30,fontWeight: FontWeight.w300
                  ),),
                  SizedBox(height: 30,),
                  Text("9:22PM ; Camel ; 25 meters",textAlign: TextAlign.center,style: TextStyle(
                      color: Color(0xff000000,),fontSize: 30,fontWeight: FontWeight.w300
                  ),),
                  SizedBox(height: 30,),
                  Text("02:05AM ; Human ; 35 meters",textAlign: TextAlign.center,style: TextStyle(
                      color: Color(0xff000000,),fontSize: 30,fontWeight: FontWeight.w300
                  ),),
                  SizedBox(height: 30,),
                  Text("04:00AM ; Dog ; 35 meters",textAlign: TextAlign.center,style: TextStyle(
                      color: Color(0xff000000,),fontSize: 30,fontWeight: FontWeight.w300
                  ),),
                ],
              ),
            ),

          ],
        ),
      ),
    ));
  }
}
