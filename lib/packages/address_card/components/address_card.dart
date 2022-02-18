part of '../address_card.dart';

/// Widget based in an [AlertDialog] with a search bar and list of results,
/// all in one box.
class AddressCard extends StatefulWidget {
  /// Controls the text being edited.
  ///
  /// If null, this widget will create its own [TextEditingController].
  final TextEditingController controller;

  /// Country where look for an address.
  final String country;

  /// City where look for an address.
  final String city;

  /// Hint text for [AddressCard].
  final String hintText;

  /// Resulting addresses to be ignored.
  final List<String> exceptions;

  /// If it finds coordinates, they will be set to the reference.
  final bool coordForRef;

  final bool addAddress;

  final AddressModel loadAddress;

  /// Callback to run when search ends.
  final Function(BuildContext dialogContext, AddressModel point) onDone;

  /// Constructs an [AddressCard] widget from a concrete [country].
  AddressCard({
    TextEditingController controller,
    this.country = "Peru",
    this.city = "Lima",
    this.hintText = "Direccion",
    this.exceptions = const <String>[],
    this.coordForRef = false,
    this.onDone,
    this.addAddress,
    this.loadAddress,
  })  : assert(country.isNotEmpty, "Country can't be empty"),
        assert(country != null),
        assert(hintText != null),
        this.controller = controller ?? TextEditingController();

  @override
  _AddressCardState createState() => _AddressCardState(
        controller,
        country,
        city,
        hintText,
        exceptions,
        coordForRef,
        onDone,
      );
}

/// State of [AddressCard].
class _AddressCardState extends State<AddressCard> {
  static const _idty = "address_card_widget";
  static void log(value) => Logger.log(_idty, [value]);

  final TextEditingController controller;

  bool flagMapService = false;
  bool _isLoading = false;

  final String country;
  final String city;
  final String hintText;
  final List<String> exceptions;
  final bool coordForRef;
  final Function(BuildContext context, AddressModel point) onDone;
  final AddressPoint _addressPoint = AddressPoint._();
  List<Suggestion> _address = [];
  final Location locationController = Location();

  final addressFormKey = GlobalKey<FormState>();

  BuildContext _dialogContext;
  bool _loading;
  bool _waiting;
  TextEditingController titleController;
  TextEditingController nroController;
  Position _position;
  String _msgloading= 'Cargando dirección..';

  /// Creates the state of an [AddressCard] widget.
  _AddressCardState(
    this.controller,
    this.country,
    this.city,
    this.hintText,
    this.exceptions,
    this.coordForRef,
    this.onDone,
  ) {
    // initLocationService();
  }

  @override
  void initState() {
    super.initState();

    /// TODO: CHANGE COUNTRY DEFAULT
    _addressPoint._country = country ?? "Colombia";
    titleController = TextEditingController();
    nroController = TextEditingController();
    addPositionToAddress();
    _loading = false;
    _waiting = true;
    controller.text = _msgloading;
  }

  Future addPositionToAddress() async {
    if (await AppConnectivity.check()) {
      if (await LocationService.hasActiveLocation()) {
        PermissionStatus permissionStatus;
        PermissionStatus permissionGranted =
            await locationController.hasPermission();
        if (permissionGranted != PermissionStatus.granted) {
          permissionStatus = await locationController.requestPermission();
        } else {
          permissionStatus = PermissionStatus.granted;
        }
        if (permissionStatus == PermissionStatus.granted) {
          _position = await Geolocator.getCurrentPosition();
          if (widget.loadAddress is AddressModel &&
              widget.loadAddress.hasCoordenates) {
            _position = Position(
                longitude: widget.loadAddress.longitude,
                latitude: widget.loadAddress.latitude);
          }else {
            _position = await Geolocator.getCurrentPosition();
          }
          updateInformation(_position, ' ');
        } else {
          //NavController.goToRegisterAddress();
          //Navigator.pop(context);//comentado por APPSTORE
          //await DialogService.localizationError;//comentado por APPSTORE
          controller.text = '';
        }
      } else {
        //Navigator.pop(context);//comentado por APPSTORE
        controller.text = '';
      }
    }
  }

