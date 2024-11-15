import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:local_remote_sample_data_app/features/presentation/controller/todo_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    TodoController.to.getAllTodo();
  }
  @override
  Widget build(BuildContext context) {
    Color commonColor = const Color.fromARGB(255, 72, 255, 0);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        surfaceTintColor: Colors.black,
        elevation: 0,
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          "My App",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 25,
            color: commonColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.settings,
              color: commonColor,
            ),
          )
        ],
      ),
      body: Obx(() {
        if (TodoController.to.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              color: commonColor,
            ),
          );
        }
        return RefreshIndicator(
          color: commonColor,
          onRefresh: () async {
            return await TodoController.to.getAllTodo();
          },
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            itemBuilder: (context, index) {
              return ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                tileColor: commonColor.withOpacity(0.1),
                leading: Icon(
                  Icons.today,
                  color: commonColor,
                ),
                contentPadding: const EdgeInsets.only(left: 15),
                title: Text(
                  TodoController.to.todoList[index].todoTitle ?? '',
                  style: TextStyle(color: commonColor),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 10,
              );
            },
            itemCount: TodoController.to.todoList.length,
          ),
        );
      }),
    );
  }
}
