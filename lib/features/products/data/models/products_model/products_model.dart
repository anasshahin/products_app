import 'package:equatable/equatable.dart';

import 'product.dart';

class ProductsModel extends Equatable {
  final List<Product>? products;
  final int? total;
  final int? skip;
  final int? limit;

  const ProductsModel({this.products, this.total, this.skip, this.limit});

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
    products:
        (json['products'] as List<dynamic>?)
            ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
            .toList(),
    total: json['total'] as int?,
    skip: json['skip'] as int?,
    limit: json['limit'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'products': products?.map((e) => e.toJson()).toList(),
    'total': total,
    'skip': skip,
    'limit': limit,
  };

  @override
  List<Object?> get props => [products, total, skip, limit];
}
