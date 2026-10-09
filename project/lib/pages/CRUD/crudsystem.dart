import 'package:flutter/material.dart';
import 'package:project/pages/CRUD/productlist.dart';

class Crud extends StatelessWidget {
  const Crud({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const ProductList();
              },
            ),
          );
        },
        child: const Text('เรียกดูข้อมูล'),
      ),
    );
  }
}
