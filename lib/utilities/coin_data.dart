import 'dart:convert';
import 'package:coin_tracker/constants.dart';
import 'package:coin_tracker/models/coin_model.dart';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR',
];

const List<String> cryptoList = [
  'BTC/Bitcoin',
  'ETH/Ethereum',
  'LTC/Litecoin',
  'TRX/Tron',
  'BNB/BNBbnb',
  'XRP/Repple',
  'SOL/Solana',
  'ADA/Cardano',
  'AVAX/Avalanche',
  'DOGE/DogeCoin',
  'DOT/Polkadot',
  'LINK/Chainlink',
  'MATIC/Polygon',
  'DAI/Dai',
  'TON/Toncoin',
  'WEOS/WrappedEOS',
  'ATOM/Cosmos',
  'UNI/Uniswap',
  'STETH/LidoStakedETH',
  'ICP/Internet Computer',
  'OP/Optimism',
  'XMR/Monero',
  'XLM/Stellar ',
  'TUSD/TrueUSD',
  'OKB/OKB',
  'FIL/Filecoin',
  'NEAR/NEAR Protocol',
  'KAS/Kaspa ',

];

class CoinData {
  Future getCoinData(String currency) async {
    List<CoinModel> cryptoPrice = [];

    for (String crypto in cryptoList) {
      http.Response response =
      await http.get(Uri.parse(
          '$kBaseURL/${crypto.split('/')[0]}/$currency?apikey=$kAPIKey'));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(data);
        CoinModel coinModel = CoinModel(
            icon: crypto.split('/')[0].toLowerCase(),
            name: crypto.split('/')[1],
            price: data['rate']);
        cryptoPrice.add(coinModel);
      } else {
        print(response.statusCode);
      }
    }

    return cryptoPrice;
  }
}