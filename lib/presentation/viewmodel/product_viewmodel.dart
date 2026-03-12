
import '../../domain/entities/product.dart';
import '../../domain/repository/product_repository.dart';

class ProductViewModel {

  final ProductRepository repository;

  bool loading = false;
  String? error;
  List<Product> products = [];

  ProductViewModel(this.repository);

  Future<void> loadProducts() async {

    loading = true;
    error = null;

    try {

      products = await repository.getProducts();

    } catch (e) {

      error = "Erro ao carregar produtos";

    }

    loading = false;

  }

}
