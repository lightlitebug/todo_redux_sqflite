import 'package:redux/redux.dart';

import 'todo_search_action.dart';
import 'todo_search_state.dart';

TodoSearchState searchTodoReducer(
  TodoSearchState state,
  SearchTodoAction action,
) {
  return state.copyWith(searchTerm: action.searchTerm);
}

Reducer<TodoSearchState> todoSearchReducer = combineReducers<TodoSearchState>([
  TypedReducer<TodoSearchState, SearchTodoAction>(
    searchTodoReducer,
  ),
]);
