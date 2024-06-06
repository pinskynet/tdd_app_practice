// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'posts_bloc.dart';

abstract class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object?> get props => [];
}

class PostsInitial extends PostsState {}

class PostsLoading extends PostsState {}

class PostsLoadFailure extends PostsState {
  final String message;
  final int? statusCode;

  const PostsLoadFailure({
    required this.message,
    this.statusCode,
  });

  @override
  List<Object?> get props => [message,statusCode,];
}

class PostsLoadSuccess extends PostsState {
  final List<PostEntity> posts;

  const PostsLoadSuccess({
    required this.posts,
  });

  @override
  List<Object> get props => [posts];
}
