import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:practice1_app/core/error/exception.dart';
import 'package:practice1_app/core/error/failure.dart';
import 'package:practice1_app/features/posts/domain/usecases/get_posts.dart';
import 'package:practice1_app/features/posts/presentation/bloc/posts_bloc.dart';

import '../../../../helpers/test_helper.mocks.dart';
import '../../dummy/post_entity_fixture.dart';

// class MockPostsBloc extends MockBloc<PostsEvent, PostsState>
//     implements PostsBloc {}

// late MockWeatherBloc mockWeatherBloc;

void main() {
  late final GetPostsUsecase mockGetPostsUsecase;
  late final PostsBloc postsBloc;

  setUp(() {
    mockGetPostsUsecase = MockGetPostsUsecase();
    postsBloc = PostsBloc(mockGetPostsUsecase);
  });

  const tPostEntities = PostEntityFixture.postEntities;

  blocTest<PostsBloc, PostsState>(
    'should emit [PostsLoading -> PostsLoadSuccess] when success',
    build: () {
      when(
        mockGetPostsUsecase.execute(),
      ).thenAnswer((realInvocation) async => const Right(tPostEntities));

      return postsBloc;
    },
    act: (bloc) => bloc.add(GetPosts()),
    expect: () => [
      PostsLoading(),
      const PostsLoadSuccess(posts: tPostEntities),
    ],
  );

  blocTest<PostsBloc, PostsState>(
    'should emit [PostsLoading -> PostsLoadFailure] when unsuccess',
    build: () {
      when(
        mockGetPostsUsecase.execute(),
      ).thenAnswer((realInvocation) async =>
          Left(RemoteFailure(ServerExceptionType.unexpectedError.name)));

      return postsBloc;
    },
    act: (bloc) => bloc.add(GetPosts()),
    expect: () => [
      PostsLoading(),
      PostsLoadFailure(message: ServerExceptionType.unexpectedError.name),
    ],
  );
}
