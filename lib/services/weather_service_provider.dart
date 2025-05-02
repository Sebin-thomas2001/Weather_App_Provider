import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather_app_provider/models/weatherModel.dart';
import 'package:weather_app_provider/secrets/api.dart';
import 'package:http/http.dart' as http;

class WeatherServiceProvider extends ChangeNotifier {
  Weathermodel? _weather;
  Weathermodel? get weather =>
      _weather; // private ayittulla weatherinte purathuninu access cheyan anu get upayogikunath

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String _error = "";
  String get error => _error;

  Future<void> fetchEwatherDataByCity(String city) async {
    _isLoading = true;
    _error = "";

    try {
      final String apiUrl =
          "${APIEndPoints().cityUrl}${city}&appid=${APIEndPoints().apiKey}${APIEndPoints().units}";

      print(apiUrl);

      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);

        _weather =
            Weathermodel.fromJson(data); // to convert json to dart object
        notifyListeners();
      } else {
        _error = "Faild to load darta";
      }
    } catch (e) {
      _error = "Error Occured";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
