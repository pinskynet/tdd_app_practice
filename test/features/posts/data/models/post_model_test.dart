import 'dart:convert';

import 'package:practice1_app/features/posts/data/models/post_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:practice1_app/features/posts/domain/entities/post_entity.dart';

import '../../../../helpers/json_reader.dart';
import '../../dummy/post_fixture.dart';

void main() {
  final tPostModel = PostModelFixture.post1;

  test(
    'should be a subclass of post entity',
    () async {
      // act
      final result = tPostModel.toEntity();

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
      expect(result, tPostModel);
    },
  );
}
