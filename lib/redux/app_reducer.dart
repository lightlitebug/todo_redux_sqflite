import 'app_state.dart';
import 'todo_filter/todo_filter_reducer.dart';
import 'todo_list/todo_list_reducer.dart';
import 'todo_search/todo_search_reducer.dart';

AppState reducer(AppState state, action) {
  return AppState(
    todoListState: todoListReducer(state.todoListState, action),
    todoSearchState: todoSearchReducer(state.todoSearchState, action),
    todoFilterState: todoFilterReducer(state.todoFilterState, action),
  );
}
