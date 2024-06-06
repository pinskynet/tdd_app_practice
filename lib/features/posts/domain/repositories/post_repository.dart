import 'package:dartz/dartz.dart';
import 'package:practice1_app/core/error/failure.dart';
import 'package:practice1_app/features/posts/domain/entities/post_entity.dart';

abstract class PostRepository {
  Future<Either<RemoteFailure, List<PostEntity>>> getPosts();
}
