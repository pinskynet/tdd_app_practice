import 'package:practice1_app/features/posts/data/models/post_model.dart';

class PostModelFixture {
  static final post1 = PostModel(
    userId: 1,
    id: 1,
    title:
        'sunt aut facere repellat provident occaecati excepturi optio reprehenderit',
    body:
        'quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto',
  );

  static final post2 = PostModel(
    userId: 1,
    id: 2,
    title: 'qui est esse',
    body:
        'est rerum tempore vitae\nsequi sint nihil reprehenderit dolor beatae ea dolores neque\nfugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis\nqui aperiam non debitis possimus qui neque nisi nulla',
  );

  static final List<PostModel> postModels = [post1, post2];
}
