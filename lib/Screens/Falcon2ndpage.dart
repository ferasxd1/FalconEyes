import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:falconeyes/Screens/Falcon1.dart';
import 'package:falconeyes/Widgets/ButtonWidget.dart';
import 'package:falconeyes/Widgets/textfieldwidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textFieldController1 = TextEditingController();
  final TextEditingController _textFieldController2 = TextEditingController();
  final TextEditingController _textFieldController3 = TextEditingController();
  final TextEditingController _textFieldController4 = TextEditingController();
  final TextEditingController _textFieldController5 = TextEditingController();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;

  signUpUser() async {
    try {
      setState(() {
        isLoading = true;
      });
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
              email: _textFieldController3.text,
              password: _textFieldController5.text);
      if (userCredential.user!.uid.isNotEmpty) {
        await createUser(userCredential.user!.uid);
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      String errorMessage;
      if (e.code == 'email-already-in-use') {
        errorMessage = 'Email already registered, please login.';
      } else {
        errorMessage = 'Sign Up failed. Please try again.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
        ),
      );

      print(e.message);
      // Utils.customSnackBar('SignIn Failed!', e.message!);
    }
  }

  Future<void> createUser(String userId) async {
    String collectionName = "Users";
    try {
      await _firebaseFirestore.collection(collectionName).doc(userId).set({
        'user_uid': userId,
        'driver_id': _textFieldController1.text,
        'name': _textFieldController2.text,
        'email': _textFieldController3.text,
        'phone_number': _textFieldController4.text,
        'password': _textFieldController5.text
      }).then((value) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FalconEyes()),
        );

        ///Navigate to logain screen
      });
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      if (kDebugMode) {
        print(e.toString());
      }
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
                            "CREATE YOUR",
                            style: TextStyle(
                              color: Color(
                                0xffffffff,
                              ),
                              fontSize: 45,
                              fontWeight: FontWeight.w500,
                              fontFamily: "sans-serif",
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "ACCOUNT",
                                style: TextStyle(
                                  color: Color(
                                    0xffffffff,
                                  ),
                                  fontSize: 45,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "sans-serif",
                                ),
                              ),
                              Spacer(),
                              SizedBox(
                                height: 60,
                                width: 70,
                                child: Image.asset(
                                  "assets/logo.png",
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 45),
                    child: Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        children: [
                          TextFieldWidget(
                            hintText: 'Driver ID',
                            readOnly: false,
                            textEditingController: _textFieldController1,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter Driver ID';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          TextFieldWidget(
                            hintText: 'Full name',
                            readOnly: false,
                            textEditingController: _textFieldController2,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter name';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          TextFieldWidget(
                            hintText: 'Email',
                            readOnly: false,
                            textEditingController: _textFieldController3,
                            validator: (value) {
                              // Check if the value is empty
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
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          TextFieldWidget(
                            hintText: 'Phone',
                            readOnly: false,
                            textEditingController: _textFieldController4,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter Phone';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          TextFieldWidget(
                            hintText: 'password',
                            readOnly: false,
                            suffixIcon: Icons.visibility_off,
                            textEditingController: _textFieldController5,
                            validator: (value) {
                              if (value != null || value!.isNotEmpty) {
                                if (value.length < 6) {
                                  return 'Password must be at least 6 char';
                                } else {
                                  return null;
                                }
                              } else {
                                return 'Please enter a 6 char password';
                              }
                            },
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                // Process data
                                print(
                                    'Text Field 1: ${_textFieldController1.text}');
                                print(
                                    'Text Field 2: ${_textFieldController2.text}');
                                print(
                                    'Text Field 3: ${_textFieldController3.text}');
                                print(
                                    'Text Field 4: ${_textFieldController4.text}');
                                print(
                                    'Text Field 5: ${_textFieldController5.text}');

                                signUpUser();
                              }
                            },
                            child: isLoading
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : ButtonWidget(
                                    buttonText: 'Create Account',
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}
