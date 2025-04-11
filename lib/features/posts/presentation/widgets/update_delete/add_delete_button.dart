import 'package:flutter/material.dart';

class AddDeleteButton extends StatelessWidget {

  final bool isUpdate ;
  final void Function()? onPressed ;
  const AddDeleteButton({super.key, required this.isUpdate, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:120),
      child: MaterialButton(
        color: Colors.blueGrey,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Colors.blue)
        ),
        onPressed:onPressed,
        child: Row(
          spacing: 5,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isUpdate?
              Icons.update_rounded:
              Icons.add
              ,color: Colors.white,),
            Text(
             isUpdate?
              "update":
              "Add",style: TextStyle(color: Colors.white),),
          ],
        ),
      ),
    );
  }
}
