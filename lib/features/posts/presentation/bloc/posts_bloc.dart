import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:practice1_app/core/network/internet_connectivity_check.dart';
import 'package:practice1_app/features/posts/domain/entities/comment_entity.dart';
import 'package:practice1_app/features/posts/domain/entities/post_entity.dart';
import 'package:practice1_app/features/posts/domain/usecases/get_comments_by_post_id.dart';
import 'package:practice1_app/features/posts/domain/usecases/get_local_posts.dart';
import 'package:practice1_app/features/posts/domain/usecases/get_posts.dart';
import 'package:practice1_app/features/posts/domain/usecases/save_posts.dart';

part 'posts_event.dart';
part 'posts_state.dart';

@injectable
class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final NetworkInfo _networkInfo;
  final GetPostsUsecase _getPostsUsecase;
  final GetLocalPostsUseCase _getLocalPostsUseCase;
  final GetCommentsByPostIdUseCase _getCommentsByPostIdUseCase;
  final SavePostsUseCase _savePostsUseCase;

  PostsBloc(
    this._networkInfo,
    this._getPostsUsecase,
    this._getCommentsByPostIdUseCase,
    this._getLocalPostsUseCase,
    this._savePostsUseCase,
  ) : super(PostsInitial()) {
    on<GetPosts>(_onGetPosts);
    on<GetCommentsByPostId>(_onGetCommentByPostId);
  }

  FutureOr<void> _onGetPosts(GetPosts event, Emitter<PostsState> emit) async {
    emit(PostsLoading());

    try {
      if (await _networkInfo.hasConnection) {
        await _getPostsUsecase.execute().then(
              (v) => v.fold(
                (l) => emit(PostsLoadFailure(
                    message: l.message, statusCode: l.statusCode)),
                (r) async {
                  await _savePostsUseCase
                      .savePosts(posts: r.take(2).toList())
                      .then(
                        (v) => v.fold(
                          (l) => null,
                          (r) => debugPrint('Save posts: $r'),
                        ),
                      );

                  emit(PostsLoadSuccess(posts: r));
                },
              ),
            );
      } else {
        await _getLocalPostsUseCase.execute().then(
              (v) => v.fold(
                (l) => emit(PostsLoadFailure(message: l.message)),
                (r) => emit(PostsLoadSuccess(posts: r)),
              ),
            );
      }
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
