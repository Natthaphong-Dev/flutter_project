import 'package:flutter/material.dart';
import 'package:project/pages/CRUD/models/products.dart';
import 'package:project/pages/CRUD/services/service.dart';

class Productform extends StatefulWidget {
  final Product? product;

  const Productform({super.key, this.product});

  @override
  State<Productform> createState() => _ProductformState();
}

class _ProductformState extends State<Productform> {
  
  final ProductService service = ProductService();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  bool isLoading = false;
  bool get isEdit {
    return widget.product != null;
  }

  @override
  void initState() {
    super.initState();
    // ถ้ามี product แสดงว่าเป็นหน้าแก้ไข
    if (isEdit) {
      nameController.text = widget.product!.name;
      priceController.text = widget.product!.price.toString();
      quantityController.text = widget.product!.quantity.toString();
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    quantityController.dispose();

    super.dispose();
  }

  //save
  Future<void> saveProduct() async {
    final String name = nameController.text.trim();
    final double? price = double.tryParse(priceController.text.trim());
    final int? quantity = int.tryParse(quantityController.text.trim());

    //validation
    if (name.isEmpty || price == null || quantity == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('please fill correct')));
      return;
    }
    setState(() {
      isLoading = true;
    });

    try {
      if (isEdit) {
        await service.updateProdcut(
          id: widget.product!.id,
          name: name,
          price: price,
          quantity: quantity,
        );
      } else {
        await service.createProduct(
          name: name,
          price: price,
          quantity: quantity,
        );
      }
      if (!mounted) return;

      Navigator.pop(context, true);
    }catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'เกิดข้อผิดพลาด: $e',
          ),
        ),
      );
      } finally {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
      }
    }
  }
//ui
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEdit ? 'edit product' : 'add product'
        ),
      ),
      body: Padding(padding: const EdgeInsets.all(16)
      ,child:  Column(
        children: [
          TextField( //product name form
            controller: nameController,
            decoration:  const InputDecoration(
              labelText: 'name product',
              border:  OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16,),

          TextField(//product price form
            controller: priceController,

            keyboardType: 
              const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'price',
                border: OutlineInputBorder(),
              ),
          ),
          const SizedBox(height: 16,),

          TextField( //product price form
            controller: quantityController,

            keyboardType: 
              TextInputType.number,

              decoration: const InputDecoration(
                labelText: 'quantity',
                border: OutlineInputBorder(),
              ),
          ),
          const SizedBox(height: 24,),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(onPressed: 
            isLoading ? null : saveProduct, child: 
            isLoading ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(),
            )
            :Text(isEdit ? 'save product':'added product')
            
            ),
          )

        ],
      ),
      ),
      
    );
  }
}
