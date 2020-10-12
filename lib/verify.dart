import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'dart:async';




class VerifyScreen extends StatefulWidget {
  final String phone;
  final String name;
  final String pass;
  VerifyScreen({Key key, this.phone, this.pass,this.name}): super (key: key);
  @override
  _VerifyScreenStste createState() => _VerifyScreenStste();
}

class _VerifyScreenStste extends State<VerifyScreen> {
  //String _baseUrl= Constants.baseUrl;
  String _items = "";
  String _cats = "";
  String _phone,_pass,_name;
  int check = 0;
  int postStatus = 0,checkStatus = 0;

  /*Future _saveUser(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }*/

  ProgressDialog _pr;
  @override
  void initState() {
    _pr =   ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);
    _pr.style(
        message: 'Signing you up...',
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
    _phone = widget.phone;
    _name = widget.name;
    _pass = widget.pass;
  }

  /*Future<String> submitForm(String phone) async {
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
      return "done";
    }
  }
  Future<String> checkOTP(String otp) async {
    final response = await http.post(
      "$_baseUrl/check-otp",
      headers: {
        "Accept": "application/json"
      },
      body: {
        'id':_id,
        'otp':otp,
      },
    );
    if (response.body.toString().contains("200")) {
      setState(() {
        checkStatus = 200;
      });
      return json.decode(response.body)["token"].toString();
    }
  }*/

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  static final TextEditingController _a = new TextEditingController();
  static final TextEditingController _b = new TextEditingController();
  static final TextEditingController _c = new TextEditingController();
  static final TextEditingController _d = new TextEditingController();
  static final TextEditingController _cy = new TextEditingController();

