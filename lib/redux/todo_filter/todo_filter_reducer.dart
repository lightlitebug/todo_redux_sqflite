import 'package:redux/redux.dart';

import 'todo_filter_action.dart';
import 'todo_filter_state.dart';

TodoFilterState changeTodoFilterReducer(
  TodoFilterState state,
  ChangeTodoFilterAction action,
) {
  return state.copyWith(todoFilter: action.todoFilter);
}

Reducer<TodoFilterState> todoFilterReducer = combineReducers<TodoFilterState>([
  TypedReducer<TodoFilterState, ChangeTodoFilterAction>(
    changeTodoFilterReducer,
  ),
]);
