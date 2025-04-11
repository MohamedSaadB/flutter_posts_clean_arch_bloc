import 'package:dartz/dartz.dart';
import 'package:posts_app_clean_arch_bloc/features/posts/domain/repo/post_repository.dart';

import '../../../../core/errors/failuers.dart';

class DeletePostUseCase {

  final PostRepository postRepository ;

  DeletePostUseCase(this.postRepository);

  Future<Either<Failuer,Unit>> call(int id) async{

    return await postRepository.deletePost(id);
  }
}