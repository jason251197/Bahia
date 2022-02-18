import 'package:appclientes/service/auth/auth_service.dart';
import 'package:appclientes/shared/constants/icons.dart';

final List<Map<String, dynamic>> authOptions = [
  {
    'icon': AppIcon.apple,
    'title': 'Iniciar sesión con Apple',
    'type': AUTH_TYPE.APPLE,
  },
  {
    'icon': AppIcon.facebook,
    'title': 'Iniciar sesión con Facebook',
    'type': AUTH_TYPE.FACEBOOK,
  },
  {
    'icon': AppIcon.google,
    'title': 'Iniciar sesión con Google',
    'type': AUTH_TYPE.GOOGLE,
  },
];
