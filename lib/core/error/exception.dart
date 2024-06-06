import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

enum ServerExceptionType {
  requestCancelled,
  badCertificate,
  unauthorisedRequest,
  connectionError,
  badRequest,
  notFound,
  requestTimeout,
  sendTimeout,
  recieveTimeout,
  conflict,
  internalServerError,
  notImplemented,
  serviceUnavailable,
  socketException,
  formatException,
  unableToProcess,
  defaultError,
  unexpectedError,
}

class ServerException extends Equatable implements Exception {
  final String message;
  final int? statusCode;
  final ServerExceptionType exceptionType;

  const ServerException._({
    required this.message,
    this.exceptionType = ServerExceptionType.unexpectedError,
    int? statusCode,
  }) : statusCode = statusCode ?? 500;

  factory ServerException(dynamic error) {
    late ServerException serverException;

    try {
      if (error is DioException) {
        switch (error.type) {
          case DioExceptionType.cancel:
            serverException = ServerException._(
              exceptionType: ServerExceptionType.requestCancelled,
              statusCode: error.response?.statusCode,
              message: 'Request to the server has been canceled',
            );
            break;

          case DioExceptionType.connectionTimeout:
            serverException = ServerException._(
              exceptionType: ServerExceptionType.requestTimeout,
              statusCode: error.response?.statusCode,
              message: 'Connection timeout',
            );
            break;

          case DioExceptionType.receiveTimeout:
            serverException = ServerException._(
              exceptionType: ServerExceptionType.recieveTimeout,
              statusCode: error.response?.statusCode,
              message: 'Receive timeout',
            );
            break;

          case DioExceptionType.sendTimeout:
            serverException = ServerException._(
              exceptionType: ServerExceptionType.sendTimeout,
              statusCode: error.response?.statusCode,
              message: 'Send timeout',
            );
            break;

          case DioExceptionType.connectionError:
            serverException = ServerException._(
                exceptionType: ServerExceptionType.connectionError,
                statusCode: error.response?.statusCode,
                message: 'Connection error');
            break;
          case DioExceptionType.badCertificate:
            serverException = ServerException._(
              exceptionType: ServerExceptionType.badCertificate,
              statusCode: error.response?.statusCode,
              message: 'Bad certificate',
            );
            break;
          case DioExceptionType.unknown:
            if (error.error
                .toString()
                .contains(ServerExceptionType.socketException.name)) {
              serverException = ServerException._(
                exceptionType: ServerExceptionType.socketException,
                statusCode: error.response?.statusCode,
                message: 'Verify your internet connection',
              );
            } else {
              serverException = ServerException._(
                exceptionType: ServerExceptionType.unexpectedError,
                statusCode: error.response?.statusCode,
                message: 'Unexpected error',
              );
            }
            break;

          case DioExceptionType.badResponse:
            switch (error.response?.statusCode) {
              case 400:
                serverException = ServerException._(
                  exceptionType: ServerExceptionType.badRequest,
                  statusCode: error.response?.statusCode,
                  message: 'Bad request',
                );
                break;
              case 401:
                serverException = ServerException._(
                    exceptionType: ServerExceptionType.unauthorisedRequest,
                    statusCode: error.response?.statusCode,
                    message: 'Authentication failure');
                break;
              case 403:
                serverException = ServerException._(
                    exceptionType: ServerExceptionType.unauthorisedRequest,
                    statusCode: error.response?.statusCode,
                    message: 'User is not authorized to access API');
                break;
              case 404:
                serverException = ServerException._(
                    exceptionType: ServerExceptionType.notFound,
                    statusCode: error.response?.statusCode,
                    message: 'Not found');
                break;
              case 405:
                serverException = ServerException._(
                    exceptionType: ServerExceptionType.unauthorisedRequest,
                    statusCode: error.response?.statusCode,
                    message: 'Operation not allowed');
                break;
              case 415:
                serverException = ServerException._(
                    exceptionType: ServerExceptionType.notImplemented,
                    statusCode: error.response?.statusCode,
                    message: 'Media type unsupported');
                break;
              case 422:
                serverException = ServerException._(
                    exceptionType: ServerExceptionType.unableToProcess,
                    statusCode: error.response?.statusCode,
                    message: 'validation data failure');
                break;
              case 429:
                serverException = ServerException._(
                    statusCode: error.response?.statusCode,
                    exceptionType: ServerExceptionType.conflict,
                    message: 'too much requests');
                break;
              case 500:
                serverException = ServerException._(
                    statusCode: error.response?.statusCode,
                    exceptionType: ServerExceptionType.internalServerError,
                    message: 'Internal server error');
                break;
              case 503:
                serverException = ServerException._(
                    statusCode: error.response?.statusCode,
                    exceptionType: ServerExceptionType.serviceUnavailable,
                    message: 'Service unavailable');
                break;
              default:
                serverException = ServerException._(
                    statusCode: error.response?.statusCode,
                    exceptionType: ServerExceptionType.unexpectedError,
                    message: 'Unexpected error');
            }
            break;
        }
      } else {
        serverException = const ServerException._(
          message: 'Unexpected error',
          exceptionType: ServerExceptionType.unexpectedError,
        );
      }
    } on FormatException catch (e) {
      serverException = ServerException._(
        message: e.message,
        exceptionType: ServerExceptionType.formatException,
      );
    } on Exception catch (e) {
      serverException = ServerException._(
        message: e.toString(),
        exceptionType: ServerExceptionType.unexpectedError,
      );
    }

    return serverException;
  }

  @override
  List<Object?> get props => [
        exceptionType,
        statusCode,
      ];
}
