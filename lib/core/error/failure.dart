// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final int? statusCode;

  const Failure(
    this.message,
    this.statusCode,
  );

  @override
  List<Object> get props => [message];
}

class RemoteFailure extends Failure {
  const RemoteFailure._(String message, {int? statusCode})
      : super(message, statusCode);

  factory RemoteFailure(String message, {int? statusCode}) =>
      RemoteFailure._(message, statusCode: statusCode);

  @override
  bool operator ==(covariant RemoteFailure other) {
    if (identical(this, other)) return true;

    return other.message == message;
  }

  @override
  int get hashCode => super.message.hashCode;

  @override
  String toString() => 'Remote failure: ${super.message}';
}
