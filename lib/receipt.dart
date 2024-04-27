import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class Receipt extends StatefulWidget {
  const Receipt({super.key});

  @override
  State<Receipt> createState() => _ReceiptState();
}

class _ReceiptState extends State<Receipt> {
  //  receipt extra details
  Widget detailCard({required String title, required String description}) =>
      Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.withOpacity(0.3), width: 1)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey)),
            const SizedBox(height: 4),
            Text(description,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: Colors.white)),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MultipleRoundedCurveClipper(),
      child: Container(
        width: 350,
        height: 500,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.transparent,
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: UnconstrainedBox(
                child: Container(
                  width: 350,
                  height: 470,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16)),
                    color: Color(0xff25282e),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 60),
                      //  title
                      const Column(
                        children: [
                          Text('Payment Success!',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white)),
                          Text('Your payment has been successfully done.',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey))
                        ],
                      ),

                      const SizedBox(height: 32),

                      Divider(height: 1, color: Colors.grey.withOpacity(0.3)),

                      const SizedBox(height: 24),

                      Expanded(
                          child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: Colors.transparent,
                        child: Column(
                          children: [
                            const Column(
                              children: [
                                Text('Total Payment',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey)),
                                SizedBox(height: 4),
                                Text('Ksh. 15,000',
                                    style: TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white)),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Expanded(
                                child: GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 8,
                                            mainAxisExtent: 70,
                                            mainAxisSpacing: 8),
                                    itemCount: 4,
                                    itemBuilder: (context, index) => detailCard(
                                        title: "Hello",
                                        description: "Hey there")))
                          ],
                        ),
                      )),
                    ],
                  ),
                ),
              ),
            ),

            //  Check mark at the top
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    color: Color(0xff25282e), shape: BoxShape.circle),
                child: Center(
                  child: Icon(
                    Icons.check_circle_rounded,
                    color: Colors.greenAccent,
                    size: 60,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
