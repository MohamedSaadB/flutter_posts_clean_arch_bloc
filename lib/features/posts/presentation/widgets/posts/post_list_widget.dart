

import 'package:flutter/material.dart';
import 'package:posts_app_clean_arch_bloc/features/posts/domain/entities/post.dart';

import '../../pages/add_update_delete_screen.dart';

class PostListWidget extends StatelessWidget {
  final List<Post> posts ;

  const PostListWidget({super.key,required this.posts});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
          itemCount: posts.length,
          itemBuilder: (context,index){
            return InkWell(
              onTap: (){
                Navigator.of(context).push
                  (MaterialPageRoute(builder: (_)=>
                    AddUpdateDeleteScreen(isUpdate: true,post: posts[index],)));
              },
              child: ListTile(
                leading: Text(posts[index].id.toString()),
                title: Text(posts[index].title),
                contentPadding: EdgeInsets.all(5),
              ),
            );
          },
       separatorBuilder: (context,index){
            return Divider(thickness: 1,);
       },);
  }
}
