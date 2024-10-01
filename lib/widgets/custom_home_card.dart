import 'package:flutter/material.dart';

Widget CustomHomeCard(
    {required String cardName,
    required String image,
    required BuildContext context}) {
  return Container(
    width: 150,
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          offset: Offset(0, 1),
          color: Colors.grey,
          spreadRadius: 0.0,
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          image,
          height: 90,
          width: 80,
        ),
        Divider(),
        Text(
          cardName,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black, fontSize: 12, fontFamily: 'GoogleSans'),
        ),
      ],
    ),
  );
}
