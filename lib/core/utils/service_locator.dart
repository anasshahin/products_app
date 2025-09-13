
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/data/repos/auth_repo_impl.dart';
import '../../features/products/data/repos/products_repo_impl.dart';
import 'api_service.dart';

final getIt = GetIt.instance;

void setup(){
  getIt.registerSingleton<FirebaseAuth>
    (FirebaseAuth.instance);

  getIt.registerSingleton<Dio>( Dio());
  getIt.registerSingleton<ApiService>(ApiService(
      getIt<Dio>()
  ));


  getIt.registerSingleton<AuthRepoImpl>(
    AuthRepoImpl(),);

  getIt.registerSingleton<ProductsRepoImpl>(
    ProductsRepoImpl(getIt<ApiService>()),);
}