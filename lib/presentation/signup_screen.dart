import 'package:city_minds/Features/widgets/show_flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool visibility = true;
  TextEditingController name1Controller = TextEditingController();
  TextEditingController name2Controller = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController squareController = TextEditingController();
  TextEditingController homeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool loading = false ;
  FirebaseAuth auth = FirebaseAuth.instance ;
  Future signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });


      try{
        await auth.createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text
        );

        await auth.currentUser!.sendEmailVerification();

        await FirebaseFirestore.instance.collection('users').doc(auth.currentUser!.uid).set({
          'name1': name1Controller.text,
          'name2': name2Controller.text,
          'email': emailController.text,
          'phone': phoneController.text,
          'password': passwordController.text,
          'square': squareController.text,
          'home': homeController.text,
          'uid': auth.currentUser!.uid,
          'role': 'user',
          'signUpDate': DateFormat('d,MMMM,yyyy').format(DateTime.now()),
        });

        setState(() {
          loading = false ;
        });

        showSuccess("Successfully", context);

        Navigator.pop(context);

      } catch(error){
        setState(() {
          loading = false ;
        });
        showError(error.toString(), context);
      }
      // await FirebaseAuth.instance.createUserWithEmailAndPassword(
      //     email: emailController.text.trim(),
      //     password: passwordController.text.trim());
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Color(0xFF7DA0CA),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF7DA0CA),
                  Color(0xFF5483B3),
                  //Color(0xFF87A7D0),
                  // Color(0xFFb5d2e8),
                  Color(0xFF052659),
                  Color(0xFF021024),
                  //Colors.black
                ],
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 15,
                  children: [
                    SizedBox(height: 40),
                    Text("Create Account",
                      style: TextStyle(
                        fontSize: 30,
                        //fontFamily: "Pacifico",
                        color: Colors.white,
                      )
                    ),
                    Text("Sign up to get started",
                        style: TextStyle(
                          fontSize: 17,
                          //fontFamily: "Pacifico",
                          color: Colors.white,
                        )
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 165,
                          child: TextFormField(
                            controller: name1Controller,
                            validator: (input) => input!.isEmpty
                                ? "name can't be empty"
                                : null,
                            autovalidateMode: AutovalidateMode.onUnfocus,
                            keyboardType: TextInputType.text,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: 'First Name',
                              hintStyle: TextStyle(color: Colors.white),
                              labelStyle: TextStyle(color: Colors.white,),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 165,
                          child: TextFormField(
                            controller: name2Controller,
                            validator: (input) => input!.isEmpty
                                ? "name can't be empty"
                                : null,
                            autovalidateMode: AutovalidateMode.onUnfocus,
                            keyboardType: TextInputType.text,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: 'Second Name',
                              hintStyle: TextStyle(color: Colors.white),
                              labelStyle: TextStyle(color: Colors.white,),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    TextFormField(
                      controller: emailController,
                      validator: (input) => input!.isValidEmail()
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
                        labelStyle: TextStyle(color: Colors.white,),
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
                    TextFormField(
                      controller: phoneController,
                      validator: (input) => input!.isEmpty
                          ? "Enter Your Phone Number"
                          : input.length<11?"Check Your Phone Number":null,
                      maxLength: 11,
                      autovalidateMode: AutovalidateMode.onUnfocus,
                      keyboardType: TextInputType.numberWithOptions(),
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        hintText: 'Enter your Number',
                        hintStyle: TextStyle(color: Colors.white),
                        labelStyle: TextStyle(color: Colors.white,),
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
                          Icons.phone,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: passwordController,
                      validator: (input) => input!.isEmpty
                          ? "Enter an password"
                          : input.length<8?"Password can't be less than 8 character":null,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 165,
                          child: TextFormField(
                            controller: squareController,
                            validator: (input) => input!.isEmpty
                                ? "can't be empty"
                                : null,
                            autovalidateMode: AutovalidateMode.onUnfocus,
                            keyboardType: TextInputType.text,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: 'Square code',
                              hintStyle: TextStyle(color: Colors.white),
                              labelStyle: TextStyle(color: Colors.white,),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 165,
                          child: TextFormField(
                            controller: homeController,
                            validator: (input) => input!.isEmpty
                                ? "can't be empty"
                                : null,
                            autovalidateMode: AutovalidateMode.onUnfocus,
                            keyboardType: TextInputType.text,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: 'Home Number',
                              hintStyle: TextStyle(color: Colors.white),
                              labelStyle: TextStyle(color: Colors.white,),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed:loading ? null: () {
                        setState(() {
                          signUp();
                        });
                      },

                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(300,50),
                        padding: EdgeInsets.symmetric(vertical: 15),
                        backgroundColor: Color(0xFF7DA0CA),
                      ),
                      child: loading?LoadingAnimationWidget.progressiveDots(
                        size: 24,
                        color: Colors.white,
                      ):Text('Sign up',style: TextStyle(color: Colors.white),),
                      //color: Color(0xFF021024),
                    ),
                    Text('About us',
                      style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white,
                      color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

// showDialog(context: context, builder: (_)=>Center(child: Container(width:50,height: 50,child: CircularProgressIndicator()),));
