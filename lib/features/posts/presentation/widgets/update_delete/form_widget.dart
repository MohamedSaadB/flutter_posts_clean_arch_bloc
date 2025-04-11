import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app_clean_arch_bloc/features/posts/domain/entities/post.dart';
import 'package:posts_app_clean_arch_bloc/features/posts/presentation/bloc/add_update_delete_posts/add_update_delete_bloc.dart';
import 'package:posts_app_clean_arch_bloc/features/posts/presentation/widgets/update_delete/text_feild_widget.dart';

import 'add_delete_button.dart';

class FormWidget extends StatefulWidget {
  final Post? post ;
  final bool isUpdate ;
  const FormWidget({super.key,this.post, required this.isUpdate});

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController() ;
   final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  void initState() {
    if(widget.isUpdate){
      _titleController.text = widget.post!.title;
      _bodyController.text = widget.post!.body;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal:15),
        child:Form(
          key: _formKey,
          child: Column(
            spacing: 15,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFeildWidget(controller: _titleController, label: "Title"),
              TextFeildWidget(controller: _bodyController, label: "Body",minLines: 5,),
              AddDeleteButton(
                  isUpdate: widget.isUpdate,
                  onPressed:addUpdatePost
              )
            ],
          ),)
    );
  }
  void addUpdatePost() {
    final bool validate = _formKey.currentState!.validate();
    if(validate){
      final post = Post(
          id: widget.isUpdate?widget.post!.id:null,
          title: _titleController.text,
          body: _bodyController.text);
      if(widget.isUpdate){
          BlocProvider.of<AddUpdateDeleteBloc>
            (context).add(UpdatePostEvent(post: post));
      }
      else{
        BlocProvider.of<AddUpdateDeleteBloc>
          (context).add(AddPostEvent(post: post));
      }
      }
  }

}


