
import 'package:dartz/dartz.dart';
import 'package:posts_app_clean_arch_bloc/core/errors/failuers.dart';
import 'package:posts_app_clean_arch_bloc/features/posts/domain/entities/post.dart';

abstract class PostRepository {

  Future<Either<Failuer,List<Post>>> getAllPosts();
  Future<Either<Failuer,Unit>> addPost(Post post);
  Future<Either<Failuer,Unit>> deletePost(int id);
  Future<Either<Failuer,Unit>> updatePost(Post post);

}