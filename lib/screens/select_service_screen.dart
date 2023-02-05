import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled/constatns/constants.dart';
import 'package:untitled/screens/favorites_screen.dart';
import 'c_signup_screen/signup_screen.dart';

class SelectServiceScreen extends StatefulWidget {
  @override
  State<SelectServiceScreen> createState() => _SelectServiceScreenState();
}

class _SelectServiceScreenState extends State<SelectServiceScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  final _auth = FirebaseAuth.instance;
  late User loggedInUser;
  late String id;
  late final uid;
//   void getUserUid()async{var userid=await _auth.currentUser!.uid;
// }
  @override
  getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        id = loggedInUser.email.toString();
        var userid = await _auth.currentUser!.uid;
        uid = userid;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'How may we help you?',
                  style: kLabelTextStyle,
                ),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FavoritesScreen(uid)));
                    },
                    icon: Icon(
                      Icons.favorite,
                      color: kWidgetColor,
                      size: 40,
                    ))
              ],
            ),
            SizedBox(
              height: 100,
            ),
            Expanded(
              child: Row(
                children: [
                  IconHolderButton(Icons.fastfood, 'Something to eat?', () {
                    Navigator.pushNamed(context, 'restaurants_screen');
                  }),
                  SizedBox(
                    width: 5,
                  ),
                  IconHolderButton(Icons.hotel, 'hotel to stay in?', () {
                    Navigator.pushNamed(context, 'hotels_screen');
                  })
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: Row(
                children: [
                  IconHolderButton(
                      Icons.shopping_bag_outlined, 'place for shopping?', () {
                    Navigator.pushNamed(context, 'shops_screen');
                  }),
                  SizedBox(
                    width: 5,
                  ),
                  IconHolderButton(
                    Icons.landscape,
                    'somewhere to visit?',
                    () {
                      Navigator.pushNamed(context, 'landmarks_screen');
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class IconHolderButton extends StatelessWidget {
  late IconData icon;
  late String label;
  VoidCallback function;
  IconHolderButton(this.icon, this.label, this.function);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: function,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
              color: Color(0xFF678983),
              borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 60,
                  color: Color(0xFFF0E9D2),
                ),
              ),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFFF0E9D2),
                      fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
