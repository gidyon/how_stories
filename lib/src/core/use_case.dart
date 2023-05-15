import 'package:dartz/dartz.dart';

abstract class UseCase<T, P> {
  T call({P params});
}

abstract class UseCaseFuture<T, P> {
  Future<T> call({P params});
}

abstract class UseCaseStream<T, P> {
  Stream<T> call({P params});
}

extension EitherX<L, R> on Either<L, R> {
  R asRight() => (this as Right).value; //
  L asLeft() => (this as Left).value;
}
