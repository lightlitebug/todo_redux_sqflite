import '../../models/todo_model.dart';

class ChangeTodoFilterAction {
  final TodoFilter todoFilter;
  ChangeTodoFilterAction({
    required this.todoFilter,
  });

  @override
  String toString() => 'ChangeTodoFilterAction(todoFilter: $todoFilter)';
}
