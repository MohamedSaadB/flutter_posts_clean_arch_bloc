import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:posts_app_clean_arch_bloc/core/errors/exceptions.dart';
import 'package:posts_app_clean_arch_bloc/features/posts/data/data_sources/post_local_data_source.dart';
import 'package:posts_app_clean_arch_bloc/features/posts/data/models/post_model.dart';
import 'package:http/http.dart' as http ;
abstract class PostRemoteDataSource {

  Future<List<PostModel>> getAllPosts();
  Future<Unit> deletePost(int idPost);
  Future<Unit> updatePost(PostModel postModel);
  Future<Unit> addPost(PostModel postModel);

}

const String BASE_URL= "https://jsonplaceholder.typicode.com" ;

class PostRemoteDataSourceImpl implements PostRemoteDataSource{
  final http.Client client ;

  PostRemoteDataSourceImpl({required this.client}) ;

  @override
  Future<List<PostModel>> getAllPosts() async{
    final response = await client.get(Uri.parse("$BASE_URL/posts"),
        headers:{
         'Content-Type' : 'application/json'
        });
    if(response.statusCode == 200){
        final List responseListJson = json.decode(response.body) as List ;
        final List<PostModel> postsModels =
                              responseListJson.map<PostModel>((postModel)=>
                                  PostModel.fromJson(postModel)).toList();
        return postsModels ;
    }else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPost(PostModel postModel) async{
    final post = {
      'title' : postModel.title ,
      'body'  : postModel.body
    };

    final response =await client.post(Uri.parse("$BASE_URL/posts/"),body: post);

    if(response.statusCode == 201){
      return Future.value(unit);
    }
    else{
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int idPost) async{
    final response = await client.delete(Uri.parse("$BASE_URL/posts/${idPost.toString()}"),
        headers:{
      'Content-Type' : 'application/json'
    });

    if(response.statusCode == 200){
      return Future.value(unit);
    }else{
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostModel postModel) async{
    final String postId = postModel.id.toString();

    final body = {
      'title' : postModel.title,
      'body'  : postModel.body
    };

    final response = await client.patch(Uri.parse("$BASE_URL/posts/$postId"),body: body);

    if(response.statusCode == 200){
       return Future.value(unit);
    }else {
      throw ServerException();
    }
  }
  
}