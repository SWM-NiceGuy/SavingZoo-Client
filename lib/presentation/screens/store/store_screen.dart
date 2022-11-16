import 'package:amond/presentation/screens/store/product_detail_screen.dart';
import 'package:amond/ui/colors.dart';
import 'package:flutter/material.dart';

class StoreScreen extends StatelessWidget {
  StoreScreen({Key? key}) : super(key: key);

  final List<StoreProduct> products = [
    StoreProduct(
      name: '못난이 사과 5kg',
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT45gPiZ16XA0A9zNQRwTWdM2pBI4DyJMzb7g&usqp=CAU',
      price: 12900,
      discountRate: 25,
    ),
    StoreProduct(
      name: '못난이 감자 3kg',
      imageUrl:
          'https://img.danawa.com/prod_img/500000/765/082/img/11082765_1.jpg?shrink=330:330&_v=20200414142333',
      price: 8000,
      discountRate: 30,
    ),
     StoreProduct(
      name: '못난이 고구마 10kg',
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQIKVmly5Lnu64olaGCGyg4DbNyGfH0TmGJOn2qw5exwa-PkVWp1-XyPjXsVH92zwkUCo&usqp=CAU',
      price: 20000,
      discountRate: 30,
    ),
     StoreProduct(
      name: '못난이 주스용 당근 10kg',
      imageUrl:
          'https://contents.sixshop.com/thumbnails/uploadedFiles/48764/product/image_1616298944445_1500.jpg',
      price: 15000,
      discountRate: 40,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 4 / 6,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: List.generate(
            products.length,
            (index) => ProductCard(
                  product: products[index],
                )));
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  final StoreProduct product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => ProductDetailScreen(
                  product: product,
                )));
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            product.name,
            style: const TextStyle(fontSize: 18),
          ),
          Row(
            children: [
              Text(
                '${product.price}원',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 12),
              Text(
                '${product.discountRate}%',
                style: const TextStyle(
                    fontSize: 18,
                    color: textBlueColor300,
                    fontWeight: FontWeight.bold),
              )
            ],
          )
        ],
      ),
    );
  }
}

class StoreProduct {
  final String name;
  final String imageUrl;
  final int price;
  final int discountRate;

  StoreProduct({
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.discountRate,
  });
}
