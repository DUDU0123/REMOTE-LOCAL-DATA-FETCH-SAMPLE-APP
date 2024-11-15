import 'package:fpdart/fpdart.dart';
import 'package:local_remote_sample_data_app/core/error/failure.dart';

abstract interface class Usecase<SuccessType, Params>{
 Future<Either<Failure, SuccessType>> call({required Params params});
}