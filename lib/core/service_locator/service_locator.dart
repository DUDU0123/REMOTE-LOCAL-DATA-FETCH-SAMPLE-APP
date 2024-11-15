import 'package:get_it/get_it.dart';
import 'package:local_remote_sample_data_app/core/network/connection_checker.dart';
import 'package:local_remote_sample_data_app/features/data/repository/todo_repo_impl.dart';
import 'package:local_remote_sample_data_app/features/data/source/local/local_data_source.dart';
import 'package:local_remote_sample_data_app/features/data/source/remote/remote_data_source.dart';
import 'package:http/http.dart' as http;
import 'package:local_remote_sample_data_app/features/domain/repository/repository.dart';
import 'package:local_remote_sample_data_app/features/domain/usecase/get_all_todos_usecase.dart';

GetIt serviceLocator = GetIt.instance;

initDependencies() {
  serviceLocator.registerLazySingleton<ConnectionChecker>(
    () => ConnectionChecker(),
  );
  serviceLocator.registerLazySingleton<http.Client>(
    () => http.Client(),
  );
  iniTodotDependencies();
}

iniTodotDependencies() {
  serviceLocator
    ..registerFactory<LocalDataSource>(
      () => LocalDataSourceImpl(),
    )
    ..registerFactory<RemoteDataSource>(
      () => RemoteDataSourceImpl(
        client: serviceLocator<http.Client>(),
        localDataSource: serviceLocator<LocalDataSource>(),
      ),
    )
    ..registerFactory<TodoRepo>(
      () => TodoRepoImpl(
        remoteDataSource: serviceLocator<RemoteDataSource>(),
      ),
    )
    ..registerFactory<GetAllTodosUsecase>(
      () => GetAllTodosUsecase(
        todoRepo: serviceLocator<TodoRepo>(),
      ),
    );
}
