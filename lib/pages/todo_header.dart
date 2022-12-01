import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../redux/app_state.dart';

class TodoHeader extends StatelessWidget {
  const TodoHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'TODO',
          style: TextStyle(fontSize: 40.0),
        ),
        StoreConnector<AppState, _ViewModel>(
          distinct: true,
          converter: (Store<AppState> store) => _ViewModel.fromStore(store),
          builder: (BuildContext context, _ViewModel vm) {
            return Text(
              '${vm.activeTodoCount}/${vm.totalTodoCount} item${vm.activeTodoCount != 1 ? "s" : ""} left',
              style: const TextStyle(fontSize: 20.0),
            );
          },
        ),
      ],
    );
  }
}

class _ViewModel extends Equatable {
  final int totalTodoCount;
  final int activeTodoCount;
  const _ViewModel({
    required this.totalTodoCount,
    required this.activeTodoCount,
  });

  @override
  List<Object> get props => [totalTodoCount, activeTodoCount];

  static fromStore(Store<AppState> store) {
    final int currentTotalTodoCount = store.state.todoListState.todos.length;
    final int currentActiveTodoCount = store.state.todoListState.todos
        .where((todo) => !todo.completed)
        .toList()
        .length;

    return _ViewModel(
      totalTodoCount: currentTotalTodoCount,
      activeTodoCount: currentActiveTodoCount,
    );
  }
}
