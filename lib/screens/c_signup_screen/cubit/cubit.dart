import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/screens/c_signup_screen/cubit/states.dart';
import 'package:untitled/screens/select_service_screen.dart';

class SignupCubit extends Cubit<SignupStates> {
  SignupCubit() : super(SignupInitialState());
  static SignupCubit get(context) => BlocProvider.of(context);
  bool isVisible = false;
  void changePasswordVisibility() {
    isVisible = !isVisible;
    emit(SignupChangePasswordVisibilityState());
  }

  void reset() {
    emit(SignupInitialState());
  }

  void signup(
      {required String email, required String password, required context}) {
    emit(SignupLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(SignupSuccessState());
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => SelectServiceScreen()));
    }).catchError((error) {
      emit(SignupErrorState(error.toString()));
    });
  }
}
