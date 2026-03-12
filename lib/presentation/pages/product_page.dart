
import 'package:flutter/material.dart';
import '../viewmodel/product_viewmodel.dart';

class ProductPage extends StatefulWidget {

  final ProductViewModel viewModel;

  const ProductPage(this.viewModel, {super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();

}

class _ProductPageState extends State<ProductPage> {

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
      return const Center(child: CircularProgressIndicator());
    }

    if (widget.viewModel.error != null) {
      return Center(child: Text(widget.viewModel.error!));
    }

    return ListView.builder(
      itemCount: widget.viewModel.products.length,
      itemBuilder: (context, index) {

        final product = widget.viewModel.products[index];

        return ListTile(
          title: Text(product.title),
          subtitle: Text("\$${product.price}"),
        );

      },
    );

  }

}
