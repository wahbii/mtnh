import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

import '../../utils/views/Modal.dart';

class ContactModalDialog extends StatefulWidget {
  final Function() onSucess;

  ContactModalDialog({required this.onSucess});

  @override
  State<StatefulWidget> createState() {
    return _ContactModalDialogState();
  }
}

class _ContactModalDialogState extends State<ContactModalDialog> {
  final TextEditingController firstController = TextEditingController();
  final TextEditingController secondController = TextEditingController();
  final TextEditingController thirdController = TextEditingController();
  final TextEditingController fourthController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool showLoader = false;

  String messgError = "";

  @override
  void dispose() {
    firstController.dispose();
    secondController.dispose();
    thirdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Modal(
        child: Padding(
            padding: EdgeInsets.all(20).copyWith(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Stack(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Contact us",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      TextFormField(
                        controller: firstController,
                        decoration: InputDecoration(
                          labelText: "Full Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (value) {
                          if (value?.isEmpty == true) {
                            return "Empty name";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: fourthController,
                        decoration: InputDecoration(
                          labelText: "Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (value) {
                          if (value?.isEmpty == true) {
                            return "Empty email";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: secondController,
                        decoration: InputDecoration(
                          labelText: "Object",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (value) {
                          if (value?.length == 0) {
                            return "Empty object";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: thirdController,
                        decoration: InputDecoration(
                          labelText: "Message",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        validator: (value) {
                          if (value?.length == 0) {
                            return "Empty message";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 50,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  _formKey.currentState?.validate() == true
                                      ? Colors.lightBlueAccent
                                      : Colors.lightBlue),
                            ),
                            onPressed: () {
                              if (_formKey.currentState?.validate() == true) {
                                setState(() {
                                  showLoader = true;
                                });
                                contactsendEmail(
                                    fourthController.text,
                                    firstController.text,
                                    secondController.text,
                                    thirdController.text,
                                        () {
                                      Navigator.of(context).pop();
                                    });
                              }
                            },
                            child: Text(
                              "Send",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            )));
  }
}

void contactsendEmail(
    String email, String name, String object, String body, Function() onSucess) async {
  String username = 'noreply@mhtn.org'; // Your email address
  String password = 'xsnm hybm bljm vgcp'; // Your email password

  final smtpServer = gmail(username, password);
  final message = Message()
    ..from = Address(username, '')
    ..recipients.add("app.chaching@gmail.com") // Recipient's email address
    ..subject = object
    ..text = "sender: $email  name: $name\n$body";

  try {
    final sendReport = await send(message, smtpServer);
    onSucess.call();
    print('Message sent: ${sendReport}');
  } catch (e) {
    print('Error sending email: $e');
  }
}
