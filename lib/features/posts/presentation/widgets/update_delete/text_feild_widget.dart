import 'package:flutter/material.dart';

class TextFeildWidget extends StatelessWidget {

  final TextEditingController controller ;
  final String label ;
  final int minLines ;
  const TextFeildWidget({super.key, required this.controller, required this.label, this.minLines = 1});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: minLines,
      maxLines: minLines,
      decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.black,fontSize: 18),
          floatingLabelBehavior:FloatingLabelBehavior.always,
          border:OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.blue)
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent),
            borderRadius: BorderRadius.circular(10),
          )
      ),
      controller:controller ,
      validator: (val){
        if(val !.isEmpty){
          return "this filed doesn't empty" ;
        }
        else {
          return null ;
        }
      },
    );
  }
}
