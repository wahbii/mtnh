import 'package:cast/device.dart';
import 'package:cast/discovery_service.dart';
import 'package:cast/session.dart';
import 'package:cast/session_manager.dart';
import 'package:flutter/material.dart';

class CastDeviceBottomSheet {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return FutureBuilder<List<CastDevice>>(
          future: CastDiscoveryService().search(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error.toString()}',
                ),
              );
            } else if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.data!.isEmpty) {
              return Center(
                child: Text(
                  'No Chromecast found',
                ),
              );
            }

            return ListView(
              children: snapshot.data!.map((device) {
                return ListTile(
                  title: Text(device.name),
                  onTap: () {
                    _connectToYourApp(context, device);
                  },
                );
              }).toList(),
            );
          },
        );
      },
    );
  }

  static Future<void> _connectToYourApp(BuildContext context, CastDevice device) async {
    // Implement your connection logic here
    Navigator.pop(context);
    final session = await CastSessionManager().startSession(device);

    session.stateStream.listen((state) {
      if (state == CastSessionState.connected) {
        session.sendMessage('urn:x-cast:namespace-of-the-app', {
          'type': 'sample',
        });
      }
    });

    session.messageStream.listen((message) {
      print('receive message: $message');
    });

    session.sendMessage(CastSession.kNamespaceReceiver, {
      'type': 'LAUNCH',
      'appId': 'com.main.mhtn', // set the appId of your app here
    });// Close the bottom sheet after selecting a device
  }

}
