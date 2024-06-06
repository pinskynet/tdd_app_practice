import 'package:practice1_app/features/posts/domain/entities/post_entity.dart';

class PostEntityFixture {
  static const post1 = PostEntity(
    id: 1,
    userId: 1,
    title:
        'sunt aut facere repellat provident occaecati excepturi optio reprehenderit',
    body:
        'quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto',
  );

  static const post2 = PostEntity(
    id: 2,
    userId: 1,
    title: 'qui est esse',
    body:
        'est rerum tempore vitae\nsequi sint nihil reprehenderit dolor beatae ea dolores neque\nfugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis\nqui aperiam non debitis possimus qui neque nisi nulla',
  );

  static const postEntities = [post1, post2];
}
