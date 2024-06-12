// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';

import 'package:practice1_app/core/error/exception.dart';
import 'package:practice1_app/core/error/failure.dart';
import 'package:practice1_app/features/posts/data/datasources/local/collections/post_collection.dart';
import 'package:practice1_app/features/posts/data/datasources/local/post_local_data_source.dart';
import 'package:practice1_app/features/posts/data/datasources/remote/post_remote_data_source.dart';
import 'package:practice1_app/features/posts/domain/entities/comment_entity.dart';
import 'package:practice1_app/features/posts/domain/entities/post_entity.dart';
import 'package:practice1_app/features/posts/domain/repositories/post_repository.dart';

@LazySingleton(as: PostRepository)
class PostRepositoryImpl extends PostRepository {
  final PostRemoteDataSource postRemoteDataSource;
  final PostLocalDataSource postLocalDataSource;

  PostRepositoryImpl(
    this.postRemoteDataSource,
    this.postLocalDataSource,
  );

  @override
  Future<Either<RemoteFailure, List<PostEntity>>> getPosts() async {
    try {
      final posts = await postRemoteDataSource.getPosts();

      return Right(posts.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(RemoteFailure(e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<RemoteFailure, List<CommentEntity>>> getCommentsByPostId(
      int postId) async {
    try {
      final comments = await postRemoteDataSource.getCommentsByPostId(postId);

      return Right(comments.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(RemoteFailure(e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<LocalFailure, List<PostEntity>>> getLocalPosts() async {
    try {
      final posts = await postLocalDataSource.getPostLocal();

      return Right(posts.map((e) => e.toEntity()).toList());
    } on IsarError catch (e) {
      return Left(LocalFailure(e.message));
    }
  }

  @override
  Future<Either<LocalFailure, bool>> savePosts(List<PostEntity> posts) async {
    try {
      final isSaved = await postLocalDataSource.savePost(posts
          .map((e) => PostCollection(
                id: e.id,
                userId: e.userId,
                title: e.title,
                body: e.body,
              ))
          .toList());

      return Right(isSaved);
    } on IsarError catch (e) {
      return Left(LocalFailure(e.message));
    }
  }
}
