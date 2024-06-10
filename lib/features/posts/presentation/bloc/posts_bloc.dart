import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:practice1_app/features/posts/domain/entities/comment_entity.dart';
import 'package:practice1_app/features/posts/domain/entities/post_entity.dart';
import 'package:practice1_app/features/posts/domain/usecases/get_comments_by_post_id.dart';
import 'package:practice1_app/features/posts/domain/usecases/get_posts.dart';

part 'posts_event.dart';
part 'posts_state.dart';

@injectable
class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetPostsUsecase _getPostsUsecase;
  final GetCommentsByPostIdUseCase _getCommentsByPostIdUseCase;

  PostsBloc(this._getPostsUsecase, this._getCommentsByPostIdUseCase)
      : super(PostsInitial()) {
    on<GetPosts>(_onGetPosts);
    on<GetCommentsByPostId>(_onGetCommentByPostId);
  }

  FutureOr<void> _onGetPosts(GetPosts event, Emitter<PostsState> emit) async {
    emit(PostsLoading());

    try {
      await _getPostsUsecase.execute().then(
            (v) => v.fold(
              (l) => emit(PostsLoadFailure(
                  message: l.message, statusCode: l.statusCode)),
              (r) => emit(PostsLoadSuccess(posts: r)),
            ),
          );
    } catch (e) {
      emit(PostsLoadFailure(message: e.toString()));
    }
  }

  FutureOr<void> _onGetCommentByPostId(
      GetCommentsByPostId event, Emitter<PostsState> emit) async {
    emit(CommentsLoading());

    try {
      await _getCommentsByPostIdUseCase.execute(postId: event.postId).then(
            (v) => v.fold(
              (l) => emit(CommentLoadFailure(
                message: l.message,
                statusCode: l.statusCode,
              )),
              (r) => emit(CommentsLoadSuccess(comments: r)),
            ),
          );
    } catch (e) {
      emit(CommentLoadFailure(message: e.toString()));
    }
  }
}
