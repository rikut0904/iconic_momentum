import 'package:firebase_data_connect/firebase_data_connect.dart' as fdc;
import 'package:masamune_model_firebase_data_connect_annotation/masamune_model_firebase_data_connect_annotation.dart'
    as annotation;

class DefaultConnector {
  static fdc.ConnectorConfig connectorConfig = fdc.ConnectorConfig(
    'us-central1',
    'default',
    'iconic_momentum',
  );

  fdc.FirebaseDataConnect dataConnect;

  DefaultConnector._internal(this.dataConnect);

  static DefaultConnector get instance {
    return DefaultConnector._internal(
      fdc.FirebaseDataConnect.instanceFor(
        connectorConfig: connectorConfig,
        sdkType: fdc.CallerSDKType.generated,
      ),
    );
  }
}
