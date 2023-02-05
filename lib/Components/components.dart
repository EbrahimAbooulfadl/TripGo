import 'package:flutter/material.dart';
import 'package:untitled/screens/a_on_boarding_screen/on_boarding_screen.dart';

Decoration backgroundImage({required String image, required double opacity}) {
  return BoxDecoration(
    image: DecorationImage(
        colorFilter: ColorFilter.mode(
            Colors.white.withOpacity(opacity), BlendMode.dstATop),
        image: AssetImage(image),
        fit: BoxFit.cover),
  );
}

Widget buildOnBoardingItem(BoardingModel model) => Column(
      children: [
        Expanded(child: Image(image: AssetImage(model.image))),
        SizedBox(
          height: 15,
        ),
        Text(
          model.title,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          model.description,
          style: TextStyle(fontSize: 20, color: Colors.black54),
        )
      ],
    );

Widget defaultButton(
        {double width = 200,
        Color color = Colors.brown,
        required VoidCallback onPressed,
        required String text,
        Color textColor = Colors.black,
        Color borderColor = Colors.black,
        double height = 50,
        bool upperCase = true}) =>
    Center(
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: borderColor)),
        child: MaterialButton(
          onPressed: onPressed,
          child: Text(
            upperCase ? text : text,
            style: TextStyle(
                color: textColor, fontWeight: FontWeight.w300, fontSize: 16),
          ),
        ),
      ),
    );
Widget defaultTextForm(
        {required TextEditingController controller,
        required String label,
        double height = 1,
        required TextInputType keyboardtype,
        required String validatorText,
        required IconData icon,
        Color color = Colors.black,
        bool isPassword = false,
        bool isClickable = true,
        bool showCursor = true,
        VoidCallback? onTap,
        IconData? suffixIcon,
        VoidCallback? suffixOnTap}) =>
    TextFormField(
      cursorColor: color,
      validator: (value) {
        if (value!.isEmpty) {
          return (validatorText);
        } else if (value.isNotEmpty) {
          return null;
        }
      },
      showCursor: showCursor,
      controller: controller,
      keyboardType: keyboardtype,
      obscureText: isPassword,
      onTap: onTap,
      enabled: isClickable,
      style: TextStyle(fontSize: 14, height: height),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 0),
        floatingLabelStyle: TextStyle(color: color),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              5,
            ),
            borderSide: BorderSide(color: color, width: 2)),
        focusColor: color,
        labelText: label,
        labelStyle: TextStyle(
            fontSize: 12, fontWeight: FontWeight.w300, fontFamily: 'Indie'),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: color, width: 2),
          borderRadius: BorderRadius.circular(5),
        ),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: color, width: 2)),
        suffixIcon: GestureDetector(
            onTap: suffixOnTap,
            child: Icon(
              suffixIcon,
              color: color,
            )),
        prefixIcon: Icon(
          icon,
          color: color,
        ),
      ),
      onFieldSubmitted: (value) {},
      onChanged: (value) {},
    );
Widget buildOptionItem(
        {Color color = Colors.black,
        required VoidCallback onTap,
        required IconData icon,
        required String label}) =>
    Padding(
      padding: const EdgeInsets.all(12.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: color,
                size: 30,
              ),
              SizedBox(
                width: 7,
              ),
              Text(
                label,
                style: TextStyle(fontSize: 25, color: Colors.black54),
              )
            ],
          ),
        ),
      ),
    );
