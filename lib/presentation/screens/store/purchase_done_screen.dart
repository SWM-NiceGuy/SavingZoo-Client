
import 'package:amond/presentation/screens/store/store_screen.dart';
import 'package:amond/ui/colors.dart';
import 'package:flutter/material.dart';

class PurchaseDoneScreen extends StatelessWidget {
  const PurchaseDoneScreen({Key? key, required this.product}) : super(key: key);

  final StoreProduct product;


  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('구매 완료!', style: TextStyle(color: Colors.white),),
        automaticallyImplyLeading: false,
        backgroundColor: textBlueColor200,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '구매가 완료되었습니다!',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: const DecorationImage(
                        image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQHKKhVHOgeXUXgSF4PxSAFxKbtiNS8L58OLER4ug8NkO_1_lik6MXCtFjMrMxqc8y5xaU&usqp=CAU')),
                    border: Border.all(color: textBlueColor200, width: 3),
                  ),
                ),
                const SizedBox(height: 40),
                RichText(
                  text: const TextSpan(
                    text: '이춘삼',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black),
                    children: [
                      TextSpan(
                        text: ' 농부님이 보내주실 예정이에요~',
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text:  TextSpan(
                    text: product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 16
                    ),
                    children: const [
                      TextSpan(
                        text: '을 구출해주셔서 감사합니다 \u{1F60A}',
                        style: TextStyle(fontWeight: FontWeight.normal)
                      )
                    ]
                  )
                ),
                const SizedBox(height: 24),
                Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                      image:  DecorationImage(
                        image: NetworkImage(
                            product.imageUrl),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(6)),
                ),
                const SizedBox(height: 24),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).popUntil(ModalRoute.withName('/'));
                  },
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                    horizontal: deviceSize.width * 0.25,
                    vertical: 12,
                  )),
                  child: const Text(
                    '홈으로 돌아가기',
                    style: TextStyle(fontSize: 18),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
