import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:local_remote_sample_data_app/core/service_locator/service_locator.dart';
import 'package:local_remote_sample_data_app/features/data/model/todo_model.dart';
import 'package:local_remote_sample_data_app/features/domain/usecase/get_all_todos_usecase.dart';
import 'package:local_remote_sample_data_app/features/presentation/controller/todo_controller.dart';
import 'package:local_remote_sample_data_app/root_widget_page.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  initDependencies();
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(TodoModelAdapter());
  Get.put(
      TodoController(getAllTodosUsecase: serviceLocator<GetAllTodosUsecase>()));
  runApp(
    const RootWidgetPage(),
  );
}
