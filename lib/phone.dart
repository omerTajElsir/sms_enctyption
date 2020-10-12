
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sms/verify.dart';




class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _items = "";
  String _cats = "";
  int check = 0;
  String _user;
  int postStatus;

  ProgressDialog _pr;
  @override
  void initState() {
    _pr =   ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);
    _pr.style(
        message: 'Logging you in ...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600)
    );
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  static final TextEditingController _pass = new TextEditingController();
  static final TextEditingController _phone = new TextEditingController();
  final _loginForm = GlobalKey<FormState>();



  /*Future _getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _user = prefs.getString("token");
  }
  Future<String> submitForm(String phone) async {
    final response = await http.post(
      "$_baseUrl/login",
      headers: {
        "Accept": "application/json"
      },
      body: {
        'phone':phone,
      },
    );
    if (response.body.toString().contains("phone")) {
      setState(() {
        postStatus = response.statusCode;
      });
      return json.decode(response.body)["id"].toString();
    }
  }*/

  @override
  Widget build(BuildContext context) {

    /*_getUser().whenComplete((){
      if(_user != null){
        _onToSplash(_user);
      }
    });*/
    double screenWidth = MediaQuery.of(context).size.width;


    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[

          //Image.asset("images/background.jpg",fit: BoxFit.cover,),

          //Container(color: Colors.black87,),

          Container(

              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            //Color(0xFF1f617e),
                            Color(0xCC1f617e),
                            Color(0xFF1f617e),
                            Color(0xEE1f617e),
                          ],
                          begin: FractionalOffset.topRight,
                          end: FractionalOffset.bottomCenter,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 50.0,
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Image.asset('assets/logo.png'),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.0),
                          ),
                          Text(
                            "SMS Encryption",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Container(
                          padding: EdgeInsets.only(left: 20,right: 20,top: 50),
                          child: Form(
                              key: _loginForm,
                              child: new SingleChildScrollView(
                                  child: new ConstrainedBox(
                                      constraints: new BoxConstraints(),
                                      child: new Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          new TextFormField(
                                            controller: _phone,
                                            keyboardType: TextInputType.number,
                                            textAlign: TextAlign.left,
                                            autofocus: false,
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                            decoration: InputDecoration(
                                              hintText: 'Phone',
                                              filled: true,
                                              fillColor: Color(0x88FFFFFF),
                                              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                              border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(50.0)),
                                            ),
                                            validator: (value) {

                                              if (value.length <= 9) {
                                                return 'please fill this field';
                                              }

                                            },
                                          ),

                                          SizedBox(height: 20.0),



                                          Padding(
                                            padding: EdgeInsets.only(top: 30),
                                            child: Material(
                                              color: Color(0xFF1f617e),
                                              borderRadius: BorderRadius.circular(30.0),
                                              shadowColor: Color(0xFF1f617e),
                                              elevation: 5.0,
                                              child: MaterialButton(
                                                //minWidth: 200.0,
                                                height: 50.0,
                                                minWidth: screenWidth,
                                                onPressed: () {
                                                  /*_pr.show();
                                                  login().then((response){
                                                    if(jsonDecode(response).toString().contains("token")){
                                                      _pr.hide();
                                                      //_saveUser(response);
                                                      //_onToSplash();
                                                    }else{
                                                      _pr.hide();
                                                      //Dialogs d = new Dialogs(context);
                                                      //d.wrong("Wrong number or password, Please edit and try again."
                                                      //);
                                                    }
                                                  });*/

                                                  Navigator.of(context).push(
                                                    new MaterialPageRoute(
                                                      builder: (BuildContext context)=>new VerifyScreen(),
                                                    ),
                                                  );

                                                },

                                                child: Text('Send', style: TextStyle(color: Colors.white)),
                                              ),
                                            ),
                                          ),


                                        ],
                                      )
                                  )
                              )
                          )

                      )
                  )
                ],
              )
          ),

        ],
      ),
    );
  }






  Future<String> login() async {

    String url =
        'http://spare.enigma-it.com/api/mobile/auth/login';

    Map map = {
      "password":_pass.text,
      "phone":_phone.text
    };

    HttpClient httpClient;
    HttpClientRequest request;
    httpClient = new HttpClient();

    try{
      request = await httpClient.postUrl(Uri.parse(url)).timeout(Duration(seconds: 16));
      request.headers.set('Content-Type', 'application/json');
      request.add(utf8.encode(json.encode(map)));
      HttpClientResponse response = await request.close().timeout(Duration(seconds: 16));
      // todo - you should check the response.statusCode
      String reply = await response.transform(utf8.decoder).join().timeout(Duration(seconds: 16));
      httpClient.close();
      return reply;
    }on TimeoutException catch (_) {
      _pr.hide();
     // Dialogs d = new Dialogs(context);
     // d.wrong("Request Timeout. Please check your internet connection");
    } on SocketException catch (_) {
      _pr.hide();
      //Dialogs d = new Dialogs(context);
     //d.wrong("Connection error. Please check your internet connection");
    }
  }
}