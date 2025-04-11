import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:posts_app_clean_arch_bloc/core/errors/exceptions.dart';
import 'package:posts_app_clean_arch_bloc/features/posts/data/models/post_model.dart';
import 'package:shared_preferences/shared_preferences.dart' ;
abstract class PostLocalDataSource {

  Future<List<PostModel>> getCahedPosts() ;
  Future<Unit> cahchedPosts(List<PostModel> postsModels) ;
}

class PostLocalDataSourceImpl implements PostLocalDataSource{
  final SharedPreferences sharedPreferences ;


  PostLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<Unit> cahchedPosts(List<PostModel> postsModels) {
     List postModelToMap =
     postsModels.map<Map<String,dynamic>>((postModel)=>postModel.toJson()).toList();

     sharedPreferences.setString("CACHED_POSTS", json.encode(postModelToMap));
     return Future.value(unit) ;
  }

  @override
  Future<List<PostModel>> getCahedPosts() {
    final jsonString = sharedPreferences.getString("CACHED_POSTS") ;
    if(jsonString != null){

      List decodeJsonString  = json.decode(jsonString);
      List<PostModel> listOfPosts =
      decodeJsonString.map<PostModel>((post)=>PostModel.fromJson(post)).toList();
      return Future.value(listOfPosts);

    }else {
      throw EmptyCacheException();
    }
  }
  
  
}