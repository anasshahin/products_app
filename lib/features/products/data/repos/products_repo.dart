import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../models/products_model/products_model.dart';

abstract class ProductsRepo {
  Future<Either<Failure, ProductsModel>>  getAllProducts();
  Future<Either<Failure, List<String>>>  getCategoryList();

}