import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
class WorldTime{

  String location;  //location name for UI
  String time; //time in that location
  String flag; //url to an asset flag icon
  String url;  // api end point location url
  int isDaytime; //numbers representing day and night
  WorldTime({this.location,this.flag,this.url});

  Future<void> getTime() async{
    try{
      Response response = await get('https://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
//    print(data);

      String dateTime = data['datetime'];
      String offset = data['utc_offset'];
      print('$dateTime - $offset');
      // Creating datetime object
      DateTime now = DateTime.parse(dateTime);
//    print(now);
      if (offset.substring(0,1) == '-'){
        now = now.subtract(Duration(hours: int.parse(offset.substring(1,3)) , minutes: int.parse(offset.substring(4,6))));
      }
      else {
        now = now.add(Duration(hours: int.parse(offset.substring(1, 3)),
            minutes: int.parse(offset.substring(4, 6))));
      }
      print(now);
      //set isdate

      if (now.hour>=4 && now.hour<9){
        isDaytime=0;
      }
      else if(now.hour>=9 && now.hour<=16){
        isDaytime=1;
      }
      else if(now.hour>16 && now.hour<19){
        isDaytime=2;
      }
      else{
        isDaytime=3;
      }

      //set time property
      time = DateFormat.jm().format(now);
    }
    catch(e){
      time='Cannot Load Time';
    }
  }





}


