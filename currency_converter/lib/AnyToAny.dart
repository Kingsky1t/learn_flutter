import 'package:currency_converter/functions.dart';
import 'package:flutter/material.dart';

class AnyToAny extends StatefulWidget {
  final Map rates;
  final Map currencies;
  const AnyToAny({super.key, required this.rates, required this.currencies});

  @override
  State<AnyToAny> createState() => _AnyToAnyState();
}

class _AnyToAnyState extends State<AnyToAny> {
  TextEditingController amountController = TextEditingController();
  String baseCurrencyDropDownValue = 'INR';
  String finalCurrencyDropDownValue = 'USD';
  String ans = "Converted Currency will be shown here";

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Convert any other currency",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              key: ValueKey("usd"),
              controller: amountController,
              decoration: InputDecoration(hintText: 'Enter Amount'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: baseCurrencyDropDownValue,
                    icon: const Icon(Icons.arrow_drop_down_rounded),
                    iconSize: 24,
                    elevation: 16,
                    isExpanded: true,
                    underline: Container(
                      height: 2,
                      color: Colors.grey.shade400,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        baseCurrencyDropDownValue = newValue!;
                      });
                    },
                    items: widget.currencies.keys.toList().map((value) {
                      return DropdownMenuItem<String>(
                          value: value, child: Text(value));
                    }).toList(),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text('To'),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: DropdownButton<String>(
                    value: finalCurrencyDropDownValue,
                    icon: const Icon(Icons.arrow_drop_down_rounded),
                    iconSize: 24,
                    elevation: 16,
                    isExpanded: true,
                    underline: Container(
                      height: 2,
                      color: Colors.grey.shade400,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        finalCurrencyDropDownValue = newValue!;
                      });
                    },
                    items: widget.currencies.keys.toList().map((value) {
                      return DropdownMenuItem<String>(
                          value: value, child: Text(value));
                    }).toList(),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    ans =
                        '${amountController.text} $baseCurrencyDropDownValue = ${convertany(widget.rates, amountController.text, baseCurrencyDropDownValue, finalCurrencyDropDownValue)} $finalCurrencyDropDownValue';
                  });
                },
                child: Text('Convert'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Text(ans),
            ),
          ],
        ),
      ),
    );
  }
}
