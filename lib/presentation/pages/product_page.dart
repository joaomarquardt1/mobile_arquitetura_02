
import 'package:flutter/material.dart';
import '../viewmodel/product_viewmodel.dart';
import 'product_detail_page.dart';

class ProductListPage extends StatefulWidget {

  final ProductViewModel viewModel;

  const ProductListPage(this.viewModel, {super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();

}

class _ProductListPageState extends State<ProductListPage> {

  @override
  void initState() {
    super.initState();
    widget.viewModel.loadProducts().then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {

    if (widget.viewModel.loading) {
      return Scaffold(
        appBar: AppBar(title: const Text("Produtos")),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (widget.viewModel.error != null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Produtos")),
        body: Center(child: Text(widget.viewModel.error!)),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Produtos"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: widget.viewModel.products.length,
        itemBuilder: (context, index) {

          final product = widget.viewModel.products[index];

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ListTile(
              leading: Container(
                width: 60,
                height: 60,
                color: Colors.grey[200],
                child: Image.network(
                  product.image,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.image_not_supported);
                  },
                ),
              ),
              title: Text(
                product.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(
                    "\$${product.price.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 14, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text("${product.rating.toStringAsFixed(1)} / 5.0"),
                    ],
                  ),
                ],
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailPage(product),
                  ),
                );
              },
            ),
          );

        },
      ),
    );

  }

}
