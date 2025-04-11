import 'package:dartz/dartz.dart';
import 'package:posts_app_clean_arch_bloc/features/posts/domain/repo/post_repository.dart';

import '../../../../core/errors/failuers.dart';
import '../entities/post.dart';

class UpdatePostUseCase {

  final PostRepository postRepository ;

  UpdatePostUseCase(this.postRepository);

  Future<Either<Failuer,Unit>> call(Post post) async{

    return await postRepository.updatePost(post);
  }
}