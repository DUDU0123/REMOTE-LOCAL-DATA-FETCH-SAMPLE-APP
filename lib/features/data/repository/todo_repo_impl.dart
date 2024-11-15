import 'package:fpdart/fpdart.dart';
import 'package:local_remote_sample_data_app/core/error/failure.dart';
import 'package:local_remote_sample_data_app/core/exception/exceptions.dart';
import 'package:local_remote_sample_data_app/features/data/source/remote/remote_data_source.dart';
import 'package:local_remote_sample_data_app/features/domain/entity/todo_entity.dart';
import 'package:local_remote_sample_data_app/features/domain/repository/repository.dart';

class TodoRepoImpl implements TodoRepo {
  final RemoteDataSource remoteDataSource;
  TodoRepoImpl({
    required this.remoteDataSource,
  });
  @override
  Future<Either<Failure, List<TodoEntity>>> getAllDatas() async {
    try {
      final result = await remoteDataSource.getAllDatas();
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    } on DatabaseException catch (e) {
      return left(Failure(message: e.message));
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}
