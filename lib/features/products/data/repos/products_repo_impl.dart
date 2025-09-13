import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:products_project/core/errors/failures.dart';
import 'package:products_project/features/products/data/models/products_model/products_model.dart';
import 'package:products_project/features/products/data/repos/products_repo.dart';

import '../../../../core/utils/api_service.dart';

 class ProductsRepoImpl extends ProductsRepo{
   final ApiService apiService;
   ProductsRepoImpl(this.apiService);
  @override
  Future<Either<Failure, ProductsModel>> getAllProducts() async{
    try
    {

      Map<String, dynamic> data = await apiService.get();

      ProductsModel productsModel =ProductsModel.fromJson(data);

      return right(productsModel);
    }
    catch (e){

      if(e is DioException) return left(ServerFailure.fromDioError(e));
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getCategoryList() async {
    try
    {
      final  data = await apiService.get(endPoint: "/category-list");
      List<dynamic> categories = data as List<dynamic>;
      return right(categories.map((e) => e.toString()).toList());
    }
    catch (e){
      if(e is DioException) return left(ServerFailure.fromDioError(e));
      return left(ServerFailure(errMessage: e.toString()));
    }
  }
}