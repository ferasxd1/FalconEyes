import 'package:falconeyes/Screens/Falcon2ndpage.dart';
import 'package:falconeyes/Screens/Falcon3rdpage.dart';
import 'package:falconeyes/Widgets/ButtonWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class FalconEyes extends StatefulWidget {
  const FalconEyes({super.key});

  @override
  State<FalconEyes> createState() => _FalconEyesState();
}

class _FalconEyesState extends State<FalconEyes> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textFieldController1 = TextEditingController();
  final TextEditingController _textFieldController2 = TextEditingController();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final pinControllerPhone = TextEditingController();
  bool validation = false, isLoading = false;
  String phone = '';

  signInWithEmail() async {
    try {
      setState(() {
        isLoading = true;
      });
      UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
              email: _textFieldController1.text.trim(),
              password: _textFieldController2.text.trim());
      if (userCredential.user != null) {
        setState(() {
          isLoading = false;
        });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FalconListScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
        String errorMessage;
    switch (e.code) {
      case 'invalid-email':
        errorMessage = 'The email address is badly formatted.';
        break;
      case 'user-not-found':
        errorMessage = 'No user found for that email.';
        break;
      case 'wrong-password':
        errorMessage = 'Wrong password provided for that user.';
        break;
      default:
        errorMessage = 'SignIn failed. Please try again.';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
      ),
    );

    print(e.message);
    }
  }

  @override
  void dispose() {
    _textFieldController1.dispose();
    _textFieldController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xff3685CD),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 600,
                    decoration: BoxDecoration(
                        color: Color(0xffE8E8E8),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        )),
                    child: Padding(
                      padding: EdgeInsets.only(top: 25),
                      child: Column(
                        children: [
                          Image.asset("assets/logo.png"),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "falconeyes".toUpperCase(),
                            style: TextStyle(
                                color: Color(0xff3685CD),
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 190,
                    width: double.infinity,
                    color: Colors.blue,
                  )
                ],
              ),
            ),
            Positioned(
              top: 200,
              left: 30,
              right: 30,
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      )),
                  height: 510,
                  width: 350,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Sign in",
                        style: TextStyle(
                            color: Color(0xff3685CD),
                            fontSize: 40,
                            fontWeight: FontWeight.w300),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 30),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Color(0xffE6E1E1),
                                  borderRadius: BorderRadius.circular(50)),
                              child: TextFormField(
                                controller: _textFieldController1,
                                validator: (value) {
                                 if (value!.isEmpty) {
                                return 'Please enter your email';
                              }
                              // Use regex to validate email format
                              String emailRegex =
                                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                              RegExp regex = RegExp(emailRegex);
                              if (!regex.hasMatch(value)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                                },
                                decoration: InputDecoration(
                                  border: InputBorder
                                      .none, // Hide the default border of TextField
                                  prefixIcon: Icon(
                                    Icons.person_2_outlined,
                                    color: Color(0xffffffff),
                                  ), // Add prefix icon
                                  hintText: 'Email',
                                  hintStyle: TextStyle(
                                      color: Color(
                                          0xffDEDADA)), // Placeholder text
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 15.0,
                                      horizontal:
                                          20.0), // Padding for the input text
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Color(0xffE6E1E1),
                                  borderRadius: BorderRadius.circular(50)),
                              child: TextFormField(
                                controller: _textFieldController2,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter valid password';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  border: InputBorder
                                      .none, // Hide the default border of TextField
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Color(0xffffffff),
                                  ), // Add prefix icon
                                  hintText: 'Password',
                                  hintStyle:
                                      TextStyle(color: Color(0xffDEDADA)),

                                  /// Placeholder text
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 15.0,
                                      horizontal:
                                          20.0), // Padding for the input text
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            GestureDetector(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  // Process data
                                  print(
                                      'Text Field 1: ${_textFieldController1.text}');
                                  print(
                                      'Text Field 2: ${_textFieldController2.text}');

                                   signInWithEmail();   
                                }
                              },
                              child:
                              isLoading?
                              Center(
                                child: CircularProgressIndicator(),
                              ):
                               ButtonWidget(
                                buttonText: 'Login',
                              ),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Don\'t have an account? ',
                                    style: TextStyle(
                                        color: Colors
                                            .black), // Change color to red
                                  ),
                                  TextSpan(
                                    text: ' Create an account',
                                    style: TextStyle(
                                      color: Color(0xff3685CD),
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CreateAccountPage()),
                                        );
                                      }, // Change color to blue
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
