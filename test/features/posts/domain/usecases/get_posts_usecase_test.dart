import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:practice1_app/features/posts/domain/usecases/get_posts.dart';

import '../../../../helpers/test_helper.mocks.dart';
import '../../dummy/post_entity_fixture.dart';

void main() {
  late GetPostsUsecase getPostsUsecase;
  late MockPostRepository mockPostRepository;

  setUp(() {
    mockPostRepository = MockPostRepository();
    getPostsUsecase = GetPostsUsecase(mockPostRepository);
  });

  const tPostsEntity = PostEntityFixture.postEntities;

  test(
    'should get posts from the repository',
    () async {
      // arrange
      when(
        mockPostRepository.getPosts(),
      ).thenAnswer((realInvocation) async => const Right(tPostsEntity));

      // act
      final result = await getPostsUsecase.execute();

      // assert
      expect(result, const Right(tPostsEntity));
    },
  );
}
