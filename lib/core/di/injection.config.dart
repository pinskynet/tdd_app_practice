// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../features/posts/data/datasources/local/post_local_data_source.dart'
    as _i7;
import '../../features/posts/data/datasources/remote/post_remote_data_source.dart'
    as _i8;
import '../../features/posts/data/repositories/post_repository_impl.dart'
    as _i10;
import '../../features/posts/domain/repositories/post_repository.dart' as _i9;
import '../../features/posts/domain/usecases/get_comments_by_post_id.dart'
    as _i12;
import '../../features/posts/domain/usecases/get_local_posts.dart' as _i13;
import '../../features/posts/domain/usecases/get_posts.dart' as _i14;
import '../../features/posts/domain/usecases/save_posts.dart' as _i11;
import '../../features/posts/presentation/bloc/posts_bloc.dart' as _i15;
import '../database/local_database.dart' as _i5;
import '../network/client.dart' as _i4;
import '../network/internet_connectivity_check.dart' as _i6;
import 'app_module.dart' as _i16;

// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final appModule = _$AppModule();
  gh.singleton<_i3.Dio>(() => appModule.dio);
  gh.singleton<_i4.DioClient>(() => _i4.DioClient());
  gh.singleton<_i5.LocalDatabase>(() => _i5.LocalDatabase());
  gh.singleton<_i6.NetworkInfo>(() => _i6.NetworkInfoImpl());
  gh.lazySingleton<_i7.PostLocalDataSource>(() =>
      _i7.PostLocalDataSourceImpl(localDatabase: gh<_i5.LocalDatabase>()));
  gh.lazySingleton<_i8.PostRemoteDataSource>(
      () => _i8.PostRemoteDataSourceImpl(client: gh<_i4.DioClient>()));
  gh.lazySingleton<_i9.PostRepository>(() => _i10.PostRepositoryImpl(
        gh<_i8.PostRemoteDataSource>(),
        gh<_i7.PostLocalDataSource>(),
      ));
  gh.lazySingleton<_i11.SavePostsUseCase>(
      () => _i11.SavePostsUseCase(gh<_i9.PostRepository>()));
  gh.lazySingleton<_i12.GetCommentsByPostIdUseCase>(
      () => _i12.GetCommentsByPostIdUseCase(gh<_i9.PostRepository>()));
  gh.lazySingleton<_i13.GetLocalPostsUseCase>(
      () => _i13.GetLocalPostsUseCase(gh<_i9.PostRepository>()));
  gh.lazySingleton<_i14.GetPostsUsecase>(
      () => _i14.GetPostsUsecase(gh<_i9.PostRepository>()));
  gh.factory<_i15.PostsBloc>(() => _i15.PostsBloc(
        gh<_i6.NetworkInfo>(),
        gh<_i14.GetPostsUsecase>(),
        gh<_i12.GetCommentsByPostIdUseCase>(),
        gh<_i13.GetLocalPostsUseCase>(),
        gh<_i11.SavePostsUseCase>(),
      ));
  return getIt;
}

class _$AppModule extends _i16.AppModule {}
