library cart_controller;

import 'package:appclientes/cache/cache.dart';
import 'package:appclientes/service/dialog/dialog_service.dart';
import 'package:appclientes/service/logger/logger.dart';
import 'package:appclientes/service/services.dart';
import 'package:appclientes/shared/components/app_button_switch/switch_option.dart';
import 'package:appclientes/shared/helpers/converter.dart';
import 'package:appclientes/shared/helpers/fake_utils.dart';
import 'package:appclientes/v_card/controller/index.dart';
import 'package:appclientes/v_home/controller/index.dart';
import 'package:rxdart/rxdart.dart';
import 'package:appclientes/shared/constants/params.dart';
import 'package:appclientes/shared/components/app_bar/controller/app_bar_state.dart';
import 'package:appclientes/service/api/model/header_response.dart';
import 'package:appclientes/v_cart/controller/state/order_type_state.dart';
import 'package:appclientes/shared/helpers/form_controller.dart';
import 'package:appclientes/v_order/controller/order_controller.dart';

part 'events/cart_events.dart';
part 'models/cart_model.dart';
part 'models/order_model.dart';
part 'models/order_detail_model.dart';
part 'models/coupon_model.dart';
part 'models/coupon_validate_model.dart';
part 'repo/cart_repo.dart';
part 'state/cart_state.dart';
part 'state/coupon_state.dart';
