import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:practice1_app/core/di/injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
)
void configureInjection() => $initGetIt(getIt);