  void handleOpenLookUp(Suggestion lookupAddress) async {
    final newPosition =
        await GProvider.getPlaceDetailFromId(lookupAddress.placeId);

    if (newPosition is Position) {
      goToMaps(newPosition).then((value) {
        FocusScope.of(context).requestFocus(FocusNode());
        addressFormKey.currentState.validate();
        setState(() {
          _waiting = true;
        });
      });
    } else {
      DialogService.simpleDialog(
          "No se encontró coordenadas adecuadas para abrir esta dirección");
    }
  }

  @override
  Widget build(BuildContext context) {
    _dialogContext = context;
    return Column(
      children: <Widget>[
        _textsInputs,
        if (!_waiting)
          Container(
            child: Expanded(
              child: Container(
                color: AppColors.graySoft4,
                child: ListView(
                  children: <Widget>[
                    _textFieldAddressSearchResult,
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Future goToMaps([Position lookPosition]) async {
    //if (await LocationService.hasActiveLocation()) {//comentado por APPSTORE
      //Location location = new Location();
      //LocationData _currentLocation;
      if (await LocationService.hasActiveLocation()) {
        if (_position == null) {
          /*_currentLocation = await location.getLocation();
         _position = Position(
             longitude: _currentLocation.longitude,
             latitude: _currentLocation.latitude);*/
          _position = await Geolocator
              .getCurrentPosition(); //{await addPositionToAddress();}
        }
      }else{
        _position = Position(latitude: 4.7216329, longitude: -74.033318);
      }
      FocusScope.of(context).requestFocus(FocusNode());

      final information = await Navigator.push(
        context,
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (_context) => WillPopScope(
              onWillPop: () async {
                Navigator.pop(_context);
                return false;
              },
              child: GMapView(position: lookPosition ?? _position)),
        ),
      );
      if (information is Position) {
        _position = information;
        updateInformation(information);
      }
    //}//comentado por APPSTORE
  }

  void updateInformation(Position position, [String key = '']) async {
    final mock = 'Cargando dirección... $key';

    if (mounted)
      setState(() {
        controller.text = mock;
      });
    try {
      String address = await GProvider.getFromCoordenates(
          position.latitude, position.longitude);

      if (controller.text == mock) {
        controller.text = address ?? '';
      }

      Future.delayed(Duration(milliseconds: 500), () {
        if (address is String && address.isNotEmpty && mounted) {
          setState(() {
            flagMapService = true;
          });
        }
      });
    } catch (_) {
      controller.text = '';
    }
    if (mounted) setState(() {});
  }

  /// Returns the address search bar widget to write an address reference.
  Widget get _textsInputs => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: !_waiting
              ? [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: Offset(0, 5), // changes position of shadow
                  ),
                ]
              : null,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30),
          child: Form(
            key: addressFormKey,
            child: Column(
              children: [
                FormInput(
                  key: Key('title_g_controller'),
                  controller: titleController,
                  initialText: widget.loadAddress is! AddressModel ||
                          widget.loadAddress?.name is! String
                      ? ""
                      : widget.loadAddress?.name,
                  hintText: "Nombre",
                  // validator: addressValidator,
                  icon: Icon(Icons.home),
                  // icon: AppIcon.path(AppIcon.home, color: AppColors.gray),
                ),
                SizedBox(height: 40),
                FormInput(
                  key: Key('address_g_controller'),
                  onChange: (_) async {
                    if (_.isEmpty)
                      setState(() => _waiting = true);
                    else
                      await _searchAddress(_);
                  },
                  controller: controller,
                  hintText: "Dirección",
                  validator: addressValidator,
                  // validator: wordlValidator,
                  icon: Icon(Icons.location_on),
                  textInputAction: TextInputAction.search,
                  initialText: _msgloading ,
                  suffixIcon: InkWell(
                      onTap: () async => goToMaps().then((value) {
                            FocusScope.of(context).requestFocus(FocusNode());
                            addressFormKey.currentState.validate();
                          }),
                      child: Container(
                          width: 50,
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: AppIcon.path(AppIcon.location)))),
                ),
                if (_waiting)
                  Column(
                    children: [
                      Container(
                        margin: EdgeInset.vertical(40),
                        child: FormInput(
                          key: Key('number_g_controller'),
                          initialText: widget.loadAddress?.references ?? null,
                          controller: nroController,
                          hintText: "Num. de apartamento",
                          // validator: addressValidator,
                          icon: Icon(Icons.account_balance_wallet),
                          // AppIcon.path(AppIcon.door, color: AppColors.gray),
                        ),
                      ),
                      if (widget.addAddress ?? false)
                        SaveTag("Agregar dirección",
                            icon: AppIcon.save, onPress: _onClickDone)
                      else if (widget.loadAddress is AddressModel)
                        Buttons.yellow("Actualizar dirección",
                            onClick: _onClickDone)
                      else
                        Buttons.yellow("Agregar dirección",
                            onClick: _onClickDone),
                    ],
                  ),
              ],
            ),
          ),
        ),
      );

  /// Returns a [Widget] depending on the state of the search
  /// process and its result.
  ///
  /// Returns [CircularProgressIndicator] while it's searching the address.
  /// Returns [ListView] if search found places.
  Widget get _textFieldAddressSearchResult => Container(
        alignment: Alignment.centerLeft,
        child: Center(
          child: _loading
              ? CircularProgressIndicator()
              : ((_address.isNotEmpty)
                  ? Column(
                      children: [
                        Container(
                            padding: const EdgeInsets.only(right: 10),
                            alignment: Alignment.centerRight,
                            child: XButton(
                              onDelete: () => setState(() => _waiting = true),
                            )),
                        Container(
                          height: 500,
                          child: ListView.separated(
                            padding: EdgeInsets.all(10.0),
                            itemCount: _address.length,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    (index != _address.length - 1)
                                        ? Divider()
                                        : Container(),
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                    bottom: BorderSide(
                                        width: 1, color: AppColors.graySoft3),
                                  )),
                                  child: ListTile(
                                    leading: Icon(Icons.location_on),
                                    trailing: InkWell(
                                        onTap: () =>
                                            handleOpenLookUp(_address[index]),
                                        child: Container(
                                            width: 50,
                                            child: Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: AppIcon.path(
                                                    AppIcon.location)))),
                                    title: Text(
                                        _address[index]?.description ?? ''),
                                  ),
                                ),
                                onTap: () async {
                                  controller.text =
                                      _address[index]?.description ?? '';
                                  await _asyncFunct(_address[index]);
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  : Container(
                      child: Column(
                        children: [
                          Text('No se encontró resultados'),
                          XButton(
                            onDelete: () => setState(() => _waiting = true),
                          ),
                        ],
                      ),
                    )),
        ),
      );

  /// It uses the user's reference to search for nearby addresses
  /// and places to obtain coordinates.
  Future<void> _searchAddress(String onSearch) async {
    setState(() {
      _loading = true;
      _waiting = false;
      flagMapService = false;
    });
    final int length = onSearch.length;
    await Future.delayed(Duration(seconds: 1), () async {
      if (onSearch.isEmpty) {
        _address.clear();
        _loading = false;
        setState(() {});
      } else if (length == controller.text.length) {
        try {
          List<Suggestion> placeMarks;
          if (controller.text.isNotEmpty) {
            placeMarks = await GProvider.fetchSuggestions(onSearch);

            if (placeMarks.isNotEmpty) {
              setState(() {
                _address = placeMarks;
              });
            }
          }
        } catch (_) {
          log("ERROR CATCHED: " + _.toString());
        }
        _loading = false;
        setState(() {});
      }
    });
  }

  /// If the user runs an asynchronous process in [onDone] function
  /// it will display an [CircularProgressIndicator] (changing [_waiting]
  /// vairable) in the [AddressCard] until the process ends.
  Future<void> _asyncFunct(Suggestion address, {bool notFound = false}) async {
    setState(() {
      _waiting = true;
    });

    _getPosition(address);
    if (notFound) {
      _addressPoint._latitude = 0.0;
      _addressPoint._longitude = 0.0;
    }

    FocusScope.of(context).requestFocus(FocusNode());
  }

  Future<Position> _getPosition(Suggestion suggestion) async {
    Position newPosition;
    try {
      newPosition = await GProvider.getPlaceDetailFromId(suggestion.placeId);

      if (newPosition is Position) {
        _position = newPosition;

        Future.delayed(Duration(milliseconds: 500), () {
          setState(() {
            flagMapService = true;
          });
        });
      }
    } catch (err) {}
    return newPosition;
  }

  Future<Position> _getPositionFromText() async {
    Position newPosition;

    final text = controller.text;
    try {
      newPosition = await GProvider.getPlaceFromText(text);

      if (newPosition is Position) {
        _position = newPosition;
      }
    } catch (err) {}
    return newPosition;
  }

  /// ON SAVE/CREATE/UPDATE ADDRESS [_onClickDone]
  void _onClickDone() async {
    if (_isLoading) return;

    _isLoading = true;

    if (await AppConnectivity.check()) {
      /*if (!await LocationService.hasLocationAccess) {
        _isLoading = false;
        return;
      } else*/ if (addressFormKey.currentState.validate()) {
        FocusScope.of(context).requestFocus(FocusNode());

        /// HAS VALID [tempAddress]
        final tempAddress = controller.text;
        if (tempAddress is! String || tempAddress.isEmpty) {
          _isLoading = false;
          return DialogService.adddressNotFound;
        }

        /// HAS VALID [reviewPosition]
        final reviewPosition =
            flagMapService ? _position : await _getPositionFromText();
        if (reviewPosition is! Position) {
          _isLoading = false;
          return DialogService.adddressNotFound;
        }

        AddressModel myAddress = AddressModel(
          code: widget.loadAddress?.code ?? '',
          name: titleController.text.isEmpty ? 'Otro' : titleController.text,
          references: nroController.text,
          address: controller.text,
          latitude: _position.latitude,
          longitude: _position.longitude,
        );

        String addressCode;
        bool updateSuccess;

        if (AppCache.verifyToken) {
          if (widget.loadAddress is AddressModel){
            bool doRedirect = true;
            if (!CartEvents.isCartEmpty())
              doRedirect = await DialogService.changeAddress;
              updateSuccess = false;
            if (doRedirect) {
              updateSuccess = await AddressRepository.updateAddress(myAddress);
              AddressModel _addressSelected = AddressCache?.getCurrentAddress;
              if (_addressSelected.code == myAddress.code) {
                await AddressCache.setSelectedAddress(myAddress);
                LocalizationController.updateSelectedAddressAndLoad(myAddress);
              }
            }
          }else{
            addressCode = await AddressRepository.addAddress(myAddress);
          }
        }
        final isAddressValid = addressCode is String || RootApi.hasBasicToken;

        final oldAddressCodeValid =
            myAddress.code is String && myAddress.code.isNotEmpty;

        final oldAddress = oldAddressCodeValid ? myAddress.code : null;

        if (isAddressValid)
          myAddress.code = addressCode ??
              oldAddress ??
              Random.secure().nextInt(100000).toString();

        log("CODIGO ${myAddress.code}");

        _isLoading = false;
        if (onDone != null && (isAddressValid || updateSuccess))
          await onDone(_dialogContext, myAddress);
        _address.clear();
        setState(() {});
      }
    } else {
      _isLoading = false;
    }
  }
}
