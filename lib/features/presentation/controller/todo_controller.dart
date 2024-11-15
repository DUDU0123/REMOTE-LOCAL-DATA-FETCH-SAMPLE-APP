import 'package:get/get.dart';
import 'package:local_remote_sample_data_app/features/domain/entity/todo_entity.dart';

import 'package:local_remote_sample_data_app/features/domain/usecase/get_all_todos_usecase.dart';

class TodoController extends GetxController {
  static TodoController get to => Get.find();
  final GetAllTodosUsecase _getAllTodosUsecase;
  RxList<TodoEntity> todoList = <TodoEntity>[].obs;
  RxString message = ''.obs;
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    getAllTodo();
    super.onInit();
  }

  TodoController({
    required GetAllTodosUsecase getAllTodosUsecase,
  }) : _getAllTodosUsecase = getAllTodosUsecase;

  Future<void> getAllTodo() async {
    isLoading.value = true;
    try {
      final res = await _getAllTodosUsecase(params: null);
      res.fold(
        (failure) {
          Get.snackbar("Info", message.value);
        },
        (todos) {
          isLoading.value = false;
          todoList.value = todos;
        },
      );
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Info", message.value);
    }
  }
}
