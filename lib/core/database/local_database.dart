import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../features/posts/data/datasources/local/collections/post_collection.dart';

@singleton
class LocalDatabase {
  // late final Isar _isar;
  // bool _isInitialized = false;

  // Isar get db => _isInitialized
  //     ? _isar
  //     : throw IsarError('Isar has not been initialized.');

  // Future<void> initialize() async {
  //   if (_isInitialized) throw IsarError('Isar has already been initialized');

  //   final dir = await getApplicationDocumentsDirectory();
  //   _isar = await Isar.open(_schemas, directory: dir.path);

  //   _isInitialized = true;
  // }

  late Future<Isar> db;

  LocalDatabase() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();

      return await Isar.open(
        _schemas,
        inspector: true,
        directory: dir.path,
      );
    }

    return Future.value(Isar.getInstance());
  }
}

const _schemas = <CollectionSchema<dynamic>>[PostCollectionSchema];
