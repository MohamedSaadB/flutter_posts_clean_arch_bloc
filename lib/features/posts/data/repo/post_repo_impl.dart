import 'package:dartz/dartz.dart';
import 'package:posts_app_clean_arch_bloc/core/errors/exceptions.dart';
import 'package:posts_app_clean_arch_bloc/core/errors/failuers.dart';
import 'package:posts_app_clean_arch_bloc/core/network/network_checker.dart';
import 'package:posts_app_clean_arch_bloc/features/posts/data/data_sources/post_local_data_source.dart';
import 'package:posts_app_clean_arch_bloc/features/posts/data/data_sources/post_remote_data_source.dart';
import 'package:posts_app_clean_arch_bloc/features/posts/data/models/post_model.dart';
import 'package:posts_app_clean_arch_bloc/features/posts/domain/entities/post.dart';
import 'package:posts_app_clean_arch_bloc/features/posts/domain/repo/post_repository.dart';

typedef  DeleteOrUpdateOrAddPost = Future<Unit> Function();

class PostRepoImpl implements PostRepository{
  final PostRemoteDataSource postRemoteDataSource ;
  final PostLocalDataSource postLocalDataSource ;
  final NetworkChecker networkChecker ;

  PostRepoImpl({required this.networkChecker ,required this.postRemoteDataSource, required this.postLocalDataSource});

  @override
  Future<Either<Failuer, List<Post>>> getAllPosts() async{
     if(await networkChecker.internetCheck){
      try{
        final remotePost = await postRemoteDataSource.getAllPosts();
        postLocalDataSource.cahchedPosts(remotePost);
        return Right(remotePost) ;
      } on ServerException{
        return left(ServerFailuer()) ;
      } catch(_){
        return left(UnExpectedFailuer()) ;
      }
     }else{
       try{
         final localPost = await postLocalDataSource.getCahedPosts();
         return Right(localPost) ;
       } on EmptyCacheException{
         return left(EmptyCachFailuer()) ;
       }catch(_){
         return left(UnExpectedFailuer()) ;
       }
     }
  }

  @override
  Future<Either<Failuer, Unit>> addPost(Post post) async{
     final PostModel postModel = PostModel(
         id: post.id, title: post.title, body: post.body) ;

    return await _getMessage((){
      return postRemoteDataSource.addPost(postModel);
    });

  }

  @override
  Future<Either<Failuer, Unit>> deletePost(int postId) async{

    return await _getMessage((){
      return  postRemoteDataSource.deletePost(postId);
    });
  }

  @override
  Future<Either<Failuer, Unit>> updatePost(Post post) async{
    final PostModel postModel = PostModel(
        id: post.id, title: post.title, body: post.body) ;

     return await _getMessage((){
       return  postRemoteDataSource.updatePost(postModel);
     });
  }

  Future<Either<Failuer, Unit>> _getMessage(
      DeleteOrUpdateOrAddPost deleteOrUpdateOrAddPost) async
  {
    if(await networkChecker.internetCheck){
      try{
         deleteOrUpdateOrAddPost;
        return right(unit);
      } on ServerException{
        return left(ServerFailuer());
      }
    }else {
      return left(OfflineFailuer());
    }
  }


}