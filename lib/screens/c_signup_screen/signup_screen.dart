import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/Components/components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled/screens/c_signup_screen/cubit/cubit.dart';
import 'package:untitled/screens/c_signup_screen/cubit/states.dart';
import 'package:untitled/styles/colors/colors.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var emailController = TextEditingController();
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var ageController = TextEditingController();
  var nationalityController = TextEditingController();
  var signupFormKey = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(),
      child: BlocConsumer<SignupCubit, SignupStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SignupCubit.get(context);
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Form(
                key: signupFormKey,
                child: Container(
                  decoration: backgroundImage(
                      image: 'lib/Images/background.jpg', opacity: 0.1),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Hero(
                              tag: 'logo',
                              child: Container(
                                child: Image.asset(
                                  'lib/Images/Logo.png',
                                  height: 70,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'TripGo!',
                              style: TextStyle(fontSize: 30),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Center(
                          child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.black26,
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 45,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    backgroundColor: Colors.white,
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (context) => Wrap(children: [
                                      Column(children: [
                                        buildOptionItem(
                                            onTap: () {
                                              print('gallery tapped');
                                            },
                                            icon: Icons.image,
                                            color: kMainColor,
                                            label: 'pick from gallery'),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 40.0),
                                          child: Container(
                                            height: 1,
                                            width: double.infinity,
                                            color: Colors.black54,
                                          ),
                                        ),
                                        buildOptionItem(
                                            onTap: () {
                                              print('camera tapped');
                                            },
                                            color: kMainColor,
                                            icon: Icons.camera_alt_outlined,
                                            label: 'take a photo')
                                      ]),
                                    ]),
                                  );
                                  // ImagePicker().pickImage(source: ImageSource.gallery);
                                },
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: kMainColor,
                                  foregroundColor: Colors.white,
                                  child: Icon(
                                    Icons.add_a_photo_outlined,
                                    size: 20,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defaultTextForm(    onTap: () {
                          cubit.reset();
                        },
                            controller: usernameController,
                            label: 'Username',
                            keyboardtype: TextInputType.name,
                            validatorText: 'Please enter your username',
                            icon: Icons.person,
                            color: kMainColor),
                        SizedBox(
                          height: 15,
                        ),
                        defaultTextForm(    onTap: () {
                          cubit.reset();
                        },
                            controller: emailController,
                            label: 'E-mail',
                            keyboardtype: TextInputType.emailAddress,
                            validatorText: 'Please enter your E-mail address',
                            icon: Icons.email_outlined,
                            color: kMainColor),
                        SizedBox(
                          height: 15,
                        ),
                        defaultTextForm(    onTap: () {
                          cubit.reset();
                        },
                            controller: passwordController,
                            label: 'Password',
                            keyboardtype: TextInputType.visiblePassword,
                            validatorText: 'Please enter your password',
                            icon: Icons.lock_outline,
                            suffixIcon: cubit.isVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            suffixOnTap: () {
                              cubit.changePasswordVisibility();
                            },
                            isPassword: cubit.isVisible,
                            color: kMainColor),
                        SizedBox(
                          height: 15,
                        ),
                        defaultTextForm(
                            controller: nationalityController,
                            showCursor: false,
                            label: 'Nationality',
                            onTap: () {cubit.reset();
                              showCountryPicker(
                                  context: context,
                                  countryListTheme: CountryListThemeData(
                                    bottomSheetHeight: 500,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  onSelect: (value) {
                                    nationalityController.text =
                                        value.flagEmoji + value.name;
                                  });
                            },
                            keyboardtype: TextInputType.none,
                            validatorText: 'Please enter your Nationality',
                            icon: Icons.flag,
                            color: kMainColor),
                        SizedBox(
                          height: 15,
                        ),
                        defaultTextForm(
                            showCursor: false,
                            onTap: () {cubit.reset();
                              DatePicker.showDatePicker(context,
                                  theme: DatePickerTheme(
                                      headerColor: kMainColor,
                                      containerHeight: 200,
                                      cancelStyle: TextStyle(
                                          fontFamily: 'indie',
                                          color: Colors.white),
                                      itemStyle: TextStyle(
                                          fontFamily: 'indie',
                                          color: kMainColor),
                                      doneStyle: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Indie')),
                                  onConfirm: (value) {
                                ageController.text =
                                    value.toString().substring(0, 10);
                              });
                            },
                            controller: ageController,
                            label: 'Birthday',
                            keyboardtype: TextInputType.none,
                            validatorText: 'Please enter your Birthday',
                            icon: Icons.cake,
                            color: kMainColor),
                        SizedBox(
                          height: 15,
                        ),
                        state is! SignupLoadingState
                            ? defaultButton(
                                text: state is SignupErrorState
                                    ? 'Enter a valid information'
                                    : 'Sign Up',
                                color: state is SignupErrorState
                                    ? Colors.red
                                    : kMainColor,
                                textColor: Colors.white,
                                borderColor: Colors.white,
                                onPressed: () {
                                  if (signupFormKey.currentState!.validate()) {
                                    cubit.signup(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        context: context);
                                  }
                                })
                            : CircularProgressIndicator(
                                color: kMainColor,
                              ),
                      ],
                    ),
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
