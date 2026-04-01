import 'package:nfc_manager/nfc_manager.dart';
import '../models/device_model.dart';
import 'device_service.dart';
import 'trust_service.dart';

class NfcService {

  // 🔥 Check NFC availability
  static Future<bool> isNfcAvailable() async {
    return await NfcManager.instance.isAvailable();
  }

  // 🔥 Start NFC listening
  static void startListening(
  Function(String deviceId) onTrustedDevice,
  Function(String deviceId) onNewDevice,
) {
  NfcManager.instance.startSession(
    pollingOptions: {NfcPollingOption.iso14443},

    onDiscovered: (NfcTag tag) async {

      print("NFC device detected");

      // 🔥 TEMP: generate dummy deviceId (later real exchange)
      String deviceId = DateTime.now().millisecondsSinceEpoch.toString();

      bool trusted = await TrustService.isTrusted(deviceId);

      if (trusted) {
        onTrustedDevice(deviceId);
      } else {
        onNewDevice(deviceId);
      }

      await NfcManager.instance.stopSession();
    },
  );
}
}