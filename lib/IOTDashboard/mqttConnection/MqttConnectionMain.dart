// ignore: file_names
// ignore_for_file: file_names

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mauto_iot/utils/topicProvider.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';

import '../../model/topicModel.dart';
import 'package:mauto_iot/model/VariableModel.dart';
import '../../utils/variablesProvider.dart';

final client = MqttServerClient('', '');

var pongCount = 0; // Pong counter

// ignore: non_constant_identifier_names
Future<String> MqttConnectionMain(
    void Function(String topic, String message) updateCallback,
    List<VariableModel> variableList,
    List<TopicModel> topicstoSub,
    String url,
    String clientIdentifier,
    int keepAlivePeriod,
    int port,
    int connectTimeoutPeriod,
    String willtopic,
    String WillMessage,
    String userName,
    String pass,
    String userTopic,
    bool cleanSession,
    MqttQos willQoS,
    String mqttVersion,
    String encryption,
    bool retained) async {
  client.server = url;
  client.logging(on: true);
  client.clientIdentifier = clientIdentifier;
  print("url $url willtopic $willtopic  clientIdentifier $clientIdentifier");

  /// Set the correct MQTT protocol for mosquito

  /// If you intend to use a keep alive you must set it here otherwise keep alive will be disabled.
  client.keepAlivePeriod = keepAlivePeriod;
  client.port = port;

  /// The connection timeout period can be set if needed, the default is 5 seconds.
  client.connectTimeoutPeriod = connectTimeoutPeriod; // milliseconds

  /// Add the unsolicited disconnection callback
  client.onDisconnected = onDisconnected;

  /// Add the successful connection callback
  client.onConnected = onConnected;
  client.onAutoReconnect = onAutoReconnect;
  print(encryption.trim());
  if (encryption.trim() == 'CA signed server certificate') {
    final currDir = '../../../assets/certificate/mosquitto.org.crt';
    final context = SecurityContext.defaultContext;
    // Note if you get a 'TlsException: Failure trusting builtin roots (OS Error:
    // 	CERT_ALREADY_IN_HASH_TABLE' error here comment out the following 2 lines
    context.setTrustedCertificates(currDir);
    //
    //   ..useCertificateChain('assets/certificate/roots.pem')
    //   ..usePrivateKey('assets/certificate/roots.pem')
    //   ..setClientAuthorities('assets/certificate/mosquitto.org.crt');

    client.securityContext = context;
  } else if (encryption.trim() != 'CA signed server certificate' &&
      encryption.trim() != 'No Encryption') {
//   print('EXAMPLE::Mosquitto client connecting....');

    // client.securityContext = SecurityContext.defaultContext;
    // client.secure = true;

// client.securityContext = context;
  }

  /// Add a subscribed callback, there is also an unsubscribed callback if you need it.
  /// You can add these before connection or change them dynamically after connection if
  /// you wish. There is also an onSubscribeFail callback for failed subscriptions, these
  /// can fail either because you have tried to subscribe to an invalid topic or the broker
  /// rejects the subscribe request.
  client.onSubscribed = onSubscribed;

  /// Set a ping received callback if needed, called whenever a ping response(pong) is received
  /// from the broker.
  client.pongCallback = pong;
  if (mqttVersion == '3.1') {
    client.setProtocolV31();
  } else if (mqttVersion == '3.1.1') {
    client.setProtocolV311();
  }

  /// Create a connection message to use or use the default one. The default one sets the
  /// client identifier, any supplied username/password and clean session,
  /// an example of a specific one below.
  ///
  ///
  ///
  final connMess;
  if (cleanSession) {
    if (retained) {
      connMess = MqttConnectMessage()
          .withWillRetain()
          .withClientIdentifier(
              clientIdentifier.isNotEmpty ? clientIdentifier : '')
          .withWillTopic(willtopic.isNotEmpty
              ? willtopic
              : 'willtopic') // If you set this you must set a will message
          .withWillMessage(WillMessage.isNotEmpty ? WillMessage : 'WillMessage')
          .startClean() // Non persistent session for testing
          .withWillQos(willQoS);
    } else {
      connMess = MqttConnectMessage()
          .withClientIdentifier(
              clientIdentifier.isNotEmpty ? clientIdentifier : '')
          .withWillTopic(willtopic.isNotEmpty
              ? willtopic
              : 'willtopic') // If you set this you must set a will message
          .withWillMessage(WillMessage.isNotEmpty ? WillMessage : 'WillMessage')
          .startClean() // Non persistent session for testing
          .withWillQos(willQoS);
    }
  } else {
    if (retained) {
      connMess = MqttConnectMessage()
          .withWillRetain()
          .withClientIdentifier(
              clientIdentifier.isNotEmpty ? clientIdentifier : '')
          .withWillTopic(willtopic.isNotEmpty
              ? willtopic
              : 'willtopic') // If you set this you must set a will message
          .withWillMessage(WillMessage.isNotEmpty ? WillMessage : 'WillMessage')
          // Non persistent session for testing
          .withWillQos(willQoS);
    } else {
      connMess = MqttConnectMessage()
          .withClientIdentifier(
              clientIdentifier.isNotEmpty ? clientIdentifier : '')
          .withWillTopic(willtopic.isNotEmpty
              ? willtopic
              : 'willtopic') // If you set this you must set a will message
          .withWillMessage(WillMessage.isNotEmpty ? WillMessage : 'WillMessage')
          // Non persistent session for testing
          .withWillQos(willQoS);
    }
  }

  ///     tls ------ ssl

  client.connectionMessage = connMess;

  /// Connect the client, any errors here are communicated by raising of the appropriate exception. Note
  /// in some circumstances the broker will just disconnect us, see the spec about this, we however will
  /// never send malformed messages.
  try {
    if (userName.isNotEmpty) {
      await client.connect(userName, pass);
    } else {
      await client.connect();
    }
  } on NoConnectionException catch (e) {
    // Raised by the client when connection fails.
    // print('EXAMPLE::client exception - $e');
    // client.disconnect();
    return 'Disconnected';
  } on SocketException catch (e) {
    // Raised by the socket layer
    // print('EXAMPLE::socket exception - $e');
    // client.disconnect();
    return 'Disconnected';
  }

  /// Check we are connected
  if (client.connectionStatus!.state == MqttConnectionState.connected) {
    print('Mosquitto client connected');

//     String pubTopic = willtopic.isNotEmpty ? willtopic : 'willtopic';
//     final builder = MqttClientPayloadBuilder();
//     builder.clear();
//     builder.addString('Welcome to Mauto IOT MQTT Service');

//     client.subscribe(pubTopic, MqttQos.atLeastOnce);
// //  await MqttUtilities.asyncSleep(10);

//     client.publishMessage(pubTopic, MqttQos.exactlyOnce, builder.payload!);
    if (topicstoSub.isNotEmpty) {
      for (int i = 0; i < topicstoSub.length; i++) {
        if (topicstoSub[i].type == 'Pub-topic') {
          String payloadValue = variableList
              .firstWhere(
                  (element) => element.variableID == topicstoSub[i].variable)
              .pubTopicValueType
              .toString();

          // final builder = MqttClientPayloadBuilder();
          // builder.clear();
          // builder.addString(payloadValue);

          if (topicstoSub[i] == "Sub-topic") {
            client.subscribe(topicstoSub[i].userTopic, topicstoSub[i].willQoS);
          }
          // if (builder.payload != null && payloadValue.isNotEmpty) {
          //   print("payloadValue $payloadValue");
          //   client.publishMessage(topicstoSub[i].userTopic,
          //       topicstoSub[i].willQoS, builder.payload!);
          // }
        } else {
          client.subscribe(topicstoSub[i].userTopic, topicstoSub[i].willQoS);
        }
      }
    }
    client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final recMess = c![0].payload as MqttPublishMessage;
      final pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

      if (pt != 'WillMessage') {
        updateCallback(c[0].topic, pt);
      }

      // print('notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
      Get.snackbar("Notification", "${pt} from ${c[0].topic} Topic",
          icon: Icon(Icons.cloud));
      // print('');
    });

    client.published!.listen((MqttPublishMessage message) {
      print(
          'Published notification:: topic is ${message.variableHeader!.topicName}, with Qos ${message.header!.qos}');
    });
  } else {
    /// Use status here rather than state if you also want the broker return code.
    // print('client connection failed');
    // Get.snackbar("", "Client Connection Failed", icon: Icon(Icons.cloud));
    client.disconnect();
    return 'Disconnected';
    // exit(-1);
  }

  // await MqttUtilities.asyncSleep(5);
  // print('EXAMPLE::Disconnecting');
  // client.disconnect();
  print('testtttt ');
  return client.connectionStatus!.state == MqttConnectionState.connected
      ? 'Connected'
      : 'Disconnected';
}

