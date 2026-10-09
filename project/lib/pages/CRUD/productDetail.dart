import 'package:flutter/material.dart';
import 'package:project/pages/CRUD/models/products.dart';
import 'package:project/pages/CRUD/productForm.dart';
import 'package:project/pages/CRUD/services/service.dart';

class Productdetail extends StatefulWidget {
  final Product product;
  const Productdetail({super.key, required this.product});

  @override
  State<Productdetail> createState() => _ProductdetailState();
}

class _ProductdetailState extends State<Productdetail> {
  final ProductService service = ProductService();
  bool isDeleting = false;

  Future<void> editProduct() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return Productform(product: widget.product);
        },
      ),
    );
    if (result == true) {
      if (!mounted) return;
      Navigator.pop(context, true);
    }
  }

  Future<void> deleteProdcut() async {
    final bool? confirm = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('delete product'),
          content: Text(
            'do you want to delete'
            '"${widget.product.name}"'
            'or not?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('cancle'),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('delete'),
            ),
          ],
        );
      },
    );

    if (confirm != true) {
      return;
    }
    setState(() {
      isDeleting = true;
    });
    try {
      await service.deleteProdcut(widget.product.id);
      if (!mounted) return;
      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        isDeleting = false;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('fail to deleted product $e')));
    }
  }

  //build
  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      appBar: AppBar(title: const Text('product details'),),
      body: Padding(padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text(product.name,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        ),
        const SizedBox(height: 20,),

        Text(
          'id: ${product.id}',
          style: const TextStyle(
            fontSize: 18
          ) ,
        ),
        const SizedBox(height: 10,),

        Text(
          'price: ${product.price} bath',
          style: const TextStyle(fontSize: 18),
        )
        ,const SizedBox(height: 10,),
        Text(
          'quantity: ${product.quantity}',
          style: TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 30,),
        
        // EDIT
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton.icon(
            onPressed: 
          isDeleting ? null : editProduct,
          icon: const Icon(Icons.edit),
          label: const Text(
            'edit product'
          ),
          ),
        ),
        const SizedBox(height: 12,),
        
        // DELETE
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton.icon(
            onPressed: isDeleting? null : deleteProdcut, 
            icon: const Icon(Icons.delete),
            label: isDeleting ?
            const SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(),
            )
            : const Text(
              'delete product'
            )
            ),
        )
        ],
      ),),
      
    );
  }
}
