import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';
import '../helpers/ensure_visible.dart';
import 'package:http/http.dart' as http;

class LocationInput extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput> {
  Uri _staticMapUri;
  final FocusNode _addressInputFocusNode = FocusNode();
  final TextEditingController _addressInputController = TextEditingController();

  @override
  void initState() {
    _addressInputFocusNode.addListener(_updateLocation);

    super.initState();
  }

  void dispose() {
    _addressInputFocusNode.removeListener(_updateLocation);
    super.dispose();
  }

  void getStaticMap(String address) async {
    if (address.isEmpty) {
      return;
    }
    final Uri uri = Uri.https(
      'maps.googleapis.com', 
      '/maps/api/geocode/json',
        {'address': address, 'key': 'AIzaSyDBrIuz3TCkz0MsktI3yJ4wjyls2DQiERU'});

    final http.Response response = await http.get(uri);
    final decodedResponse = json.decode(response.body);
    final formattedAddress = decodedResponse['results'][0]['formatted_address'];
    final coords = decodedResponse['results'][0]['geometry']['location'];

    

    print(decodedResponse);

    final StaticMapProvider staticMapProvider =
        StaticMapProvider('AIzaSyDBrIuz3TCkz0MsktI3yJ4wjyls2DQiERU');
    final Uri staticMapUri = staticMapProvider.getStaticUriWithMarkers(
        [Marker('position', 'Position', coords['lat'],coords['lng'])],
        center: Location(coords['lat'],coords['lng']),
        width: 500,
        height: 300,
        maptype: StaticMapViewType.roadmap);
    setState(() {
      _addressInputController.text = formattedAddress;
      _staticMapUri = staticMapUri;
    });
  }

  void _updateLocation() {
    if (!_addressInputFocusNode.hasFocus) {
      getStaticMap(_addressInputController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        EnsureVisibleWhenFocused(
          focusNode: _addressInputFocusNode,
          child: TextFormField(
            focusNode: _addressInputFocusNode,
            controller: _addressInputController,
            decoration: InputDecoration(labelText: 'Address'),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Image.network(_staticMapUri.toString())
      ],
    );
  }
}
