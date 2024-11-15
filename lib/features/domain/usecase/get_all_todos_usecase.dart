import 'package:fpdart/fpdart.dart';
import 'package:local_remote_sample_data_app/core/error/failure.dart';
import 'package:local_remote_sample_data_app/core/usecase/usecase.dart';
import 'package:local_remote_sample_data_app/features/domain/entity/todo_entity.dart';
import 'package:local_remote_sample_data_app/features/domain/repository/repository.dart';

class GetAllTodosUsecase implements Usecase<List<TodoEntity>, Null> {
  final TodoRepo todoRepo;
  GetAllTodosUsecase({
    required this.todoRepo,
  });
  @override
  Future<Either<Failure, List<TodoEntity>>> call({required Null params})async {
    return await todoRepo.getAllDatas();
  }
  
}
