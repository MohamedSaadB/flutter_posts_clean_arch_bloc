part of 'add_update_delete_bloc.dart';

sealed class AddUpdateDeleteState extends Equatable {
  const AddUpdateDeleteState();
}

final class AddUpdateDeleteInitial extends AddUpdateDeleteState {
  @override
  List<Object> get props => [];
}

class LoadingAddUpdateDeleteState extends AddUpdateDeleteState {
  @override
  List<Object?> get props => [];
}

class ErrorAddUpdateDeleteState extends AddUpdateDeleteState {
  final String message ;

  const ErrorAddUpdateDeleteState({required this.message});

  @override
  List<Object?> get props => [message] ;
}

class MessageAddUpdateDeleteState extends AddUpdateDeleteState {
  final String message ;

  const MessageAddUpdateDeleteState({required this.message});

  @override
  List<Object?> get props => [message] ;
}
