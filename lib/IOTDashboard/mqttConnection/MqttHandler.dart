// import 'dart:io';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:mqtt_client/mqtt_client.dart';
// import 'package:mqtt_client/mqtt_server_client.dart';
// import 'package:provider/provider.dart';

// import '../../utils/topicProvider.dart';

// class MqttHandler with ChangeNotifier {
//   final client = MqttServerClient('', '');
//   final ValueNotifier<String> data = ValueNotifier<String>('');

//   Future<String> MqttConnectionMain(
//       void Function(String topic, String message) updateCallback,
//       // BuildContext context,
//       String url,
//       String clientIdentifier,
//       int keepAlivePeriod,
//       int port,
//       int connectTimeoutPeriod,
//       String willtopic,
//       String WillMessage,
//       String userName,
//       String pass,
//       String userTopic,
//       bool cleanSession,
//       MqttQos willQoS,
//       String mqttVersion,
//       String encryption,
//       bool retained) async {
//     client.server = url;
//     client.logging(on: true);
//     client.clientIdentifier = clientIdentifier;
//     print("url $url willtopic $willtopic  clientIdentifier $clientIdentifier");

//     client.keepAlivePeriod = keepAlivePeriod;
//     client.port = port;

//     client.connectTimeoutPeriod = connectTimeoutPeriod; // milliseconds

//     client.onDisconnected = onDisconnected;

//     client.onConnected = onConnected;
//     client.onAutoReconnect = onAutoReconnect;
//     if (encryption.trim() == 'CA signed server certificate') {
//       final currDir = '../../../assets/certificate/mosquitto.org.crt';
//       final context = SecurityContext.defaultContext;
//       // Note if you get a 'TlsException: Failure trusting builtin roots (OS Error:
//       // 	CERT_ALREADY_IN_HASH_TABLE' error here comment out the following 2 lines
//       context.setTrustedCertificates(currDir);
//       //
//       //   ..useCertificateChain('assets/certificate/roots.pem')
//       //   ..usePrivateKey('assets/certificate/roots.pem')
//       //   ..setClientAuthorities('assets/certificate/mosquitto.org.crt');

//       client.securityContext = context;
//     } else if (encryption.trim() != 'CA signed server certificate' &&
//         encryption.trim() != 'No Encryption') {}

//     client.onSubscribed = onSubscribed;

//     client.pongCallback = pong;
//     if (mqttVersion == '3.1') {
//       client.setProtocolV31();
//     } else if (mqttVersion == '3.1.1') {
//       client.setProtocolV311();
//     }

//     final connMess;
//     if (cleanSession) {
//       if (retained) {
//         connMess = MqttConnectMessage()
//             .withWillRetain()
//             .withClientIdentifier(
//                 clientIdentifier.isNotEmpty ? clientIdentifier : '')
//             .withWillTopic(willtopic.isNotEmpty
//                 ? willtopic
//                 : 'willtopic') // If you set this you must set a will message
//             .withWillMessage(
//                 WillMessage.isNotEmpty ? WillMessage : 'WillMessage')
//             .startClean() // Non persistent session for testing
//             .withWillQos(willQoS);
//       } else {
//         connMess = MqttConnectMessage()
//             .withClientIdentifier(
//                 clientIdentifier.isNotEmpty ? clientIdentifier : '')
//             .withWillTopic(willtopic.isNotEmpty
//                 ? willtopic
//                 : 'willtopic') // If you set this you must set a will message
//             .withWillMessage(
//                 WillMessage.isNotEmpty ? WillMessage : 'WillMessage')
//             .startClean() // Non persistent session for testing
//             .withWillQos(willQoS);
//       }
//     } else {
//       if (retained) {
//         connMess = MqttConnectMessage()
//             .withWillRetain()
//             .withClientIdentifier(
//                 clientIdentifier.isNotEmpty ? clientIdentifier : '')
//             .withWillTopic(willtopic.isNotEmpty
//                 ? willtopic
//                 : 'willtopic') // If you set this you must set a will message
//             .withWillMessage(
//                 WillMessage.isNotEmpty ? WillMessage : 'WillMessage')
//             // Non persistent session for testing
//             .withWillQos(willQoS);
//       } else {
//         connMess = MqttConnectMessage()
//             .withClientIdentifier(
//                 clientIdentifier.isNotEmpty ? clientIdentifier : '')
//             .withWillTopic(willtopic.isNotEmpty
//                 ? willtopic
//                 : 'willtopic') // If you set this you must set a will message
//             .withWillMessage(
//                 WillMessage.isNotEmpty ? WillMessage : 'WillMessage')
//             // Non persistent session for testing
//             .withWillQos(willQoS);
//       }
//     }

//     ///     tls ------ ssl

//     client.connectionMessage = connMess;

//     try {
//       if (userName.isNotEmpty) {
//         await client.connect(userName, pass);
//       } else {
//         await client.connect();
//       }
//     } on NoConnectionException catch (e) {
//       // Raised by the client when connection fails.
//       // print('EXAMPLE::client exception - $e');
//       // client.disconnect();
//       return 'Disconnected';
//     } on SocketException catch (e) {
//       // Raised by the socket layer
//       // print('EXAMPLE::socket exception - $e');
//       // client.disconnect();
//       return 'Disconnected';
//     }

//     if (client.connectionStatus!.state == MqttConnectionState.connected) {
//       print('Mosquitto client connected');
//       Get.snackbar("", "Client Connected", icon: Icon(Icons.cloud));

//       String pubTopic = willtopic.isNotEmpty ? willtopic : 'willtopic';

//       client.subscribe(pubTopic, MqttQos.atLeastOnce);
//       client.updates!
//           .listen((List<MqttReceivedMessage<MqttMessage?>>? c) async {
//         final recMess = c![0].payload as MqttPublishMessage;
//         final pt =
//             MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
//         updateCallback(c[0].topic.toString(), pt);
//         data.value = pt + " -- " + c[0].topic;
//         print('message:: ${data.value}');

//         notifyListeners();
//       });
//     } else {
//       print(
//           'MQTT_LOGS::ERROR Mosquitto client connection failed - disconnecting, status is ${client.connectionStatus}');
//       client.disconnect();
//       return 'Disconnected';
//     }

//     return 'Connected';
//   }

//   void onConnected() {
//     print('MQTT_LOGS:: Connected');
//   }

//   void unsubscribeFromTopic(String topic) {
//     disconnect();
//     if (client.connectionStatus!.state == MqttConnectionState.connected) {
//       client.unsubscribe(topic);
//     } else {
//       print('Client not connected.');
//     }
//   }

//   void disconnect() {
//     if (client.connectionStatus!.state == MqttConnectionState.connected) {
//       client.disconnect();
//     } else {
//       print('Client not connected.');
//     }
//   }

//   void onDisconnected() {
//     print('MQTT_LOGS:: Disconnected');
//   }

//   void onSubscribed(String topic) {
//     print('MQTT_LOGS:: Subscribed topic: $topic');
//   }

//   void onSubscribeFail(String topic) {
//     print('MQTT_LOGS:: Failed to subscribe $topic');
//   }

//   void onUnsubscribed(String? topic) {
//     print('MQTT_LOGS:: Unsubscribed topic: $topic');
//   }

//   void pong() {
//     print('MQTT_LOGS:: Ping response client callback invoked');
//   }

//   void onAutoReconnect() {
//     client.connect();
//   }

//   void updateMqttData(BuildContext context, String topic, String data) {
//     if (context != null) {
//       // Provider.of<TopicListProvider>(context, listen: false)
//       //     .updateTopicValue(topic, data);
//     }
//   }
// }
