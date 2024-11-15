import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:local_remote_sample_data_app/core/exception/exceptions.dart';
import 'package:local_remote_sample_data_app/core/network/connection_checker.dart';
import 'package:local_remote_sample_data_app/core/service_locator/service_locator.dart';
import 'package:local_remote_sample_data_app/features/data/model/todo_model.dart';
import 'package:local_remote_sample_data_app/features/data/source/local/local_data_source.dart';

abstract interface class RemoteDataSource {
  Future<List<TodoModel>> getAllDatas();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client client;
  final LocalDataSource localDataSource;
  RemoteDataSourceImpl({
    required this.client,
    required this.localDataSource,
  });
  @override
  Future<List<TodoModel>> getAllDatas() async {
    try {
      debugPrint("I am in");
      if (await serviceLocator<ConnectionChecker>().checkConnection()) {
        final response =
            await client.get(Uri.parse('https://dummyjson.com/todos'));
        if (response.statusCode == 200 && response.body.isNotEmpty) {
          final decodedData = jsonDecode(response.body)["todos"] as List;
          final todoList = decodedData.map((data) {
            return TodoModel.fromJson(map: data);
          }).toList();
          await localDataSource.saveTodo(todoList);
          debugPrint(todoList.toString());
          return todoList;
        } else {
          throw ServerException(message: "No data found");
        }
      } else {
        final todoList = await localDataSource.getAllData();
        if (todoList.isNotEmpty) {
          return todoList;
        } else {
          throw ServerException(message: "Check your internet connection");
        }
      }
    } catch (e, stack) {
      log("Error ${e.toString()} $stack");
      throw ServerException(message: e.toString());
    }
  }
}
