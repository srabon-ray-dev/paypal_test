import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:paypal/constant/app_icon.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  List myList = [
    {
      "name": "A demo product",
      "quantity": 2,
      "price": '10.00',
      "currency": "USD"
    },
    {
      "name": "A demo product",
      "quantity": 1,
      "price": '10.00',
      "currency": "USD"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("P A Y P A L"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                payment(context);
              },
              child: const Text("Pay With Paypal"),
            ),
            ElevatedButton(
              onPressed: () {
                myList.add(
                  {
                    "name": "A demo product",
                    "quantity": 1,
                    "price": '5.00',
                    "currency": "USD"
                  },
                );
              },
              child: Text('Pay'),
            ),
          ],
        ),
      ),
    );
  }

  void payment(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => UsePaypal(
            sandboxMode: true,
            clientId:
                "ARAnV0a2Mn_3ATnDJA0yf8CNxp8FzJrzlbXqxMhhXTk1UA6-Wx0QbX-WBVOXoA1aPnlrB_xgYW2g6gU0",
            secretKey:
                "EH8RBMhamXUzXGVU9NaiFauGnmjQbtAhLEOWlCjSv2lXu9VII66tPjl2ZxFHLZVCkO6Lf5FYK4Di5s12",
            returnURL: "https://samplesite.com/return",
            cancelURL: "https://samplesite.com/cancel",
            transactions: [
              {
                "amount": {
                  "total": '45.00', //Whereas Total has to be Tax + shipping + subtotal
                  "currency": "USD",
                  "details": {
                    "subtotal": '35.00', //subtotal has to be Price * Quantity
                    "shipping": '10',
                    "shipping_discount": 0
                  }
                },
                "description": "The payment transaction description.",
                 "payment_options": {
                   "allowed_payment_method":
                       "INSTANT_FUNDING_SOURCE"
                 },
                "item_list": {
                  "items": myList,

                  // shipping address is not required though
                 /* "shipping_address": {
                    "recipient_name": "Jane Foster",
                    "line1": "Travis County",
                    "line2": "",
                    "city": "Austin",
                    "country_code": "US",
                    "postal_code": "73301",
                    "phone": "+00000000",
                    "state": "Texas"
                  },*/
                }
              }
            ],
            note: "Contact us for any questions on your order.",
            onSuccess: (Map params) async {
              print("onSuccess: $params");
            },
            onError: (error) {
              print("onError: $error");
            },
            onCancel: (params) {
              print('cancelled: $params');
            }),
      ),
    );
  }
}
