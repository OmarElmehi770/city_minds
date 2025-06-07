import 'package:city_minds/presentation/signup_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../Features/widgets/show_flushbar.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key, required Map<String, dynamic> userData});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

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

  Future<Map<String, dynamic>> getCurrentUserData() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();

    return userDoc.data() as Map<String, dynamic>;
  }

  Future signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });

      try{

        await FirebaseFirestore.instance.collection('users').doc(auth.currentUser!.uid).update({
          'name1': name1Controller.text,
          'name2': name2Controller.text,
          'phone': phoneController.text,
          'password': passwordController.text,
          'square': squareController.text,
          'home': homeController.text,
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
      backgroundColor: Colors.grey,
      body: FutureBuilder(
        future: getCurrentUserData(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (!snapshot.hasData) {
            return Center(child: Text("No user data found."));
          }

          var data = snapshot.data!;

          TextEditingController name1Controller = TextEditingController(text: '${data['name1']}');
          TextEditingController name2Controller = TextEditingController(text: '${data['name2']}');
          TextEditingController phoneController = TextEditingController(text: '${data['phone']}');
          TextEditingController passwordController = TextEditingController(text: '${data['password']}');
          TextEditingController squareController = TextEditingController(text: '${data['square']}');
          TextEditingController homeController = TextEditingController(text: '${data['home']}');
          return Form(
            key: _formKey ,
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 15,
                    children: [
                      SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 165,
                            child: TextFormField(
                              controller: name1Controller,
                              validator: (input) =>
                              input!.isEmpty
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
                              validator: (input) =>
                              input!.isEmpty
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
                        controller: phoneController,
                        validator: (input) =>
                        input!.isEmpty
                            ? "Enter Your Phone Number"
                            : input.length < 11
                            ? "Check Your Phone Number"
                            : null,
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
                        validator: (input) =>
                        input!.isEmpty
                            ? "Enter an password"
                            : input.length < 8
                            ? "Password can't be less than 8 character"
                            : null,
                        autovalidateMode: AutovalidateMode.onUnfocus,
                        style: TextStyle(color: Colors.white),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: false,
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

                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 165,
                            child: TextFormField(
                              controller: squareController,
                              validator: (input) =>
                              input!.isEmpty
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
                              validator: (input) =>
                              input!.isEmpty
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
                        onPressed:  null ,
                        //   () {
                        //   setState(() {
                        //     signUp();
                        //   });
                        // },

                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(300, 50),
                          padding: EdgeInsets.symmetric(vertical: 15),
                          backgroundColor: Color(0xFF7DA0CA),
                        ),
                        child: loading ? LoadingAnimationWidget.progressiveDots(
                          size: 24,
                          color: Colors.white,
                        ) : Text('Edit', style: TextStyle(color: Colors.white),),
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
          );
        },
      ),
    );
  }
}
