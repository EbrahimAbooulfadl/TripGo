import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share/share.dart';
import 'package:untitled/constatns/constants.dart';
import 'package:untitled/screens/gmap_screen.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'chat_screen.dart';

class HotelsScreen extends StatefulWidget {
  const HotelsScreen({Key? key}) : super(key: key);

  @override
  _HotelsScreenState createState() => _HotelsScreenState();
}

late final uid;

class _HotelsScreenState extends State<HotelsScreen> {
  final _auth = FirebaseAuth.instance;
  void getUserID() async {
    final userid = _auth.currentUser!.uid;
    uid = userid;
    print(userid);
  }

  @override
  final _firestore = FirebaseFirestore.instance;
  String url = '';
  String ldescription = '';
  String label = '';
  double llat = 0;
  double llang = 0;
  late double rate;
  void showRating() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: kBackgroundColor,
              title: Text('What do you think of $label'),
              content: Container(
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RatingBar.builder(
                        updateOnDrag: true,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          switch (index) {
                            case 0:
                              return Icon(
                                Icons.sentiment_very_dissatisfied,
                                color: Colors.red,
                              );
                            case 1:
                              return Icon(
                                Icons.sentiment_dissatisfied,
                                color: Colors.redAccent,
                              );
                            case 2:
                              return Icon(
                                Icons.sentiment_neutral,
                                color: Colors.amber,
                              );
                            case 3:
                              return Icon(
                                Icons.sentiment_satisfied,
                                color: Colors.lightGreen,
                              );
                            case 4:
                              return Icon(
                                Icons.sentiment_very_satisfied,
                                color: Colors.green,
                              );
                          }
                          return (Text('s'));
                        },
                        onRatingUpdate: (rating) {
                          setState(() {
                            this.rate = rating;
                          });
                        }),
                    Text('Thanks for your help!'),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Submit',
                          style: TextStyle(color: kWidgetColor),
                        ))
                  ],
                ),
              ),
            ));
  }

  Widget buildBottomSheet(BuildContext context) {
    getUserID();
    return Container(
      color: kBackgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
      child: ListView(
        children: [
          Container(
            child: Image.network(url),
          ),
          Center(
            child: Text(
              label,
              style: kLabelTextStyle.copyWith(fontSize: 19),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () async {
                  await _firestore
                      .collection('favorites')
                      .doc('$uid')
                      .collection('favs')
                      .add({
                    'name': label,
                    'description': ldescription,
                    'imageUrl': url,
                    'lat': llat,
                    'lang': llang
                  });
                  Fluttertoast.showToast(
                      msg: 'Added to your favorites',
                      backgroundColor: kWidgetColor,
                      textColor: kBackgroundColor);
                },
                icon: Icon(Icons.thumb_up_alt_outlined),
                color: Colors.blue,
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GMap(llat, llang)));
                },
                icon: Icon(Icons.map),
                color: Colors.red,
              ),
              IconButton(
                  onPressed: () {
                    Share.share('$label:  $ldescription');
                  },
                  icon: Icon(Icons.share),
                  color: Colors.blue),
              IconButton(
                  onPressed: () {
                    showRating();
                  },
                  icon: Icon(
                    Icons.star_rate_sharp,
                    color: Colors.yellow,
                  )),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChatScreen(label)));
                  },
                  icon: Icon(
                    Icons.chat_rounded,
                    color: Colors.grey,
                  ))
            ],
          ),
          Text(ldescription)
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Container(
      color: kBackgroundColor,
      padding: EdgeInsets.only(top: 30),
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: Container(
          padding: EdgeInsets.only(top: 25, left: 7),
          child: Column(
            children: [
              Text(
                'Here is the best Egyptian hotels!',
                style: kLabelTextStyle,
              ),
              SizedBox(
                height: 20,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('hotels').snapshots(),
                builder: (context, snapshot) {
                  List<Widget> landmarkWidgets = [];
                  if (!snapshot.hasData) {
                    landmarkWidgets.add(Center(
                      child: CircularProgressIndicator(
                        color: Colors.lightBlueAccent,
                      ),
                    ));
                  }
                  final data = snapshot.data!.docs;

                  for (var landmark in data) {
                    final description = landmark.get('description');
                    final name = landmark.get('name');
                    final imageUrl = landmark.get('imageUrl');
                    final lat = landmark.get('lat');
                    final lang = landmark.get('lang');
                    final photoWidget = Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(15),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                url = imageUrl;
                                ldescription = description;
                                label = name;
                                llang = lang;
                                llat = lat;

                                showModalBottomSheet(
                                    context: context,
                                    builder: buildBottomSheet);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: kWidgetColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  children: [
                                    Container(
                                      child: Image.network(
                                        '$imageUrl',
                                        height: 150,
                                        width: 150,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '$name',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Text(
                                          '$description',
                                        ),
                                      ],
                                    ))
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                    landmarkWidgets.add(photoWidget);
                  }

                  return Expanded(
                    child: ListView(
                      reverse: false,
                      children: landmarkWidgets,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// await _firestore.collection('favorites').add({
//   'name': label,
//   'description': ldescription,
//   'imageUrl': url,
//   'lat': llat,
//   'lang': llang
// });
// await _firestore.collection('favorites').doc('$uid').set({
//   'name': label,
//   'description': ldescription,
//   'imageUrl': url,
//   'lat': llat,
//   'lang': llang
// });
