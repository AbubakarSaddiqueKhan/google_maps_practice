import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
// Use two packages
// http and uuid

// flutter pub add uuid

extension HttpRequestCodes on http.Response {
  bool isSuccessful() => this.statusCode == 200;
  bool isNotFound() => this.statusCode == 404;
  bool isCreated() => this.statusCode == 401;
}

class AutoCompleteGooglePlacesApiDesign extends StatefulWidget {
  const AutoCompleteGooglePlacesApiDesign({super.key});

  @override
  State<AutoCompleteGooglePlacesApiDesign> createState() =>
      _AutoCompleteGooglePlacesApiDesignState();
}

late TextEditingController _textEditingController;

class _AutoCompleteGooglePlacesApiDesignState
    extends State<AutoCompleteGooglePlacesApiDesign> {
  var uuid = Uuid();
  String _sessionToken = "12345";
  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _textEditingController.addListener(() {});
    onTextChange();
  }

  void onTextChange() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }

    getSuggestionFromServer(_textEditingController.text);
  }

  List _placesList = [];

  void getSuggestionFromServer(String input) async {
    String _googlePlacesApiKey = "AIzaSyCGOpBcp63ty5rIzrvinHZ5mtgfNaSawdc";
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$_googlePlacesApiKey&sessiontoken=$_sessionToken';

    var response = await http.get(Uri.parse(request));

    print(response.body.toString());
    if (response.isSuccessful()) {
      setState(() {
        _placesList = jsonDecode(response.body.toString())["predictions"];
      });
    } else {
      throw Exception("Error ! failed to load data");
    }
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Search Places API"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              child: TextFormField(
                controller: _textEditingController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "Search Places"),
              ),
            ),
            Expanded(
                child: ListView.builder(
              itemCount: _placesList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_placesList[index]["description"]),
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
