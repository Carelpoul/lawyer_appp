import 'package:http/http.dart' as http;
import 'package:untitled10/network/endpoint.dart';

class RegistrationDataRepo {
  Future<http.Response> getCountryList() async {
    try {
      return await http.get(Uri.parse(Endpoint.getAllCountries));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<http.Response> getStateList() async {
    try {
      return await http.get(Uri.parse(Endpoint.getAllStateList));
    } catch (e) {
      throw Exception(e);
    }
  }

}