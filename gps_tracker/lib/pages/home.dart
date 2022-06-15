import 'package:flutter/material.dart';
import 'package:gps_tracker/bloc/location_bloc.dart';
import 'package:location/location.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final location = LocationBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    location.initLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GPS Tracker"),
      ),
      body: StreamBuilder(
        stream: location.locationStream,
        builder: (BuildContext context, AsyncSnapshot<LocationData> snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("${data.latitude} - ${data.longitude}"),],
            );
          }
          return Container();
        },
      ),
    );
  }
}
