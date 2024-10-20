import 'package:currency_converter/functions.dart';
import 'package:flutter/material.dart';

class UsdToAny extends StatefulWidget {
  final Map rates;
  final Map currencies;
  const UsdToAny({super.key, required this.rates, required this.currencies});

  @override
  State<UsdToAny> createState() => _UsdToAnyState();
}

class _UsdToAnyState extends State<UsdToAny> {
  TextEditingController amountController = TextEditingController();
  String dropDownValue = "INR";
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
              "USD to other currencies",
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
              decoration: InputDecoration(hintText: 'Enter USD Amount'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: dropDownValue,
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
                        dropDownValue = newValue!;
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
                Container(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        ans =
                            '${amountController.text} USD = ${convertusd(widget.rates, amountController.text, dropDownValue)} $dropDownValue';
                      });
                    },
                    child: Text('Convert'),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
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
