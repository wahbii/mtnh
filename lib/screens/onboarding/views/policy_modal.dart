import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../utils/views/Modal.dart';
import '../../home/homescreenn.dart';

class RulesModalDialog extends StatefulWidget {
  final bool showBtn;
  final String filname ;

  RulesModalDialog({required this.showBtn ,required this.filname});

  @override
  State<StatefulWidget> createState() {
    return _RulesModalDialogState();
  }
}

class _RulesModalDialogState extends State<RulesModalDialog> {
  @override
  void dispose() {
    super.dispose();
  }

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Modal(
        child: Padding(
      padding: EdgeInsets.all(20)
          .copyWith(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(height:MediaQuery.of(context).size.height * 0.8 -70 ,
            child: SfPdfViewer.asset(widget.filname),
            ),
            Visibility(
                visible: widget.showBtn,
                child: InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, HomeScreen.path);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 60,
                      child: Center(child: Text(
                        "Continue",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),),
                    )))
          ],
        ),
      ),
    ));
  }
}
