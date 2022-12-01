import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../redux/app_state.dart';
import '../redux/todo_search/todo_search_action.dart';
import '../utils/debounce.dart';

class SearchTodo extends StatefulWidget {
  const SearchTodo({Key? key}) : super(key: key);

  @override
  State<SearchTodo> createState() => _SearchTodoState();
}

class _SearchTodoState extends State<SearchTodo> {
  final debounce = Debounce(milliseconds: 1000);

  @override
  void dispose() {
    debounce.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: (store) => _ViewModel.fromStore(store),
      builder: (BuildContext context, _ViewModel vm) {
        return TextField(
          decoration: const InputDecoration(
            labelText: 'Search todos...',
            border: InputBorder.none,
            filled: true,
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: (String? searchTerm) {
            if (searchTerm != null) {
              debounce.run(() {
                vm.searchTodo(searchTerm);
              });
            }
          },
        );
      },
    );
  }
}

class _ViewModel extends Equatable {
  final void Function(String searchTerm) searchTodo;
  const _ViewModel({
    required this.searchTodo,
  });

  @override
  List<Object> get props => [];

  static fromStore(Store<AppState> store) {
    return _ViewModel(
      searchTodo: (String searchTerm) => store.dispatch(
        SearchTodoAction(searchTerm: searchTerm),
      ),
    );
  }
}
