import 'package:flutter/material.dart';

import 'filter_todo.dart';
import 'new_todo.dart';
import 'search_todo.dart';
import 'show_todos.dart';
import 'todo_header.dart';

class TodosPage extends StatelessWidget {
  const TodosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: const [
                TodoHeader(),
                NewTodo(),
                SizedBox(height: 20.0),
                SearchTodo(),
                SizedBox(height: 20.0),
                FilterTodo(),
                SizedBox(height: 10.0),
                ShowTodos(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
