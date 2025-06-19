import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'failure.dart';

abstract class BaseUseCase<Output, Input> {
  Future<Either<Failure, Output>> call(Input params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];

  static NoParams noParams = NoParams();
}
