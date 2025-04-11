import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:posts_app_clean_arch_bloc/core/errors/failuers.dart';
import 'package:posts_app_clean_arch_bloc/core/string.dart';
import 'package:posts_app_clean_arch_bloc/features/posts/domain/entities/post.dart';
import 'package:posts_app_clean_arch_bloc/features/posts/domain/use_cases/add_post.dart';
import 'package:posts_app_clean_arch_bloc/features/posts/domain/use_cases/delete_post.dart';
import 'package:posts_app_clean_arch_bloc/features/posts/domain/use_cases/update_post.dart';

part 'add_update_delete_event.dart';
part 'add_update_delete_state.dart';

class AddUpdateDeleteBloc extends Bloc<AddUpdateDeleteEvent, AddUpdateDeleteState> {
  final AddPostUseCase addPostUseCase ;
  final UpdatePostUseCase updatePostUseCase ;
  final DeletePostUseCase deletePostUseCase ;


  AddUpdateDeleteBloc(
      {required this.addPostUseCase,
        required this.updatePostUseCase,
        required this.deletePostUseCase}) : super(AddUpdateDeleteInitial()) {
    on<AddUpdateDeleteEvent>((event, emit) async{
      if(event is AddPostEvent){

        emit(LoadingAddUpdateDeleteState()) ;
        final failuerOrAddPost = await addPostUseCase(event.post);
        emit(_mapFoldToState(failuerOrAddPost,ADD_SUCCESS_MESSAGE));


      }
      else if (event is UpdatePostEvent){

        emit(LoadingAddUpdateDeleteState()) ;
        final failuerOrAddPost = await updatePostUseCase(event.post);
        emit(_mapFoldToState(failuerOrAddPost,UPDATE_SUCCESS_MESSAGE));

      }
      else if (event is DeletePostEvent){

        emit(LoadingAddUpdateDeleteState()) ;
        final failuerOrAddPost = await deletePostUseCase(event.postId);
         emit(_mapFoldToState(failuerOrAddPost,DELETE_SUCCESS_MESSAGE));
      }
    });
  }

  AddUpdateDeleteState _mapFoldToState(Either<Failuer, Unit> ethier,String message){
    return ethier.fold(
        (failuer)=> ErrorAddUpdateDeleteState(message: _mapFailuerToString(failuer)),
        (_) => MessageAddUpdateDeleteState(message:message));
  }
  String _mapFailuerToString(Failuer failuer){

    switch(failuer.runtimeType){
      case ServerFailuer:
        return SERVER_FAILUER_MESSAGE ;
      case OfflineFailuer:
        return OFFLINE_FAILUER_MESSAGE ;
      default :
        return "un expected error" ;

    }
  }

}
