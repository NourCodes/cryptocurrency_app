import 'package:flutter/material.dart';

class CryptoCard extends StatelessWidget {
  const CryptoCard({
    super.key,
    required this.value,
    required this.selectedCurrency,
    required this.cryptoCurrency,
    required this.image,
  });
  final String image;
  final String value;
  final String selectedCurrency;
  final String cryptoCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              blurStyle: BlurStyle.outer,
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 3,
              spreadRadius: 1.0,
              offset: const Offset(0, 0))
        ], color: Colors.black, borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage(image),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text("$cryptoCurrency"),
              ],
            ),
            Text(
              '$value  $selectedCurrency',
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
