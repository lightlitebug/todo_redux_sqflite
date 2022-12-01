import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'pages/todos_page.dart';
import 'redux/app_middleware.dart';
import 'redux/app_reducer.dart';
import 'redux/app_state.dart';

late final Store<AppState> store;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  store = Store<AppState>(
    reducer,
    initialState: AppState.initial(),
    middleware: appMiddleware(),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Todos',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const TodosPage(),
      ),
    );
  }
}
