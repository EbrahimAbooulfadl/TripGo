import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/Components/components.dart';
import 'package:untitled/screens/b-login_screen/cubit/cubit.dart';
import 'package:untitled/screens/b-login_screen/cubit/states.dart';
import 'package:untitled/screens/c_signup_screen/signup_screen.dart';
import 'package:untitled/styles/colors/colors.dart';

class SignInScreen extends StatelessWidget {
  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  var loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            body: Form(
              key: loginFormKey,
              child: Container(
                decoration: backgroundImage(
                    image: 'lib/Images/background.jpg', opacity: 0.1),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Hero(
                        tag: 'logo',
                        child: Image(
                          image: AssetImage(
                            'lib/Images/Logo.png',
                          ),
                          height: 150,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'TripGo!',
                        style: TextStyle(
                            fontSize: 45, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultTextForm(
                        onTap: () {
                          cubit.reset();
                        },
                        controller: emailController,
                        label: 'E-mail',
                        keyboardtype: TextInputType.emailAddress,
                        validatorText: 'Please enter your e-mail',
                        icon: Icons.email_outlined,
                        color: kMainColor,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultTextForm(
                          onTap: () {
                            cubit.reset();
                          },
                          controller: passwordController,
                          label: 'password',
                          keyboardtype: TextInputType.name,
                          validatorText: 'Please enter your password',
                          icon: Icons.lock_outline,
                          color: kMainColor,
                          suffixIcon: cubit.isVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          suffixOnTap: () {
                            cubit.changePasswordVisibility();
                          },
                          isPassword: cubit.isVisible),
                      const SizedBox(
                        height: 15,
                      ),
                      state is! LoginLoadingState
                          ? defaultButton(
                              onPressed: () {
                                if (loginFormKey.currentState!.validate()) {
                                  cubit.login(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      context: context);
                                }
                              },
                              text: state is LoginErrorState
                                  ? 'wrong email or password'
                                  : 'Login',
                              color: state is LoginErrorState
                                  ? Colors.red
                                  : kMainColor,
                              borderColor: Colors.white,
                              textColor: Colors.white)
                          : CircularProgressIndicator(
                              color: kMainColor,
                            ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('don\'t have an account?'),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUpScreen()));
                              },
                              child: Text(
                                'Register!',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: kMainColor),
                              ))
                        ],
                      )
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
