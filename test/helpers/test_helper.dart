import 'package:mockito/annotations.dart';
import 'package:practice1_app/core/network/client.dart';
import 'package:practice1_app/features/posts/data/datasources/remote/post_remote_data_source.dart';
import 'package:practice1_app/features/posts/domain/repositories/post_repository.dart';
import 'package:practice1_app/features/posts/domain/usecases/get_comments_by_post_id.dart';
import 'package:practice1_app/features/posts/domain/usecases/get_posts.dart';

@GenerateMocks(
  [
    DioClient,
    PostRepository,
    PostRemoteDataSource,
    GetPostsUsecase,
    GetCommentsByPostIdUseCase,
  ],
)
void main() {}
