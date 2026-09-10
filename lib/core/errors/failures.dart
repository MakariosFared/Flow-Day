sealed class AppFailure implements Exception {
  const AppFailure(this.message, [this.cause]);
  final String message;
  final Object? cause;

  @override
  String toString() =>
      '$runtimeType: $message${cause != null ? " (Cause: $cause)" : ""}';
}

final class DatabaseFailure extends AppFailure {
  const DatabaseFailure(super.message, [super.cause]);
}

final class ValidationFailure extends AppFailure {
  const ValidationFailure(super.message, [super.cause]);
}

final class NotFoundFailure extends AppFailure {
  const NotFoundFailure(super.message, [super.cause]);
}

final class PlanningFailure extends AppFailure {
  const PlanningFailure(super.message, [super.cause]);
}

final class ConflictFailure extends AppFailure {
  const ConflictFailure(super.message, [super.cause]);
}
