class ServerException implements Exception {
  final String message;
  ServerException({
    required this.message,
  });
  @override
  String toString() {
    return message.toString();
  }
}
class DatabaseException implements Exception {
  final String message;
  DatabaseException({
    required this.message,
  });
  @override
  String toString() {
    return message.toString();
  }
}