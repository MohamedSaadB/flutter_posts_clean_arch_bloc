import 'package:flutter/material.dart';

class ShowSnakBar {

  void successSnakBar(BuildContext context ,String message){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content:Text(
            message,
            style: TextStyle(fontSize: 16,color: Colors.white),),
      backgroundColor: Colors.green,)
    );
  }

  void errorSnakBar(BuildContext context ,String message){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:Text(
            message,
            style: TextStyle(fontSize: 16,color: Colors.white),),
          backgroundColor: Colors.red,)
    );
  }
}