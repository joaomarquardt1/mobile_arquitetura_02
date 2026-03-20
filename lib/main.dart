
import 'package:flutter/material.dart';
import 'data/datasource/product_api_datasource.dart';
import 'data/repository/product_repository_impl.dart';
import 'presentation/viewmodel/product_viewmodel.dart';
import 'presentation/pages/home_page.dart';

void main() {
  final datasource = ProductApiDataSource();
  final repository = ProductRepositoryImpl(datasource);
  final viewModel = ProductViewModel(repository);

  runApp(MyApp(viewModel));
}

class MyApp extends StatelessWidget {
  final ProductViewModel viewModel;

  const MyApp(this.viewModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loja de Produtos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: HomePage(viewModel),
    );
  }
}
