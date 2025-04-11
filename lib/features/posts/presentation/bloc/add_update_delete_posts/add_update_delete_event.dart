part of 'add_update_delete_bloc.dart';

sealed class AddUpdateDeleteEvent extends Equatable {
  const AddUpdateDeleteEvent();
}

class AddPostEvent extends AddUpdateDeleteEvent{

  final Post post ;
  const AddPostEvent({required this.post}) ;

  @override
  List<Object?> get props => [post];

}

class UpdatePostEvent extends AddUpdateDeleteEvent{

  final Post post ;
  const UpdatePostEvent({required this.post}) ;

  @override
  List<Object?> get props => [post];

}

class DeletePostEvent extends AddUpdateDeleteEvent{

  final int postId ;
  const DeletePostEvent({required this.postId}) ;

  @override
  List<Object?> get props => [postId];

}