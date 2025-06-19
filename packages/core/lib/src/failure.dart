import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);
}

class DataFailure extends Failure {
  final String message;

  const DataFailure(this.message) : super(message);

  @override
  List<Object?> get props => [message];
}


class IllegalArgumentFailure extends Failure {
  final String message;

  const IllegalArgumentFailure(this.message) : super(message);

  @override
  List<Object?> get props => [message];
}
