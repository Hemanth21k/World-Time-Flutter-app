import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};
  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    print(data);


    String bgImage;
    Color bgColor;
    Color txt;
    if (data['isDay'] == 0){
      bgImage='sunrise.png';
      bgColor=Colors.amber;
      txt=Colors.grey[900];
    }
    else if (data['isDay'] == 1){
      bgImage='Day.png';
      bgColor=Colors.green[600];
      txt=Colors.grey[900];
    }
    else if (data['isDay'] == 2){
      bgImage='sunset.png';
      bgColor=Colors.black54;
      txt=Colors.grey[200];
    }
    else{
      bgImage='night.png';
      bgColor=Colors.teal[900];
      txt=Colors.grey[200];
    }

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child:Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image:AssetImage('assets/$bgImage'),
              fit: BoxFit.cover,

            )
          ) ,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 60.0, 0.0, 0.0),
            child: Column(
              children: <Widget>[
                FlatButton.icon(onPressed: () async{
                  dynamic result = await Navigator.pushNamed(context, '/location');
                  setState(() {
                    data= {
                      'time': result['time'],
                      'location': result['location'],
                      'isDay': result['isDay'],
                      'flag': result['flag'],
                    };
                  });
                }, icon: Icon(
                    Icons.edit_location,
                    color: txt,
                ), label: Text(
                    'Edit Location',
                    style: TextStyle(
                      color: txt,
                    ),

                )),
                SizedBox(height: 80.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      data['location'],
                      style: TextStyle(
                        fontSize: 25.0,
                        letterSpacing:2.0,
                        color:txt,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 220.0,),
                Text(
                  data['time'],
                  style: TextStyle(
                    fontSize:64.0,
                    color: txt,
                  ),
                ),
              ],

            ),
          ),
        ),


      ),

    );
  }
}
