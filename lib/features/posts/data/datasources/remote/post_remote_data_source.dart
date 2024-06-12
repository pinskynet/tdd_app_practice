import 'package:injectable/injectable.dart';
import 'package:practice1_app/constants/endpoint.dart';
import 'package:practice1_app/core/error/exception.dart';
import 'package:practice1_app/core/network/client.dart';
import 'package:practice1_app/features/posts/data/models/comment_model.dart';
import 'package:practice1_app/features/posts/data/models/post_model.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getPosts();
  Future<List<CommentModel>> getCommentsByPostId(int postId);
}

@LazySingleton(as: PostRemoteDataSource)
class PostRemoteDataSourceImpl extends PostRemoteDataSource {
  final DioClient client;

  PostRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PostModel>> getPosts() async {
    final response = await client.get(Endpoint.posts);

    if (response.statusCode == 200) {
      return List.from(
          (response.data as List).map((e) => PostModel.fromJson(e)));
    } else {
      throw ServerException(response);
    }
  }

  @override
  Future<List<CommentModel>> getCommentsByPostId(int postId) async {
    final respose = await client
        .get(Endpoint.comments, queryParameters: {"postId": postId});

    if (respose.statusCode == 200) {
      return List.from(
          (respose.data as List).map((e) => CommentModel.fromJson(e)));
    } else {
      throw ServerException(respose);
    }
  }
}
