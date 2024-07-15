import 'package:core_dashboard/pages/monitoring/widgets/chart_model.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttHandler with ChangeNotifier {
  final ValueNotifier<String> data = ValueNotifier<String>("Hello");

  final int _counter = 0;
  int get counter => _counter;

  final List<String> _chartData = [];
  List<String> get chartData => _chartData;

  final List<ChartModel> _chartModeledData = [];
  List<ChartModel> get chartModeledData => _chartModeledData;

  late MqttServerClient client;

  Future<Object> connect() async {
    client = MqttServerClient.withPort('test.mosquitto.org', '', 1883);
    client.logging(on: true);
    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    client.onUnsubscribed = onUnsubscribed;
    client.onSubscribed = onSubscribed;
    client.onSubscribeFail = onSubscribeFail;
    client.pongCallback = pong;
    client.keepAlivePeriod = 60;
    client.logging(on: true);
    client.autoReconnect = true;
    client.onAutoReconnect = onAutoReconnect;
    client.onAutoReconnected = onAutoReconnected;

    /// Set the correct MQTT protocol for mosquito
    client.setProtocolV311();

    final connMessage = MqttConnectMessage()
        .withWillTopic('willtopic')
        .withWillMessage('Will message')
        .startClean()
        .withWillQos(MqttQos.exactlyOnce);

    print('MQTT_LOGS::Mosquitto client connecting....');

    client.connectionMessage = connMessage;
    try {
      await client.connect();
    } catch (e) {
      print('Exception: $e');
      client.disconnect();
    }

    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      print('MQTT_LOGS::Mosquitto client connected');
    } else {
      print(
          'MQTT_LOGS::ERROR Mosquitto client connection failed - disconnecting, status is ${client.connectionStatus}');
      client.disconnect();
      return -1;
    }

    print('MQTT_LOGS::Subscribing to the test/lol topic');
    const topic = 'ecofusion/1';
    client.subscribe(topic, MqttQos.exactlyOnce);

    client.updates!.listen(
      (List<MqttReceivedMessage<MqttMessage?>>? c) {
        final recMess = c![0].payload as MqttPublishMessage;
        final pt =
            MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

        data.value = pt;
        // addChartData(pt);
        notifyListeners();
        print(
            'MQTT_LOGS:: New data arrived: topic is <${c[0].topic}>, payload is $pt');
        print('');
      },
      onDone: () {
        print('done');
      },
    );

    return client;
  }

  void onConnected() {
    print('MQTT_LOGS:: Connected');
  }

  void onDisconnected() {
    print('MQTT_LOGS:: Disconnected');
  }

  void onSubscribed(String topic) {
    print('MQTT_LOGS:: Subscribed topic: $topic');
  }

  void onSubscribeFail(String topic) {
    print('MQTT_LOGS:: Failed to subscribe $topic');
  }

  void onUnsubscribed(String? topic) {
    print('MQTT_LOGS:: Unsubscribed topic: $topic');
  }

  void pong() {
    print('MQTT_LOGS:: Ping response client callback invoked');
  }

  /// The pre auto re connect callback
  void onAutoReconnect() {
    print('Client auto reconnection sequence will start');
  }

  /// The post auto re connect callback
  void onAutoReconnected() {
    print('Client auto reconnection sequence has completed');
  }

  Future publishMessage(String message) async {
    const pubTopic = 'ecofusion';
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);

    if (client.connectionStatus?.state == MqttConnectionState.connected) {
      client.publishMessage(pubTopic, MqttQos.atMostOnce, builder.payload!);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    data.dispose();
  }

  // void addChartData(String pt) {
  //   String timeStr = DateFormat('yy-mm-dd\nhh:mm:ss').format(DateTime.now());
  //   // if (ChartModeledData.length > 5) ChartModeledData.clear();
  //   _chartModeledData.add(ChartModel(label: timeStr, data: int.parse(pt)));
  //   notifyListeners();
  // }
}

//command for listening. usually for testing if the message has delivered to server
//mosquitto_sub -h test.mosquitto.org -t test -p 1883

//command for publishing message from terminal
//mosquitto_pub -h test.mosquitto.org -t test -p 1883
//Reference : https://mpolinowski.github.io/docs/Development/Javascript/2021-06-02--mqtt-cheat-sheet/2021-06-02/
