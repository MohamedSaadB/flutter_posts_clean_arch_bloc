import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app_clean_arch_bloc/core/utils/show_snak_bar.dart';
import 'package:posts_app_clean_arch_bloc/features/posts/presentation/bloc/add_update_delete_posts/add_update_delete_bloc.dart';
import 'package:posts_app_clean_arch_bloc/features/posts/presentation/pages/posts_screen.dart';
import 'package:posts_app_clean_arch_bloc/features/posts/presentation/widgets/update_delete/add_delete_button.dart';
import 'package:posts_app_clean_arch_bloc/features/posts/presentation/widgets/update_delete/form_widget.dart';
import 'package:posts_app_clean_arch_bloc/features/posts/presentation/widgets/update_delete/text_feild_widget.dart';

class AddUpdateDeleteScreen extends StatelessWidget {

  final bool isUpdate ;
  const AddUpdateDeleteScreen({super.key,this.isUpdate=true});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:_buildAppBar(),
      body: _buildBody()
    );
  }

  Widget _buildBody() {
    return BlocConsumer<AddUpdateDeleteBloc,AddUpdateDeleteState>(
        listener:(context,state){
          if(state is MessageAddUpdateDeleteState){
            ShowSnakBar().successSnakBar(context,state.message);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder:(_)=>PostsScreen()),( predicate)=>false) ;
          }
          else if(state is ErrorAddUpdateDeleteState){
            ShowSnakBar().errorSnakBar(context,state.message);
          }
        } ,
        builder:(context,state){
          if(state is LoadingAddUpdateDeleteState){
            return Center(child: CircularProgressIndicator(color: Colors.blue,),);
          }
          return FormWidget(isUpdate:false);

        },
        );
  }
}

AppBar _buildAppBar(){
  return  AppBar(title:Text("update posts",),) ;
}