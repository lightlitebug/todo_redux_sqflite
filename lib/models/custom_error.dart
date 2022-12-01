import 'package:equatable/equatable.dart';

class CustomError extends Equatable {
  final String errorType;
  final String message;
  const CustomError({
    this.errorType = '',
    this.message = '',
  });

  @override
  List<Object> get props => [errorType, message];

  @override
  String toString() => 'CustomError(errorType: $errorType, message: $message)';
}
