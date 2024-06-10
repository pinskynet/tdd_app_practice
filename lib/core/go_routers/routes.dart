import 'package:equatable/equatable.dart';

class RoutePaths extends Equatable {
  static const posts = '/';

  static const comments = '/comments';

  @override
  List<Object?> get props => [posts, comments];
}
