import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../models/todo_model.dart';
import '../redux/app_state.dart';
import '../redux/todo_filter/todo_filter_action.dart';

class FilterTodo extends StatelessWidget {
  const FilterTodo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        FilterButton(todoFilter: TodoFilter.all),
        FilterButton(todoFilter: TodoFilter.active),
        FilterButton(todoFilter: TodoFilter.completed),
      ],
    );
  }
}

class FilterButton extends StatelessWidget {
  const FilterButton({
    Key? key,
    required this.todoFilter,
  }) : super(key: key);
  final TodoFilter todoFilter;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: (Store<AppState> store) => _ViewModel.fromStore(store),
      builder: (BuildContext context, _ViewModel vm) {
        return TextButton(
          onPressed: () {
            vm.changeFilter(todoFilter);
          },
          child: Text(
            todoFilter == TodoFilter.all
                ? 'All'
                : todoFilter == TodoFilter.active
                    ? 'Active'
                    : 'Complete',
            style: TextStyle(
              fontSize: 18.0,
              color: vm.currentFilter == todoFilter ? Colors.blue : Colors.grey,
            ),
          ),
        );
      },
    );
  }
}

class _ViewModel extends Equatable {
  final void Function(TodoFilter todoFilter) changeFilter;
  final TodoFilter currentFilter;
  const _ViewModel({
    required this.changeFilter,
    required this.currentFilter,
  });

  @override
  List<Object> get props => [currentFilter];

  static fromStore(Store<AppState> store) {
    return _ViewModel(
      changeFilter: (TodoFilter todoFilter) => store.dispatch(
        ChangeTodoFilterAction(todoFilter: todoFilter),
      ),
      currentFilter: store.state.todoFilterState.todoFilter,
    );
  }
}
