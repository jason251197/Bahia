class AppURLs {
  static const String _baseUri =
      'https://planetolivercentrodeoperaciones.azurewebsites.net';

  static const googleSignIn = [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly'
  ];
  static const facebookURL =
      'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=';

  static const sentryURL =
      'https://bc6db2b84f4a4964a369bab33978f060@o470272.ingest.sentry.io/5500692';

  static const newCard = _baseUri + '/Payment?Param=';

  static const onCreateSuccessCard = _baseUri + '/Payment/Success';

  static const onCreateFailCard = _baseUri + '/Payment/Fail';

  static const terms =
      'https://planetolivercentrodeoperaciones.azurewebsites.net/TerminosyCondicionesCliente';

  static const terms2 =
      'https://www.planetoliver.com/t%C3%A9rminos-y-condiciones';

  static const politicas = 'https://www.planetoliver.com/politica-de-datos';

  static const mapsMarket = 'https://www.google.com/maps/search/?api=1&query=';

  static const PLAY_STORE_URL =
      'market://details?id=com.planetoliver.appclientes';
  //'https://play.google.com/store/apps/details?id=com.planetoliver.appclientes';

  static const APP_STORE_URL = 'itms-apps://itunes.apple.com/app/1542785273';
  //'https://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftwareUpdate?id=1542785273&mt=8';
}
