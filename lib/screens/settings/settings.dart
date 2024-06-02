
import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../onboarding/views/policy_modal.dart';
import 'bottom_sheet_contact.dart';

class SettingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SettingState();
  }
}

class _SettingState extends State<SettingScreen> {



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        centerTitle: true,  // This will center the title
        title: Text(
          "Settings",
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.w700
          ),
        ),
      ),

      body: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height * 0.9,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[



            getHeader(  "Discalmer", Icons.read_more, (){
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => RulesModalDialog(
                  showBtn: false,
                  filname: "assets/pdf/disclamer.pdf",
                ),
              );
            }, false),
            getHeader(  "Privacy Policy", Icons.policy, (){
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => RulesModalDialog(showBtn: false, filname: "assets/pdf/privacy.pdf",
                ),
              );
            }, false)

          ],
        ),
      ),
    );
  }

  Widget getHeader(
      String title, IconData icon, Function onClick, bool isDropDawn) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.08,
      width: MediaQuery.of(context).size.width * 0.9,
      margin: EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
          color: Colors.lightBlue,
          borderRadius: BorderRadius.all(
              Radius.circular(10))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
            child: ClipOval(
              child: Icon(
                icon,
                color: Colors.lightBlue,
                size: 30,
              ),
            ),
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Text(
                title,
                style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black),
              )),
          InkWell(
            onTap: () {
              onClick.call();

            },
            child:
            Transform.rotate(
              angle: 180 * math.pi / 180,
              child:
            Icon(
              Icons.expand_circle_down_outlined,
              color: Colors.white,
            ),
          ))


        ],
      ),
    );
  }

  //AppLocalizations.load(Locale('ar'));


}
