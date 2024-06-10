import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:practice1_app/constants/endpoint.dart';
import 'package:practice1_app/core/error/exception.dart';
import 'package:practice1_app/features/posts/data/datasources/post_remote_data_source.dart';
import 'package:practice1_app/features/posts/data/models/post_model.dart';

import '../../../../helpers/json_reader.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockDioClient mockDioClient;
  late PostRemoteDataSourceImpl postRemoteDataSourceImpl;

  setUp(() {
    mockDioClient = MockDioClient();
    postRemoteDataSourceImpl = PostRemoteDataSourceImpl(client: mockDioClient);
  });

  final jsonData = jsonDecode(readJson('features/posts/dummy/posts_data.json'));

  group(
    'get posts',
    () {
      test(
        'should return List<PostModel> when the response code is 200',
        () async {
          // arrange

          when(mockDioClient.get(Endpoint.posts)).thenAnswer(
            (realInvocation) async => Response(
              requestOptions: RequestOptions(path: Endpoint.posts),
              statusCode: HttpStatus.ok,
              data: jsonData,
            ),
          );

          // act
          final result = await postRemoteDataSourceImpl.getPosts();

          // assert
          final matcher = List<PostModel>.from(
              (jsonData as List).map((e) => PostModel.fromJson(e)));

          expect(result, isA<List<PostModel>>());
          expect(result, matcher);
          verify(mockDioClient.get(Endpoint.posts));
        },
      );

      test(
        'should throw a server exception when the response code is 404 or other',
        () async {
          //arrange
          when(
            mockDioClient.get(Endpoint.posts),
          ).thenAnswer(
            (realInvocation) async => Response(
              requestOptions: RequestOptions(path: Endpoint.posts),
              statusCode: 404,
              statusMessage: 'Not Found',
            ),
          );

          //act
          final result = postRemoteDataSourceImpl.getPosts();

          //assert
          expect(result, throwsA(isA<ServerException>()));
        },
      );
    },
  );
}
