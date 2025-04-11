import 'package:equatable/equatable.dart';

abstract class Failuer extends Equatable{

}

class OfflineFailuer extends Failuer {

  @override
  List<Object?> get props => [];
}

class ServerFailuer extends Failuer {

  @override
  List<Object?> get props => [];
}

class EmptyCachFailuer extends Failuer {

  @override
  List<Object?> get props => [];
}

class UnExpectedFailuer extends Failuer {

  @override
  List<Object?> get props => [];
}