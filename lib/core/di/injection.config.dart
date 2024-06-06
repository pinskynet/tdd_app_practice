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

import '../../features/posts/data/datasources/post_remote_data_source.dart'
    as _i5;
import '../../features/posts/data/repositories/post_repository_impl.dart'
    as _i7;
import '../../features/posts/domain/repositories/post_repository.dart' as _i6;
import '../../features/posts/domain/usecases/get_posts.dart' as _i8;
import '../../features/posts/presentation/bloc/posts_bloc.dart' as _i9;
import '../network/client.dart' as _i4;
import 'app_module.dart' as _i10;

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
  gh.factory<_i4.DioClient>(() => _i4.DioClient());
  gh.lazySingleton<_i5.PostRemoteDataSource>(
      () => _i5.PostRemoteDataSourceImpl(client: gh<_i4.DioClient>()));
  gh.lazySingleton<_i6.PostRepository>(
      () => _i7.PostRepositoryImpl(gh<_i5.PostRemoteDataSource>()));
  gh.lazySingleton<_i8.GetPostsUsecase>(
      () => _i8.GetPostsUsecase(gh<_i6.PostRepository>()));
  gh.factory<_i9.PostsBloc>(() => _i9.PostsBloc(gh<_i8.GetPostsUsecase>()));
  return getIt;
}

class _$AppModule extends _i10.AppModule {}
