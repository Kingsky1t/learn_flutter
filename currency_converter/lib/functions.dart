import 'package:currency_converter/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map> fetchCurrencies() async {
  var response = await http.get(Uri.parse(
      'https://openexchangerates.org/api/currencies.json?app_id=$api_key'));
  final allCurrencies = allCurrenciesFromJson(response.body);
  return allCurrencies;
}

Map<String, String> allCurrenciesFromJson(String str) =>
    Map.from(json.decode(str))
        .map((key, value) => MapEntry<String, String>(key, value));

Future<RatesModel> fetchRates() async {
  var response = await http.get(Uri.parse(
      'https://openexchangerates.org/api/latest.json?app_id=$api_key'));
  final result = ratesModelFromJson(response.body);
  return result;
}

RatesModel ratesModelFromJson(String str) =>
    RatesModel.fromJson(json.decode(str));

class RatesModel {
  RatesModel({
    required this.disclaimer,
    required this.license,
    required this.timestamp,
    required this.base,
    required this.rates,
  });

  String disclaimer;
  String license;
  int timestamp;
  String base;
  Map<String, double> rates;

  factory RatesModel.fromJson(Map<String, dynamic> json) => RatesModel(
        disclaimer: json['disclaimer'],
        license: json['license'],
        timestamp: json['timestamp'],
        base: json['base'],
        rates: Map.from(json['rates'])
            .map((k, v) => MapEntry<String, double>(k, v.toDouble())),
      );
}

String convertusd(Map exchangeRates, String amount, String currency) {
  double toCurrency = double.parse(amount) * exchangeRates[currency];
  return toCurrency.toStringAsFixed(2);
}

String convertany(Map exhangeRates, String amount, String currencyBase,
    String currencyFinal) {
  double toUsd = double.parse(amount) / exhangeRates[currencyBase];
  double toCurrency = toUsd * exhangeRates[currencyFinal];
  return toCurrency.toStringAsFixed(2);
}
