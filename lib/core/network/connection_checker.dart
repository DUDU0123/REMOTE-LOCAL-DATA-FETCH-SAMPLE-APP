import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class ConnectionChecker {
  static StreamSubscription<List<ConnectivityResult>>? _subscription;
  Future<bool> checkConnection() async {
    List<ConnectivityResult> connectionStatus =
        await Connectivity().checkConnectivity();
    if (connectionStatus.contains(ConnectivityResult.none)) {
      networkErrorShowSnackbar();
      return false;
    } else {
      return true;
    }
  }

  static void listenForConnectionChanges() {
    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> connectionStatus) {
      if (connectionStatus.contains(ConnectivityResult.none)) {
        networkErrorShowSnackbar();
      } else {
        // call the event that you want for fetch data
      }
    });
  }

  static void cancelConnectionSubscription() {
    _subscription?.cancel();
  }

  static void networkErrorShowSnackbar({
    String? message,
  }) {
    Get.snackbar(
      "Info",
      message ?? "Please check your network connection",
    );
  }
}
