
import 'dart:convert';
import 'package:http/http.dart' as http;
class RequestAssistent{

  static Future<dynamic> getRequest(String url)async{

    http.Response response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){
      
      String jsonData = response.body;
      var decodeData = jsonDecode(jsonData);
      return decodeData;
    }
    else{
      return "Failed";
    }
  }
}

class AsistentMethod{
  static Future<String> searchCoordinateAddress(String lat ,String lng)async{
      String placeAddress = "";
      String url =  "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=AIzaSyCHlPJMsHXuk5Khs0FbOhGavgKy2BPV5m8";
      var response = await RequestAssistent.getRequest(url);

      if(response != "Failed"){
        placeAddress = response["results"][0]["formatted_address"];
      }
      return placeAddress;
  }
}
