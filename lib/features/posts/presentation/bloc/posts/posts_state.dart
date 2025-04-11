part of 'posts_bloc.dart';

sealed class PostsState extends Equatable {
  const PostsState();
}

final class PostsInitial extends PostsState {
  @override
  List<Object> get props => [];
}


class LoadingPostState extends PostsState{
  @override
  List<Object?> get props =>[];

}

class LoadedPostState extends PostsState{
  final List<Post> posts ;

  const LoadedPostState({required this.posts});

  @override
  List<Object?> get props =>[posts];

}

class ErrorPostState extends PostsState{
  final String message;

  const ErrorPostState({required this.message});

  @override
  List<Object?> get props =>[message];

}
