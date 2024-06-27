import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SelectServiceProvider extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text(
          "Select Service Provider",
          style: TextStyle(
            fontSize: 12
          ),
        ),
      ),
    ));
  }
}
