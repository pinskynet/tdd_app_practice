import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:practice1_app/features/posts/domain/entities/post_entity.dart';
import 'package:practice1_app/features/posts/domain/usecases/get_posts.dart';

part 'posts_event.dart';
part 'posts_state.dart';

@injectable
class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetPostsUsecase _getPostsUsecase;

  PostsBloc(this._getPostsUsecase) : super(PostsInitial()) {
    on<GetPosts>(_onGetPosts);
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
}
