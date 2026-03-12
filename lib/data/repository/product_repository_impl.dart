
import '../../domain/entities/product.dart';
import '../../domain/repository/product_repository.dart';
import '../datasource/product_api_datasource.dart';

class ProductRepositoryImpl implements ProductRepository {

  final ProductApiDataSource dataSource;

  List<Product>? _cache;

  ProductRepositoryImpl(this.dataSource);

  @override
  Future<List<Product>> getProducts() async {

    try {

      final products = await dataSource.getProducts();

      _cache = products;

      return products;

    } catch (e) {

      if (_cache != null) {
        return _cache!;
      }

      throw Exception("Erro ao buscar produtos");

    }

  }

}
