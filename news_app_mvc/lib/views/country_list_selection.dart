import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum CountryList {EN, US, FR}

class CountryListSelection extends StatefulWidget {
  final country;

  CountryListSelection({Key key, this.country}) : super(key: key);

  @override
  _CountryListSelectionState createState() => _CountryListSelectionState();
}

class _CountryListSelectionState extends State<CountryListSelection> {

  CountryList _countryList = CountryList.EN;

  @override
  void initState() {
    super.initState();
    _prevCountrySelected();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).accentColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Select your country", style: TextStyle(fontSize: 25, color: Theme.of(context).accentColor)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RadioListTile(
            title: const Text("United Kingdom"),
            value: CountryList.EN,
            groupValue: _countryList,
            onChanged: (CountryList value) {setState(() {_countryList = value;});}
          ),
          RadioListTile(
              title: const Text("United States of America"),
              value: CountryList.US,
              groupValue: _countryList,
              onChanged: (CountryList value) {setState(() {_countryList = value;});}
          ),
          RadioListTile(
              title: const Text("France"),
              value: CountryList.FR,
              groupValue: _countryList,
              onChanged: (CountryList value) {setState(() {_countryList = value;});}
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FlatButton(onPressed: () {Navigator.pop(context);}, child: const Text("Cancel")),
              FlatButton(onPressed: () {Navigator.pop(context, _countryList.toString().split('.').last);}, child: const Text("Submit")),
            ],
          )
        ],
      ),
    );
  }

  _prevCountrySelected() {
    switch (widget.country) {

      case "EN":
        _countryList = CountryList.EN;
        break;
      case "US":
        _countryList = CountryList.US;
        break;
      case "FR":
        _countryList = CountryList.FR;
        break;
    }
    setState(() {});
  }
}