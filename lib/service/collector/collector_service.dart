import 'package:appclientes/service/sentry/sentry_service.dart';
import 'package:appclientes/shared/components/app_bar/controller/app_bar_state.dart';
import 'package:appclientes/v_cart/controller/index.dart';

class CollectorService {
  static void get cleanStates {
    AddressState().clean;
    SentryService().cleanPrefs;

    /// [FILL WITH STATES]
  }

  static void get cleanCart {
    CartState().clean;
    CouponState().clean;

    /// [FILL WITH STATES]
  }
}
