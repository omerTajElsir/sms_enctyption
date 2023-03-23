import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sms_maintained/sms.dart';

class Chat extends StatefulWidget {
  SmsThread thread;
  Chat(
      {
        this.thread
      }
      );
  _Chat createState() => _Chat();
}

class _Chat extends State<Chat> {
  SmsThread thread;

  static List<String> messege1 ;
  static List<String> messege2 ;
  static List<String> messege3 ;
  static List<String> messege4 ;
  static List<String> messege5 ;

  void sendSMS(String body,String phone) {
    SmsSender sender = new SmsSender();
    String address = phone;
    sender.sendSms(new SmsMessage(address, body));
  }



  var _messageController = TextEditingController();
  ScrollController _scrollController = new ScrollController();

  List messages = new List();

  @override
  void initState() {
    thread=widget.thread;
    // TODO: implement initState
    messege1 = ["1","Izz irons","Once you’ve completed your enrollment in the Apple Developer Program, you can sign in to App Store Connect with the Apple ID you used to enroll. ","2 days ago"];
    messege2 = ["0","Me","Modify the _handleSubmitted() method in your ChatScreenState class as follows. In this method, instantiate an AnimationController object and specify the animation's runtime duration to be 700 milliseconds. ","2 days ago"];
    messege3 = ["0","Me","no new alerts ?","5 hours ago"];
    messege4 = ["1","Izz irons","Attach the animation controller to a new ChatMessage instance, and specify that the animation should play forward whenever a new message is added to the chat list","5 hours ago"];
    messege5 = ["1","Izz irons","It's good practice to dispose of your animation controllers to free up your resources when they are no longer needed.","4 hours ago"];

    messages.add(messege1);
    messages.add(messege2);
    messages.add(messege3);
    messages.add(messege4);
    messages.add(messege5);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xFF1f617e)),
        centerTitle: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              maxRadius: 20,
              backgroundColor: Colors.blueGrey,
              child: Text(
                thread.contact.fullName!=null?thread.contact.fullName.substring(0,1):thread.contact.address.substring(0,1),
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(width: 15,),
            Text(thread.contact.fullName!=null?thread.contact.fullName:thread.contact.address
                ,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 24),),
          ],
        ),

        elevation: 2,
      ),

      body: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              //shrinkWrap: true,
              children: <Widget>[

                Expanded(
                  child: Container(
                    height: 800,
                    child: ListView.builder(
                      reverse: true,
                      controller: _scrollController,
                      itemCount: thread.messages.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index ){
                        CrossAxisAlignment align;
                        Color back, text ;
                        if(thread.messages[index].kind.index == 0){
                          align = CrossAxisAlignment.end;
                          back = Color(0xFF1f617e);
                          text = Colors.white;
                        }else{
                          align = CrossAxisAlignment.start;
                          back = Color(0xFFEEEEEE);
                          text = Colors.black;
                        }


                        return new Container(
                          padding: thread.messages[index].kind.index == 0?EdgeInsets.only(left: 50,right: 20,top: 10,bottom: 10):EdgeInsets.only(left: 20,right: 50,top: 10,bottom: 10),
                          child: Column(
                            crossAxisAlignment: align,
                            children: <Widget>[
                              SizedBox(height: 5,),
                              Material(
                                  color: back,
                                  animationDuration: Duration(milliseconds: 500),
                                  elevation: 0,
                                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                  child:Container(
                                    padding: EdgeInsets.all(20),
                                    child: Text(
                                      thread.messages[index].body,
                                      style: TextStyle(color: text),
                                    ),
                                  )
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10,right: 10),
                                child: Text(thread.messages[index].dateSent.toString(),style: TextStyle(fontSize: 12,color: Colors.grey)),
                              ),
                            ],
                          ),
                        );
                      },

                    ),
                  ),
                ),

                Container(
                  height: 10,
                  color: Colors.transparent,
                ),

                //=========================================================================
              ],
            ),
          ),

          Container(
            height: 1,
            color: Colors.grey,
          ),

          Container(
            height: 50,
            color: Colors.amber.shade50,
            child: TextField(
              controller: _messageController,
              keyboardType: TextInputType.text,
              enabled: true,
              cursorColor: Color(0xFF1f617e),
              decoration: InputDecoration(

                filled: true,
                isDense: true,

                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black12,
                    width: 0,
                  ),
                ),
                //hasFloatingPlaceholder: true,
                hintText: "Enter your message",
                suffixIcon:IconButton(icon: Icon(Icons.send,color: Color(0xFF1f617e),),
                    onPressed: (){
                      sendSMS(_messageController.text,thread.contact.address);
                      setState(() {
                        final SmsMessage _newMessage = new SmsMessage(thread.contact.address, _messageController.text, kind:  SmsMessageKind.Sent,date: DateTime.now());
                        thread.messages..insert(0,_newMessage);
                        _messageController.clear();
                        _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
                      });
                    }),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black12,
                    width: 0,
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }

}