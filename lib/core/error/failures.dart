// failures.dart
class Failures {
  final String message;
  Failures(this.message);
}

class ServerFailure extends Failures {
  ServerFailure(String message) : super(message);
}
