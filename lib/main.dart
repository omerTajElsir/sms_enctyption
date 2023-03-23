import 'package:flutter/material.dart';
import 'package:sms/phone.dart';
import 'package:sms/verify.dart';
import 'package:sms_maintained/sms.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'chat.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }
  SmsQuery query;
  List<SmsThread> threads;
  Future<String> sendSMS()async{
     query = new SmsQuery();
     threads = await query.getAllThreads;
    return threads.toString();
  }
  Future res;


  @override
  void initState() {
    res = sendSMS();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        title: Text('Messages',style: TextStyle(color: Color(0xFF1f617e),fontWeight: FontWeight.bold),),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xFF1f617e)),
      ),
      body:  FutureBuilder(
          future: res,
          builder: (context, snapshot) {
            print(snapshot);
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text("Something went wrong");
              case ConnectionState.waiting:
                return Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 50),
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(
                    ),
                  ),
                );
              case ConnectionState.done:
                return  ListView.builder(
                    itemCount: threads.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index ){
                      return GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(
                            new MaterialPageRoute(
                              builder: (BuildContext context)=>new Chat(thread: threads[index],),
                            ),
                          );
                        },
                        child : Column(
                          children: [
                            Container(
                                padding: EdgeInsets.only(top: 15,bottom: 15,left: 20,right: 20),
                                //color: Colors.lightBlue.shade50,
                                child: Row(
                                  children: <Widget>[

                                    CircleAvatar(
                                      maxRadius: 30,
                                      backgroundColor: Colors.blueGrey,
                                      child: Text(
                                        threads[index].contact.fullName!=null?threads[index].contact.fullName.substring(0,1):threads[index].contact.address.substring(0,1),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),

                                    SizedBox(width: 15,),

                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            children: [
                                              Expanded(child: Text(threads[index].contact.fullName!=null?threads[index].contact.fullName:threads[index].contact.address,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)),
                                              Text(timeago.format(threads[index].messages.first.dateSent, locale: 'en_short'),style: TextStyle(fontSize: 14,color: Colors.black54),),
                                            ],
                                          ),
                                          SizedBox(height: 10,),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(threads[index].messages.first.body.toString(),overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 14,color: Colors.black54),),

                                              ),

                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                  ],
                                )
                            ),
                            Container(
                              height: .5,
                              color: Colors.grey.shade300,
                              margin: EdgeInsets.only(left: 30,right: 30),
                            )
                          ],
                        ),
                      );
                    }
                );
              default:
                return null;
            }
          }
      ),


    );
  }
}
