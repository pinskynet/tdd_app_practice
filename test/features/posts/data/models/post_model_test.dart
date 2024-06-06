import 'dart:convert';

import 'package:practice1_app/features/posts/data/models/post_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:practice1_app/features/posts/domain/entities/post_entity.dart';

import '../../../../helpers/json_reader.dart';
import '../../dummy/post_fixture.dart';

void main() {
  const tPostModel = PostModelFixture.post2;

  test(
    'should be a subclass of post entity',
    () async {
      // act
      final result = tPostModel.toEnity();

      // assert
      expect(result, isA<PostEntity>());
    },
  );

  test(
    'should return a valid model from json',
    () async {
      // arrange
      final Map<String, dynamic> jsonData =
          jsonDecode(readJson('features/posts/dummy/post_data.json'));

      // act
      final result = PostModel.fromJson(jsonData);

      // assert
      expect(result, equals(tPostModel));
    },
  );
}
