import 'package:city_minds/presentation/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../Features/widgets/show_flushbar.dart';
import 'bottom_nav_bar_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool visibility = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  bool loading = false;

  Future login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      try {
        await auth.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        if (await auth.currentUser!.emailVerified) {
          setState(() {
            loading = false;
          });
          // page3
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => BottomNavBarScreens()),
          );
        } else {
          setState(() {
            loading = false;
            showError('please verify your email', context);
          });
        }
      } on FirebaseAuthException catch (e) {
        setState(() {
          loading = false;
        });
        if (e.code == 'wrong-password') {
          showError('password is incorrect', context);
        } else if (e.code == 'user-not-found') {
          showError('password or email is incorrect', context);
        } else if (e.code == 'invalid-credential') {
          showError('password or email is incorrect', context);
        } else if (e.code == 'network-request-failed') {
          showError('check you connection and try again', context);
        } else {
          showError(e.code, context);
        }
      } catch (e) {
        setState(() {
          loading = false;
        });
        if (context.mounted) showError(e.toString(), context);
      } finally {
        setState(() {
          loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Stack(
              children: [
                Column(
                  children: [
                    Stack(
                      children: [
                        Image.asset('assets/images/login_photo2.png'),
                        Container(
                          width: double.infinity,
                          height: 450,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                //Colors.blue.withOpacity(0.2), // شفاف من فوق
                                Color(0xFF052659).withOpacity(0.2),
                                Color(0xFF5483B3),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 350,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            //Color(0xFF021024),
                            Color(0xFF5483B3),
                            Color(0xFF052659),
                            Colors.black,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 300),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Welcome to",
                          style: TextStyle(
                            fontSize: 25,
                            fontFamily: "Pacifico",
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "City Minds",
                          style: TextStyle(
                            fontSize: 35,
                            fontFamily: "Pacifico",
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            autofillHints: [
                              AutofillHints.email,
                              AutofillHints.password,
                            ],
                            controller: emailController,
                            validator:
                                (input) =>
                                    input!.isValidEmail()
                                        ? null
                                        : input.isEmpty
                                        ? "email can't be empty"
                                        : "Enter Valid email",
                            autovalidateMode: AutovalidateMode.onUnfocus,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: 'Email Address',
                              hintText: 'Enter your Email',
                              hintStyle: TextStyle(color: Colors.white),
                              labelStyle: TextStyle(color: Colors.white),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              suffixIcon: Icon(
                                Icons.mail_outline,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          TextFormField(
                            autofillHints: [
                              AutofillHints.email,
                              AutofillHints.password,
                            ],
                            controller: passwordController,
                            validator:
                                (input) =>
                                    input!.isEmpty
                                        ? "Enter an password"
                                        : input.length < 8
                                        ? "Password can't be less than 8 character"
                                        : null,
                            autovalidateMode: AutovalidateMode.onUnfocus,
                            style: TextStyle(color: Colors.white),
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: visibility,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              hintText: 'Enter your password',
                              hintStyle: TextStyle(color: Colors.white),
                              labelStyle: TextStyle(color: Colors.white),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  visibility
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                color: Colors.white,
                                onPressed: () {
                                  visibility = !visibility;
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          ElevatedButton(
                            onPressed:
                                loading
                                    ? null
                                    : () {
                                      setState(() {
                                        login();
                                      });
                                    },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              backgroundColor: Color(0xFF7DA0CA),
                            ),
                            child:
                                loading
                                    ? LoadingAnimationWidget.progressiveDots(
                                      size: 24,
                                      color: Colors.white,
                                    )
                                    : Text(
                                      'Log In',
                                      style: TextStyle(color: Colors.white),
                                    ),
                            //color: Color(0xFF021024),
                          ),
                          SizedBox(height: 15),
                          Center(
                            child: Text(
                              "Don't have an account?",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) {
                                    return SignupScreen();
                                  },
                                ),
                              );
                            },
                            child: Text(
                              'Create an account',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.purple.shade900,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
