import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:practice1_app/core/database/local_database.dart';
import 'package:practice1_app/core/error/failure.dart';

import 'collections/post_collection.dart';

abstract class PostLocalDataSource {
  Future<bool> savePost(List<PostCollection> postsCollection);
  Future<List<PostCollection>> getPostLocal();
}

@LazySingleton(as: PostLocalDataSource)
class PostLocalDataSourceImpl implements PostLocalDataSource {
  final LocalDatabase localDatabase;

  PostLocalDataSourceImpl({required this.localDatabase});

  @override
  Future<bool> savePost(List<PostCollection> postsCollection) async {
    try {
      final db = await localDatabase.db;

      await db.writeTxn(() async => db.postCollections.putAll(postsCollection));

      return true;
    } on IsarError catch (e) {
      throw LocalFailure(e.message);
    }
  }

  @override
  Future<List<PostCollection>> getPostLocal() async {
    try {
      final db = await localDatabase.db;
      return await db.postCollections.where().findAll();
    } on IsarError catch (e) {
      throw LocalFailure(e.message);
    }
  }
}
