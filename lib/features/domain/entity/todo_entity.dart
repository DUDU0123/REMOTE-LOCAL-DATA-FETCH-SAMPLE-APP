import 'package:equatable/equatable.dart';

class TodoEntity extends Equatable {
  final int? todoId;
  final String? todoTitle;
  final bool? isCompleted;
  final int? userId;
  const TodoEntity({
    this.todoId,
    this.todoTitle,
    this.isCompleted,
    this.userId,
  });

  @override
  List<Object?> get props => [todoId, todoTitle, isCompleted, userId];
}
