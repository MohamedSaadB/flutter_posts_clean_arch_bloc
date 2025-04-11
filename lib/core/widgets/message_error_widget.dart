import 'package:flutter/material.dart';


class MessageErrorWidget extends StatelessWidget {
  final String message ;
  final Future<void> Function(BuildContext context) onRefresh;
  const MessageErrorWidget({super.key,required this.message, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children:  [
          Text(message),
          MaterialButton(
            color: Colors.blueGrey,
            onPressed: ()async{
            await onRefresh(context) ;
          },child:Text("try again",style: TextStyle(color: Colors.white),),)

        ]
      ),
    );
  }
}
