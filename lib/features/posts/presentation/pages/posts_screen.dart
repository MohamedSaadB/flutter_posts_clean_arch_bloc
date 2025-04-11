import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app_clean_arch_bloc/core/widgets/loading_widget.dart';
import 'package:posts_app_clean_arch_bloc/core/widgets/message_error_widget.dart';
import 'package:posts_app_clean_arch_bloc/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:posts_app_clean_arch_bloc/features/posts/presentation/widgets/post_list_widget.dart';



class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }
}

Widget _buildFloatingActionButton() {
  return FloatingActionButton(
      backgroundColor: Colors.blue,
      onPressed: (){

      },
      child: Icon(Icons.add),
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