/// The subscribed callback
void onSubscribed(String topic) {
  print('EXAMPLE::Subscription confirmed for topic $topic');
}

/// The unsolicited disconnect callback
void onDisconnected() {
  print('EXAMPLE::OnDisconnected client callback - Client disconnection');

  if (client.connectionStatus!.disconnectionOrigin ==
      MqttDisconnectionOrigin.solicited) {
    print('EXAMPLE::OnDisconnected callback is solicited, this is correct');
    // Get.snackbar("", "Client Connection Failed", icon: Icon(Icons.cloud));
  } else {
    print(
        'EXAMPLE::OnDisconnected callback is unsolicited or none, this is incorrect - exiting');
  }
  if (pongCount == 3) {
    print('EXAMPLE:: Pong count is correct');
  } else {
    print('EXAMPLE:: Pong count is incorrect, expected 3. actual $pongCount');
  }

  Get.snackbar("", "Client Disconnected", icon: Icon(Icons.cloud));
}

void reconnect() async {
  try {
    // Attempt to reconnect
    await client.connect();
  } on NoConnectionException catch (e) {
    print('Reconnect failed: $e');
    return;
  } on SocketException catch (e) {
    print('Reconnect failed: $e');
    return;
  }

  // Check if the client is connected after reconnection
  if (client.connectionStatus!.state == MqttConnectionState.connected) {
    print('Mosquitto client reconnected');
    Get.snackbar("", "Client Reconnected", icon: Icon(Icons.cloud));

    // Subscribe to topics or perform any additional setup if needed
  } else {
    print('Client reconnection failed');
    Get.snackbar("", "Client Reconnection Failed", icon: Icon(Icons.cloud));
  }
}

/// The successful connect callback
void onConnected() {
  print(
      'EXAMPLE::OnConnected client callback - Client connection was successful');
}

/// Pong callback
void pong() {
  print('EXAMPLE::Ping response client callback invoked');
  if (client.connectionStatus!.state != MqttConnectionState.connected) {
    print('unsub 222');
    client.disconnect();
  } else {
    pongCount++;
  }
}

void onAutoReconnect() {
  client.connect();
}

void unsubscribeFromTopic(String topic) {
  disconnect();
  if (client.connectionStatus!.state == MqttConnectionState.connected) {
    client.unsubscribe(topic);
  } else {
    print('Client not connected.');
  }
}

void sendPubTopicData(MqttQos willQoS, String topic, String payloadValue) {
  if (client.connectionStatus!.state == MqttConnectionState.connected) {
    final builder = MqttClientPayloadBuilder();
    builder.clear();
    builder.addString(payloadValue);

    client.publishMessage(topic, willQoS, builder.payload!);
  } else {
    print('Client not connected.');
  }
}

void disconnect() {
  if (client.connectionStatus!.state == MqttConnectionState.connected) {
    client.disconnect();
  } else {
    print('Client not connected.');
  }
}
