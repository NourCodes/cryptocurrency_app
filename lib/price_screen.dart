import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'coin_data.dart';
import 'crypto_card.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  // Class properties and variables

  Map<String, String> prices =
      {}; //this map will get the data ex. {BTC: 4062917, ETH: 234776, LTC: 9308}
  String selectedCurrency = 'USD'; //by default it will be in USD
  bool isWaiting =
      false; //we will use it when we get the data.  true => ?   false=> 233333 (rate)

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currencyOptions) {
      var newItem = DropdownMenuItem(
        value: currency,
        child: Text(currency),
      );
      dropdownItems.add(newItem);
    }
    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        {
          setState(() {
            selectedCurrency = value!;
            getRate(selectedCurrency);
          });
        }
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currencyOptions) {
      var i = Text(currency);
      pickerItems.add(i);
    }
    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = currencyOptions[selectedIndex];
          getRate(selectedCurrency);
        });
      },
      children: pickerItems,
    );
  }



  //this methods decides whether to display the iOS picker or the Android dropdown based on the platform.
  Widget getPicker() {
    if (Platform.isIOS) {
      return iOSPicker();
    } else {
      return androidDropdown();
    }
  }


  void getRate(String selectedCurrency) async {
    try {
      isWaiting = true; // when it is true ? will be displayed
      prices = await Coin().getData(
          selectedCurrency); //the map we created prices will get the data which is of the same type
      //Upon successful data retrieval, it updates the state with the fetched data, and finally, it sets isWaiting back to false.
      isWaiting = false;
      setState(() {

      });
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState() {
    // Initialize and fetch data when the widget is created
    getRate(selectedCurrency);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text('Coin Rate'),
        actions: [
          IconButton(onPressed: () {
            setState(() {
              getRate(selectedCurrency);
            });
          }, icon: const Icon(Icons.refresh),)
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: CryptoCard(
                  image: "images/Bitcoin.jpg",
                    selectedCurrency: selectedCurrency,
                    value: isWaiting ? "?" : prices["BTC"].toString(),
                    cryptoCurrency: cryptoSelection.first),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: CryptoCard(
                  image: "images/eth.jpg",
                    selectedCurrency: selectedCurrency,
                    value: isWaiting ? "?" : prices["ETH"].toString(),
                    cryptoCurrency: cryptoSelection[1]),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: CryptoCard(
                  image: "images/LTC.jpg",
                    selectedCurrency: selectedCurrency,
                    value: isWaiting ? "?" : prices["LTC"].toString(),
                    cryptoCurrency: cryptoSelection.last),
              ),
            ],
          ),
          Container(
            color: Colors.black,
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}