  FocusNode _af = new FocusNode();
  FocusNode _bf = new FocusNode();
  FocusNode _cf = new FocusNode();
  FocusNode _df = new FocusNode();
  final _loginForm = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    String _phonesub = "0991400444".substring(0,4);

    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[

          Container(

              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Container(
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
                                color: Color(0xFF1f617e),
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Center(
                      child: Text("Enter the 6 digit number which has been sent to the phone number $_phonesub xxxxxx ."),
                    ),
                  ),

                  Expanded(
                    flex: 1,
                      child: new Container(
                        padding: EdgeInsets.only(left: 25,right: 25),
                        child: TextField(
                          controller: _cy,
                          keyboardType: TextInputType.text,
                          textAlign: TextAlign.start,
                          autofocus: false,
                          style: TextStyle(fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            hintText: "Enter the cypher text",
                            filled: true,
                            fillColor: Color(0x88FFFFFF),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                          onChanged: (value){

                          },

                        ),
                      )
                  ),

                  Expanded(
                      flex: 4,
                      child: Container(
                          padding: EdgeInsets.only(left: 20,right: 20),
                          child: Form(
                              key: _loginForm,
                              child: new SingleChildScrollView(
                                  child: new ConstrainedBox(
                                      constraints: new BoxConstraints(),
                                      child: new Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[

                                          SizedBox(height: 30,),
                                          Row(
                                            children: <Widget>[
                                              SizedBox(width: 30,),
                                              Expanded(
                                                  child: new Container(
                                                    padding: EdgeInsets.only(left: 5,right: 5),
                                                    child: TextField(
                                                      controller: _a,
                                                      maxLength: 1,
                                                      focusNode: _af,
                                                      keyboardType: TextInputType.number,
                                                      textAlign: TextAlign.center,
                                                      autofocus: false,
                                                      style: TextStyle(fontWeight: FontWeight.bold),
                                                      decoration: InputDecoration(
                                                        filled: true,
                                                        fillColor: Color(0x88FFFFFF),
                                                        border: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(10.0)),
                                                      ),
                                                      onChanged: (value){
                                                        if(value.length>=1){
                                                          setState(() {
                                                            _a.text = value;
                                                          });
                                                          FocusScope.of(context).requestFocus(_bf);
                                                        }
                                                      },

                                                    ),
                                                  )
                                              ),
                                              Expanded(
                                                  child: new Container(
                                                    padding: EdgeInsets.only(left: 5,right: 5),
                                                    child: TextField(
                                                      controller: _b,
                                                      maxLength: 1,
                                                      focusNode: _bf,
                                                      keyboardType: TextInputType.number,
                                                      textAlign: TextAlign.center,
                                                      autofocus: false,
                                                      style: TextStyle(fontWeight: FontWeight.bold),
                                                      decoration: InputDecoration(
                                                        filled: true,
                                                        fillColor: Color(0x88FFFFFF),
                                                        border: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(10.0)),
                                                      ),
                                                      onChanged: (value){
                                                        setState(() {
                                                          _b.text = value;
                                                        });
                                                        if(value.length>=1){
                                                          FocusScope.of(context).requestFocus(_cf);
                                                        }
                                                      },

                                                    ),
                                                  )
                                              ),
                                              Expanded(
                                                  child: new Container(
                                                    padding: EdgeInsets.only(left: 5,right: 5),
                                                    child: TextField(
                                                      controller: _c,
                                                      maxLength: 1,
                                                      focusNode: _cf,
                                                      keyboardType: TextInputType.number,
                                                      textAlign: TextAlign.center,
                                                      autofocus: false,
                                                      style: TextStyle(fontWeight: FontWeight.bold),
                                                      decoration: InputDecoration(
                                                        filled: true,
                                                        fillColor: Color(0x88FFFFFF),

                                                        border: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(10.0)),
                                                      ),
                                                      onChanged: (value){
                                                        if(value.length>=1){
                                                          setState(() {
                                                            _c.text = value;
                                                          });
                                                          FocusScope.of(context).requestFocus(_df);
                                                        }
                                                      },
                                                    ),
                                                  )
                                              ),
                                              Expanded(
                                                  child: new Container(
                                                    padding: EdgeInsets.only(left: 5,right: 5),
                                                    child: TextField(
                                                      controller: _d,
                                                      maxLength: 1,
                                                      focusNode: _df,
                                                      keyboardType: TextInputType.number,
                                                      textAlign: TextAlign.center,
                                                      autofocus: false,
                                                      style: TextStyle(fontWeight: FontWeight.bold),
                                                      decoration: InputDecoration(
                                                        filled: true,
                                                        fillColor: Color(0x88FFFFFF),

                                                        border: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(10.0)),
                                                      ),
                                                      onChanged: (value){
                                                        if(value.length>=1){
                                                          setState(() {
                                                            _d.text = value;
                                                          });
                                                        }
                                                      },
                                                    ),
                                                  )
                                              ),

                                              SizedBox(width: 30,),


                                            ],
                                          ),

                                          SizedBox(height: 20.0),

                                          Padding(
                                            padding: EdgeInsets.only(bottom: 10,top: 40),
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
                                                  _pr.show();
                                                  checkOTP().then((response){
                                                    if(jsonDecode(response).toString().contains("token")){
                                                      _pr.hide();
                                                      //_onToDone();
                                                    }else{
                                                      _pr.hide();
                                                      String message = jsonDecode(response)["error"].toString();
                                                      // Dialogs d = new Dialogs(context);
                                                      // d.wrong("This otp is not right, Please enter the correct otp.");

                                                    }
                                                  });

                                                },

                                                child: Text('Verify', style: TextStyle(color: Colors.white)),
                                              ),
                                            ),
                                          ),

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              FlatButton(
                                                child: Text ("Cancel", style: TextStyle(color: Colors.red),),
                                                onPressed: (){
                                                  //_onToLog();
                                                },
                                              ),

                                              FlatButton(
                                                child: Text ("Resend", style: TextStyle(color: Colors.cyan),),
                                                onPressed: (){
                                                  _scaffoldKey.currentState.showSnackBar(
                                                    new SnackBar(duration: new Duration(seconds: 80), content:
                                                    new Row(
                                                      children: <Widget>[
                                                        new CircularProgressIndicator(),
                                                        new Text("Resending verfication sms...")
                                                      ],
                                                    ),
                                                    ),
                                                  );

                                                  sendOTP().then((response){
                                                    if(jsonDecode(response)["message"].toString().contains("successfully")){
                                                      _scaffoldKey.currentState.showSnackBar(
                                                        new SnackBar(duration: new Duration(seconds: 3), content:
                                                        new Row(
                                                          children: <Widget>[
                                                            new Icon(Icons.done_all,color: Colors.green,),
                                                            SizedBox(width: 10,),
                                                            new Text("SMS code sent successfully")
                                                          ],
                                                        ),
                                                        ),
                                                      );
                                                    }else{
                                                      _scaffoldKey.currentState.showSnackBar(
                                                        new SnackBar(duration: new Duration(seconds: 3), content:
                                                        new Row(
                                                          children: <Widget>[
                                                            new Icon(Icons.error,color: Colors.red,),
                                                            SizedBox(width: 10,),
                                                            new Text("Something went wrong, please try again")
                                                          ],
                                                        ),
                                                        ),
                                                      );
                                                    }
                                                  });
                                                  /*submitForm(_phone).then((_usr) {
                                                    _scaffoldKey.currentState.hideCurrentSnackBar();
                                                    if (postStatus == 200) {
                                                      _onToLog();
                                                      _scaffoldKey.currentState.hideCurrentSnackBar();
                                                    } else {
                                                      _scaffoldKey.currentState.hideCurrentSnackBar();
                                                      _wrongPost("Something's not right");
                                                    }
                                                  });*/


                                                },
                                              ),
                                            ],
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

  // _onToLog() {
  //   Navigator.pushReplacement(context,
  //       new MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
  // }
  //
  // _onToDone() {
  //   Navigator.pushReplacement(context,
  //       new MaterialPageRoute(builder: (BuildContext context) => SplashScreen()));
  // }

  Future<String> checkOTP() async {
    String otp = _a.text + _b.text +_c.text +_d.text ;

    String url =
        'http://spare.enigma-it.com/api/mobile/auth/otp/verfiy';

    Map map = {
      "otp":otp,
      "password":_pass,
      "phone":_phone
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
      //Dialogs d = new Dialogs(context);
      //d.wrong("Request Timeout. Please check your internet connection");
    } on SocketException catch (_) {
      _pr.hide();
      //Dialogs d = new Dialogs(context);
      //d.wrong("Connection error. Please check your internet connection");
    }
  }

  Future<String> sendOTP() async {
    String url =
        'http://spare.enigma-it.com/api/mobile/auth/otp/send';

    Map map = {
      "name":_name,
      "password":_pass,
      "phone":_phone
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
      //Dialogs d = new Dialogs(context);
      //d.wrong("Request Timeout. Please check your internet connection");
    } on SocketException catch (_) {
      _pr.hide();
      //Dialogs d = new Dialogs(context);
      //d.wrong("Connection error. Please check your internet connection");
    }
  }
}