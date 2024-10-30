import 'package:blog_app/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class Usecase<SucessType, Params> {
  Future<Either<Failures, SucessType>> call(Params params);
}
