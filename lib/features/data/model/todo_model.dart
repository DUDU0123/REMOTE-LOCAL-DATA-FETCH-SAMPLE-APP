import 'package:hive_flutter/hive_flutter.dart';
import 'package:local_remote_sample_data_app/features/domain/entity/todo_entity.dart';
part 'todo_model.g.dart';

@HiveType(typeId: 0)
class TodoModel extends TodoEntity {
  @HiveField(0)
  final int? todoid;

  @HiveField(1)
  final String? todotitle;

  @HiveField(2)
  final bool? iscompleted;

  @HiveField(3)
  final int? userid;
  const TodoModel({
    required this.todoid,
    required this.todotitle,
    required this.iscompleted,
    required this.userid,
  }) : super(
          todoId: todoid,
          todoTitle: todotitle,
          isCompleted: iscompleted,
          userId: userid,
        );

  factory TodoModel.fromJson({required Map<String, dynamic> map}) {
    return TodoModel(
      iscompleted: map['completed'] as bool?,
      userid: map['userId'] as int?,
      todotitle: map['todo'] as String?,
      todoid: map['id'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': todoid,
      'todo': todotitle,
      'userId': userid,
      'completed': iscompleted,
    };
  }
}
