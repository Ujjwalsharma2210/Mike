import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mike/api/DatabaseController.dart';
import 'package:mike/api/HelperFunctions.dart';
import 'package:mike/resuableWidgets/ReusableWidgets.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _usernameTextController = TextEditingController();
  DatabaseController databaseController = DatabaseController();

  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Mike Sign Up",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Enter Username", Icons.person_outline,
                      false, _usernameTextController),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Enter Email", Icons.person_outline, false,
                      _emailTextController),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Enter password", Icons.password_rounded,
                      true, _passwordTextController),
                  const SizedBox(
                    height: 20,
                  ),
                  signInSignUpButton(context, false, () async {
                    signUp();
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  signUp() async {
    if (formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Logging in!")),
      );

      Map<String, String> userInfoMap = {
        "name": _usernameTextController.text,
        "email": _emailTextController.text
      };

      HelperFunctions.saveUserEmailSharedPreference(_emailTextController.text);
      HelperFunctions.saveUserNameSharedPreference(
          _usernameTextController.text);

      setState(() {
        isLoading = true;
      });

      await firebaseAuth
          .createUserWithEmailAndPassword(
              email: _emailTextController.text,
              password: _passwordTextController.text)
          .then((value) {
        HelperFunctions.saveUserLoggedInSharedPreference(true);
        databaseController.uploadUserdata(userInfoMap);

        Navigator.pushNamed(context, "HomePage");
      });
    }
  }
}
