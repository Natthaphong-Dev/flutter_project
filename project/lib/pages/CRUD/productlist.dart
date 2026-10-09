import 'package:flutter/material.dart';
import 'package:project/pages/CRUD/models/products.dart';
import 'package:project/pages/CRUD/productDetail.dart';
import 'package:project/pages/CRUD/productForm.dart';
import 'package:project/pages/CRUD/services/service.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final ProductService service = ProductService();
  late Future<List<Product>> futureProduct;

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  //load product
  void loadProducts() {
    futureProduct = service.getProducts();
  }

  //refresh
  Future<void> refreshProduct() async {
    setState(() {
      loadProducts();
    });
    await futureProduct;
  }

  //add product
  Future<void> addProduct() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const Productform();
        },
      ),
    );
    if (result == true) {
      setState(() {
        loadProducts();
      });
    }
  }

  //open Detail
  Future<void> openDetail(Product product) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return Productdetail(product: product);
        },
      ),
    );
    if (result == true) {
      setState(() {
        loadProducts();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("list Product")),
      body: FutureBuilder<List<Product>>(
        future: futureProduct,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("error ${snapshot.error}"));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("no product now"));
          }

          final products = snapshot.data!;

          return RefreshIndicator(
            onRefresh: refreshProduct,
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ListTile(
                  leading: CircleAvatar(child: Text('${product.id}')),
                  title: Text(product.name),
                  subtitle: Text(
                    'price ${product.price} bath '
                    'quantity ${product.quantity}',
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                  onTap: () {
                    openDetail(product);
                  },
                );
              },
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: addProduct,
        child: const Icon(Icons.add),
      ),
    );
  }
}
