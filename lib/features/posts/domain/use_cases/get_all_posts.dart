
import 'package:dartz/dartz.dart';
import 'package:posts_app_clean_arch_bloc/core/errors/failuers.dart';
import 'package:posts_app_clean_arch_bloc/features/posts/domain/entities/post.dart';
import 'package:posts_app_clean_arch_bloc/features/posts/domain/repo/post_repository.dart';

class GetAllPostsUseCase {

  final PostRepository postRepository ;
  GetAllPostsUseCase(this.postRepository) ;

  Future<Either<Failuer,List<Post>>>  call() async{
   return await postRepository.getAllPosts();
}



}