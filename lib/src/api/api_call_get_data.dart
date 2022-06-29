// ignore_for_file: non_constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'api_server.dart';
import 'package:waste_collection/src/model/home_model.dart';
import 'package:waste_collection/src/model/upcoming_model.dart';
import 'package:waste_collection/src/model/collection_received_model.dart';
import 'package:waste_collection/src/model/history_transaction_model.dart';
import 'package:waste_collection/src/model/detail_collection_model.dart';

class ApiGetHomeData {
  Future<GetData> getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    final collectorData = await http.get(Uri.parse(API.API_URL + API.get),
        headers: {'Authorization': 'Bearer $token'});
    return GetDataFromJson(collectorData.body);
  }
}

class ApiGetUpcoming {
  Future<UpcomingCollection> getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    final upcoming = await http.get(
        Uri.parse(API.API_URL + API.upcomingCollection),
        headers: {'Authorization': 'Bearer $token'});
    return UpcomingCollectionFromJson(upcoming.body);
  }
}

class ApiGetCollectionReceived {
  Future<CollectionReceived> getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    final collectionReceived = await http.get(
        Uri.parse(API.API_URL + API.collectionReceived),
        headers: {'Authorization': 'Bearer $token'});
    return CollectionReceivedFromJson(collectionReceived.body);
  }
}

class ApiSearchCollectionReceived {
  Future<CollectionReceived> getData(search) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    final collectionReceived = await http.get(
        Uri.parse('${API.API_URL}${API.collectionReceived}?search=$search'),
        headers: {'Authorization': 'Bearer $token'});
    return CollectionReceivedFromJson(collectionReceived.body);
  }
}

class ApiFilterDateCollectionReceived {
  Future<CollectionReceived> getData(start_date, finish_date) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    final collectionReceived = await http.get(
        Uri.parse(
            '${API.API_URL}${API.collectionReceived}?start_date=$start_date&finish_date=$finish_date'),
        headers: {'Authorization': 'Bearer $token'});
    return CollectionReceivedFromJson(collectionReceived.body);
  }
}

class ApiGetHistoryTransaction {
  Future<HistoryTransaction> getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    final historyTransaction = await http.get(
        Uri.parse(API.API_URL + API.getHistoryTransaction),
        headers: {'Authorization': 'Bearer $token'});
    return HistoryTransactionFromJson(historyTransaction.body);
  }
}

class ApiSearchHistoryTransaction {
  Future<HistoryTransaction> getData(search) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    final historyTransaction = await http.get(
        Uri.parse('${API.API_URL}${API.getHistoryTransaction}?search=$search'),
        headers: {'Authorization': 'Bearer $token'});
    return HistoryTransactionFromJson(historyTransaction.body);
  }
}

class ApiFilterDateHistoryTransaction {
  Future<HistoryTransaction> getData(start_date, finish_date) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    final historyTransaction = await http.get(
        Uri.parse(
            '${API.API_URL}${API.getHistoryTransaction}?start_date=$start_date&finish_date=$finish_date'),
        headers: {'Authorization': 'Bearer $token'});
    return HistoryTransactionFromJson(historyTransaction.body);
  }
}

class ApiGetDetailCollection {
  Future<DetailCollection> getData(String orderCode) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    final historyTransaction = await http.get(
        Uri.parse(API.API_URL + API.getCollectorDetail + orderCode),
        headers: {'Authorization': 'Bearer $token'});
    return DetailCollectionFromJson(historyTransaction.body);
  }
}
