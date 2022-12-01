class CustomDBException implements Exception {
  String message;
  CustomDBException([this.message = 'Something went wrong']) {
    message = 'Custom DB Exception: $message';
  }

  @override
  String toString() {
    return message;
  }
}
