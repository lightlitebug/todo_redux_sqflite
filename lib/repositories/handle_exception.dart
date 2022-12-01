import 'package:sqflite/sqflite.dart';

import '../exceptions/custom_db_exception.dart';
import '../models/custom_error.dart';

CustomError handleException(e) {
  try {
    throw e;
  } on DatabaseException catch (e) {
    return CustomError(
      errorType: 'DatabaseException',
      message: '${e.result}',
    );
  } on CustomDBException catch (e) {
    return CustomError(
      errorType: 'CustomDBException',
      message: e.message,
    );
  } catch (e) {
    return CustomError(
      errorType: 'Unknown Error',
      message: e.toString(),
    );
  }
}
