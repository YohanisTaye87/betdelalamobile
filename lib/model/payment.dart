import 'package:betdelalamobile/providers/auth.dart';
import 'package:provider/provider.dart';
import 'package:yenepay_flutter/models/enums.dart';
import 'package:yenepay_flutter/models/yenepay_item.dart';
import 'package:yenepay_flutter/models/yenepay_parameters.dart';
import 'package:yenepay_flutter/yenepay_flutter.dart';
import 'package:flutter/material.dart';

class Payment extends StatefulWidget {
  Payment({super.key, this.name = 'jo'});

  String name;

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactNumberController =
      TextEditingController();
  final TextEditingController _remarkController = TextEditingController();
  @override
  void initState() {
    YenepayFlutter.init(
      onPaymentSuccess: (List<YenepayItem> items) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Donation success')));
      },
      onPaymentCancel: (List<YenepayItem> items) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Donation Cancelled')));
      },
      onPaymentFailure: (List<YenepayItem> items) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Donation failed ')));
      },
      onError: (e) {
        print("onError ${e.toString()}");
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
    YenepayFlutter.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String id = Provider.of<Auth>(context).token!;
    final formkey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Make Payment',
          style: TextStyle(
            fontFamily: "CentraleSansRegular",
            //color: task_col,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 32.0),
              Form(
                key: formkey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        hintText: 'Full name',
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _contactNumberController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        hintText: 'Contact number',
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Enter payment amount',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter Amount';
                        }
                        final number = double.tryParse(value);
                        if (number == null || number <= 0) {
                          return 'Please enter a Valid Amount';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _remarkController,
                      decoration: const InputDecoration(
                        hintText: 'Remark',
                      ),
                    ),
                    const SizedBox(height: 16.0),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  String amount = _amountController.text.trim();
                  if (formkey.currentState!.validate()) {
                    if (amount.isNotEmpty) {
                      YenepayFlutter.startPayment(
                          isTestEnv: true,
                          yenepayParameters: YenepayParameters(
                            process: YenepayProcess.Express,
                            merchantId: "26550",
                            items: [
                              YenepayItem(
                                itemId: '1',
                                unitPrice: double.parse(amount),
                                quantity: 1,
                                itemName: 'Pay',
                              ),
                            ],
                          ));
                      Navigator.of(context).pop();
                    }
                  }
                },
                child: const Text('Payment with YenePay'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
