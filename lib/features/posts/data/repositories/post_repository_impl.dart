import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:practice1_app/core/error/exception.dart';
import 'package:practice1_app/core/error/failure.dart';
import 'package:practice1_app/features/posts/data/datasources/post_remote_data_source.dart';
import 'package:practice1_app/features/posts/domain/entities/post_entity.dart';
import 'package:practice1_app/features/posts/domain/repositories/post_repository.dart';

@LazySingleton(as: PostRepository)
class PostRepositoryImpl extends PostRepository {
  final PostRemoteDataSource postRemoteDataSource;

  PostRepositoryImpl(this.postRemoteDataSource);

  @override
  Future<Either<RemoteFailure, List<PostEntity>>> getPosts() async {
    try {
      final response = await postRemoteDataSource.getPosts();

      return Right(
          List<PostEntity>.from(response.map((e) => e.toEnity())));
    } on ServerException catch (e) {
      return Left(RemoteFailure(e.message, statusCode: e.statusCode));
    }
  }
}
