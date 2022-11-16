import 'dart:math';

import 'package:amond/presentation/screens/store/purchase_done_screen.dart';
import 'package:amond/presentation/screens/store/store_screen.dart';
import 'package:amond/presentation/widget/main_button.dart';
import 'package:amond/presentation/widget/platform_based_indicator.dart';
import 'package:amond/ui/colors.dart';
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  final StoreProduct product;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: MainButton(
              onPressed: () {
                showDialog(context: context, builder: (_) => const Center(child: CircularProgressIndicator(),));
                Future.delayed(const Duration(milliseconds: 2500)).then((value) {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => PurchaseDoneScreen(product: product,)));
                });
              },
              height: 60,
              child: const Text('구매하기'),
            ),
          )),
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              product.imageUrl,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '${product.price}원',
                        style: const TextStyle(
                            fontSize: 24, color: textBlueColor300),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        '${product.discountRate}%↓',
                        style: TextStyle(fontSize: 24, color: textBlueColor300),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text('현재 ${Random().nextInt(3) + 1}명의 농부님이 입점해 있습니다!'),
                  const SizedBox(height: 36),
                  Image.network(
                    'https://post-phinf.pstatic.net/MjAyMDA1MjJfMTQ2/MDAxNTkwMTE3MjM0NDU2.k-TOrEOhxRGSjE7ByodyzReZrxNDNSuHQS1loxuEA28g.JTE_RlbaTZyJhDKl2mQQSckV00uaduP2LMC6AcMWgPMg.PNG/C_3.png?type=w1200',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
