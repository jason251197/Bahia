class AppParams {
  static const renovartokenAntesDeVencimiento = 60; //si vence en 60 dias, se renueva el token antes de x dias que expire
  
  static final localLetter = 'L';
  static final productLetter = 'P';
  
  static const flagDelivery = '1';
  static const flagPickUp = '2';
  static const flagAll = '%';

  static final flagPickUpImmediately = '1';
  static final flagPickUpLater = '0';

  //static final List<num> tipList = [1000,2000,3000,4000];
  static final List<num> tipList = [0,200,300,500];
  //static final List<String> tipList = ["1000","2000","3000","4000"];
  static const tipIndexDefault = 1;
  
  static const payWitchCash = 'EFECTIVO';
  static const payWithCard = 'TARJETA';
  
  static const maxAmountAboveOrder = 100000;
}
