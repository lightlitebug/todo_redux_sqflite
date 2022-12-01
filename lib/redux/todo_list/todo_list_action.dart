class AddTodoAction {
  final String todoDesc;
  AddTodoAction({
    required this.todoDesc,
  });

  @override
  String toString() => 'AddTodoAction(todoDesc: $todoDesc)';
}

class EditTodoAction {
  final String id;
  final String todoDesc;
  EditTodoAction({
    required this.id,
    required this.todoDesc,
  });

  @override
  String toString() => 'EditTodoAction(id: $id, todoDesc: $todoDesc)';
}

class ToggleTodoAction {
  final String id;
  ToggleTodoAction({
    required this.id,
  });

  @override
  String toString() => 'ToggleTodoAction(id: $id)';
}

class DeleteTodoAction {
  final String id;
  DeleteTodoAction({
    required this.id,
  });

  @override
  String toString() => 'DeleteTodoAction(id: $id)';
}
