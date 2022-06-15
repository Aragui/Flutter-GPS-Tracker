import 'package:firebase_database/firebase_database.dart';
import 'package:location/location.dart';

class UserLocation{

  final _db = FirebaseDatabase.instance;

  Future<bool> setLocation(LocationData data)async{
    try{
      final ref = _db.ref('users/12345');
      await ref.set({
        "location": {
          "lat": data.latitude,
          "lng": data.longitude
        },
        "name": "Guillermo Aragón"
      });

      return true;
    }catch(e){
      print(e);
      return false;
    }
  }

}