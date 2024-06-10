// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'posts_bloc.dart';

abstract class PostsEvent extends Equatable {
  const PostsEvent();

  @override
  List<Object> get props => [];
}

class GetPosts extends PostsEvent {}

class GetCommentsByPostId extends PostsEvent {
  final int postId;

  const GetCommentsByPostId({
    required this.postId,
  });

  @override
  List<Object> get props => [postId];
}
