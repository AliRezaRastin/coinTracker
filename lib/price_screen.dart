import 'package:coin_tracker/models/coin_model.dart';
import 'package:coin_tracker/utilities/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
   var txt=TextEditingController();
  
  List<CoinModel> coinsList = [
  ];

  getCoinValue() async {
    try {
      CoinData coinData = CoinData();

      var data = await coinData.getCoinData(selectedCurrency);

      if (data != null) {
        setState(() {
          coinsList = data;
        });
      }
    } catch (e) {
      print(e);
    }
  }
  CupertinoPicker getCupertinoPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }
    return CupertinoPicker(
      itemExtent: 32,
      onSelectedItemChanged: (selectedIndex) {
        getCoinValue();
        },
      children: pickerItems,
    );
  }

  InputDecorator getDropdownButton() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }



    return InputDecorator(
      decoration: const InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white24),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          isExpanded: true,
          value: selectedCurrency,
          items: dropdownItems,
          onChanged: (value) {
            setState(() {
              getCoinValue();
              selectedCurrency = value!;
             });
          },
        ),
      ),
    );
  }


  @override
  void initState() {
    getCoinValue();
  }

  @override
  Widget build(BuildContext context) {
    bool checkIsWeb() {
      try {
        if (Platform.isAndroid ||
            Platform.isIOS ||
            Platform.isFuchsia ||
            Platform.isLinux ||
            Platform.isMacOS||Platform.isWindows) {
          return false;
        } else {
          return true;
        }
      } catch (e) {
        print(e);
        return true;
      }}
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('images/coin.png', width: 100),
                    const SizedBox(height: 16),
                    const Text(
                      'Coin Tracker',
                      style: TextStyle(fontSize: 28),
                    ),
            Expanded(
              flex: 6,
              child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'images/${coinsList[index].icon.toLowerCase()}.png',
                          width: 60,
                        ),
                        const SizedBox(width: 12),
                        Column(
                          children: [
                            const Text('1', style: TextStyle(fontSize: 18)),
                            Text(
                              coinsList[index].name,
                              style: const TextStyle(color: Colors.white24),
                            ),
                          ],
                        )
                      ],
                    ),
                    trailing: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          NumberFormat("#,###.0")
                              .format(coinsList[index].price),
                          style: const TextStyle(fontSize: 18),
                        ),
                        Text(
                          selectedCurrency,
                          style: const TextStyle(color: Colors.white24),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                itemCount: coinsList.length,
              ),
            ),
            Container(
              padding:
              EdgeInsets.symmetric(horizontal: checkIsWeb() ?16: (Platform.isIOS ? 0: 16),),
              height: checkIsWeb() ?150: (Platform.isIOS ? 60: 150),
              child:
              checkIsWeb() ?getDropdownButton(): (Platform.isIOS ? getCupertinoPicker() : getDropdownButton()),
            ),
          ],
        ),
      ),
      ],),
    ),
    );
  }
}
