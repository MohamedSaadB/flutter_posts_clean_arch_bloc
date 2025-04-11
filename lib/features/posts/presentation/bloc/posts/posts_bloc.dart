import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:posts_app_clean_arch_bloc/core/errors/failuers.dart';
import 'package:posts_app_clean_arch_bloc/core/string.dart';
import 'package:posts_app_clean_arch_bloc/features/posts/domain/entities/post.dart';
import 'package:posts_app_clean_arch_bloc/features/posts/domain/use_cases/get_all_posts.dart';
import 'package:dartz/dartz.dart';
part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUseCase getAllPostsUseCase ;
  PostsBloc(
      {required this.getAllPostsUseCase}
      ) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async{
      if(event is GetAllPostsEvent){
        emit(LoadingPostState());

        final postsOrFailuer = await getAllPostsUseCase() ;
         emit(_mapFailuerOrPostToState(postsOrFailuer));
      }
      else if(event is RefreshPostsEvent){
        emit(LoadingPostState());

        final postsOrFailuer = await getAllPostsUseCase() ;
        emit(_mapFailuerOrPostToState(postsOrFailuer));

      }
    });
  }

  PostsState _mapFailuerOrPostToState(Either<Failuer, List<Post>> postsOrFailuer){
    return postsOrFailuer.fold((failuer)=>
        ErrorPostState(message: _mapFailuerToString(failuer)),
        (posts)=>LoadedPostState(posts: posts));
  }

  String _mapFailuerToString(Failuer failuer){

    switch(failuer.runtimeType){
      case ServerFailuer:
           return SERVER_FAILUER_MESSAGE ;
      case EmptyCachFailuer:
        return EMPTY_CACHE_MESSAGE ;
      case OfflineFailuer:
        return OFFLINE_FAILUER_MESSAGE ;
      case UnExpectedFailuer:
        return UNEXPECTED_FAILUER_MESSAGE;
      default :
        return "un expected error" ;

    }
  }
}
