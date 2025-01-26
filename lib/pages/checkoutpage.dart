import 'package:flutter/material.dart';
import 'package:store_demo1/utils/my_widgets.dart';
import 'package:get/get.dart';
import '../utils/my_controllers.dart';

class CheckoutPage extends StatelessWidget {
  CheckoutPage({super.key});

  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    cartController.refreshToObsCart();
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button and checkout label
              Text(
                'Checkout',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              // Dynamic Checkouts List Section
              Obx(() {
                if (cartController.checkoutsObs.values.isEmpty) {
                  return Expanded(
                    child: Center(
                      child: Text(
                        "Cart is Empty",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                } else {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CheckoutListSection(),
                          SizedBox(
                            height: 20,
                          ),

                          ShippingInfoSection(),
                          // SizedBox(height: 75,)
                        ]),
                  );
                }
              }),
            ],
          ),
      ),
    );
  }
}
