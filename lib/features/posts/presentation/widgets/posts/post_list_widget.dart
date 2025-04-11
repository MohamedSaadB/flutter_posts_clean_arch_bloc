

import 'package:flutter/material.dart';
import 'package:posts_app_clean_arch_bloc/features/posts/domain/entities/post.dart';

class PostListWidget extends StatelessWidget {
  final List<Post> posts ;

  const PostListWidget({super.key,required this.posts});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
          itemCount: posts.length,
          itemBuilder: (context,index){
            return ListTile(
              leading: Text(posts[index].id.toString()),
              title: Text(posts[index].title),
              contentPadding: EdgeInsets.all(5),
            );
          },
       separatorBuilder: (context,index){
            return Divider(thickness: 1,);
       },);
  }
}
