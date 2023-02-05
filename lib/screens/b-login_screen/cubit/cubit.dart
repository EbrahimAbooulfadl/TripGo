import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/screens/b-login_screen/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:untitled/screens/select_service_screen.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);
  bool isVisible = false;
  void reset() {
    emit(LoginInitialState());
  }

  void changePasswordVisibility() {
    isVisible = !isVisible;
    emit(LoginChangePasswordVisibilityState());
  }

  void login(
      {required String email,
      required String password,
      required context}) async {
    emit(LoginLoadingState());
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(LoginSuccessState());
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => SelectServiceScreen()));
    }).catchError((error) {
      print('on error');
      emit(LoginErrorState(error.toString()));
    });
  }
}
