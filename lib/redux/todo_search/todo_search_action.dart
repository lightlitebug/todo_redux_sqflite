class SearchTodoAction {
  final String searchTerm;
  SearchTodoAction({
    required this.searchTerm,
  });

  @override
  String toString() => 'SearchTodoAction(searchTerm: $searchTerm)';
}
