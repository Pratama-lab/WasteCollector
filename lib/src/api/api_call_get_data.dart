import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'api_server.dart';
import 'package:waste_collection/src/model/home_model.dart';
import 'package:waste_collection/src/model/profile_model.dart';

class ApiGetHomeData {
  Future<CollectorData> getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    final collectorData = await http.get(
      Uri.parse(API.API_URL+API.get),
      headers: { 'Authorization': 'Bearer $token' }
    );
    return CollectorDataFromJson(collectorData.body);
  }
}

class ApiGetProfileData {
  Future<ProfileData> getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    final collectorData = await http.get(
      Uri.parse(API.API_URL+API.get),
      headers: { 'Authorization': 'Bearer $token' }
    );
    return ProfileDataFromJson(collectorData.body);
  }
}