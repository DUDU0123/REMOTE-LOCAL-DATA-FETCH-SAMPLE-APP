import 'package:fpdart/fpdart.dart';
import 'package:local_remote_sample_data_app/core/error/failure.dart';

import 'package:local_remote_sample_data_app/features/domain/entity/todo_entity.dart';

abstract interface class TodoRepo{
  Future<Either<Failure,List<TodoEntity>>> getAllDatas();
}

