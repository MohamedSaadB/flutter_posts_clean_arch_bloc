import 'package:dartz/dartz.dart';
import 'package:posts_app_clean_arch_bloc/features/posts/domain/entities/post.dart';
import 'package:posts_app_clean_arch_bloc/features/posts/domain/repo/post_repository.dart';

import '../../../../core/errors/failuers.dart';

class AddPostUseCase {

  final PostRepository postRepository ;

  AddPostUseCase(this.postRepository);

  Future<Either<Failuer,Unit>> call(Post post) async {
    return await postRepository.addPost(post);
  }
}