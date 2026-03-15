import 'package:nfc_manager/nfc_manager.dart';
import 'trust_service.dart';
import 'device_service.dart';
class NfcService {

  // Check if NFC is available
  static Future<bool> isNfcAvailable() async {
    return await NfcManager.instance.isAvailable();
  }

  // Start listening for NFC
  static void startListening(
    Function onTrustedDevice,
    Function onNewDevice,
  ) {

    NfcManager.instance.startSession(
      pollingOptions: {NfcPollingOption.iso14443},

      onDiscovered: (NfcTag tag) async {

        print("NFC device detected");

        
        String deviceId = await DeviceService.getDeviceId();

        bool trusted = await TrustService.isTrusted(deviceId);

        if (trusted) {
          onTrustedDevice();
        } else {
          onNewDevice();
        }

        await NfcManager.instance.stopSession();
      },
    );
  }
}