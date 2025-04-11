import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app_clean_arch_bloc/core/widgets/loading_widget.dart';
import 'package:posts_app_clean_arch_bloc/core/widgets/message_error_widget.dart';
import 'package:posts_app_clean_arch_bloc/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:posts_app_clean_arch_bloc/features/posts/presentation/pages/add_update_delete_screen.dart';
import 'package:posts_app_clean_arch_bloc/features/posts/presentation/widgets/posts/post_list_widget.dart';



class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }
}

Widget _buildFloatingActionButton(BuildContext context) {
  return FloatingActionButton(
      backgroundColor: Colors.blueGrey,
      onPressed: (){
        Navigator.of(context).push
          (MaterialPageRoute(builder: (_)=>AddUpdateDeleteScreen(isUpdate: false,)));
      },
      child: Icon(Icons.add,color: Colors.white,),
      );
}

Widget _buildBody() {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: BlocBuilder<PostsBloc,PostsState>(builder: (context,state){
        if(state is LoadingPostState){
          return LoadingWidget();
        }
        else if (state is LoadedPostState){
          return RefreshIndicator(
              onRefresh:()=> _onRefresh(context),
              child: PostListWidget(posts:state.posts)) ;
        }
        else if (state is ErrorPostState){
          return MessageErrorWidget(message:state.message, onRefresh: _onRefresh);
        }
          return MessageErrorWidget(message:"Error",onRefresh: _onRefresh) ;
    }),
  );
}

Future<void> _onRefresh(BuildContext context) async{
  BlocProvider.of<PostsBloc>(context).add(RefreshPostsEvent());
}

PreferredSizeWidget _buildAppBar() {
  return AppBar(title: Text("Posts"),) ;
}
