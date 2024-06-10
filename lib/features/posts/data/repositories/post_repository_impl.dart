import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:practice1_app/core/error/exception.dart';
import 'package:practice1_app/core/error/failure.dart';
import 'package:practice1_app/features/posts/data/datasources/post_remote_data_source.dart';
import 'package:practice1_app/features/posts/domain/entities/comment_entity.dart';
import 'package:practice1_app/features/posts/domain/entities/post_entity.dart';
import 'package:practice1_app/features/posts/domain/repositories/post_repository.dart';

@LazySingleton(as: PostRepository)
class PostRepositoryImpl extends PostRepository {
  final PostRemoteDataSource postRemoteDataSource;

  PostRepositoryImpl(this.postRemoteDataSource);

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
}
