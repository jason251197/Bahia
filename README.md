# Planeta Oliver App

### Contenido

| n   | Content                                              |
| --- | ---------------------------------------------------- |
| 1   | [Instalación](#1-instalación)                        |
| 2   | [Estructura del Proyecto](#2-estructura-de-proyecto) |
| 3   | [Cliente Api](#3-cliente-api)                        |
| 4   | [Componentes Comunes](#4-componentes-comunes)        |
| 5   | [State](#5-state)                                    |
| 6   | [Reglas Simples](#6-reglas-simples)                  |
| 7   | [Paquetes](#7-paquetes)                              |
| 8   | [Soporte](#8-soporte)                                |

### 1. Instalación

Planet Oliver requiere de Flutter en version [1.22.6](https://flutter.dev/docs/development/tools/sdk/releases).

Una vez descargado realizar los pasos de la instalacion en [Mac/Windows](https://flutter.dev/docs/get-started/install/macos) (revisar requerimientos de sistema). Luego realizar los siguientes comandos

> Primero

```sh
$ flutter doctor
```

**(Y asegurarse que pase todos los checks)**

> Despues (dentro del proyecto)

```sh
$ flutter pub get
$ flutter run
```

### 2. Estructura de Proyecto

```
    .
    ├── ...
    ├── cache                   # Cache de Sesión
    ├── channel                 # Servicio de Bridge con Elementos nativos
    ├── packages                # flutter packages for planet oliver
    │   ├── adress                  # Complete form for Google maps Form Manager
    │   ├── pager                   # Scrollable page controller
    ├── Service                 # Servicios de Aplicación
    │   ├── api                     # Servicio de API
    │   ├── auth                    # Servicio de autenticacion
    │   └── boot                    # Servicios que se inicializan al iniciar la app
    │   └── cycle                   # Servicio de manejo de eventos de la app
    │   └── collector               # Servicio de limpieza de estados
    │   └── dialog                  # Servicio de Dialogos
    │   └── device                  # Servicio de dispositivo
    │   └── ip                      # Servicio de obtención de ip publica
    │   └── launcher                # Servicio para abrir web / web views
    │   └── localization            # Servicio para inicializar lenguaje de la app
    │   └── logger                  # Servicio de visor de registros
    │   └── navigation              # Servicio de navegación
    │   └── sentry                  # Servicio de control de errores
    │   └── version                 # Servicio de control de versiones
    │   └── session                 # Servicio de sesión
    ├── shared                  # Elementos compartidos
    │   ├── Components              # Widgets compartidos
    │   ├── Constants               # Imagenes, Colores, family fonts.
    │   └── utils                   # Controladores, validador de inputs, padding heleper
    │   └── Keys                    # Clase con static methods de keys de app
    │   ├── theme                   # Botones, textos, tema de app
    ├── v-[name]                # View (vista de pantalla)
    └── ...
```

#### 2.1 Tipos de Views

##### 2.1.1 Vista

- Contiene lógica
- Contiene Diseño
- Puede tener llamadas a servicios

##### 2.1.2 Vista Origen (V.Home)

- Controla Logica de Ruteo (Navegacion principal)

##### 2.1.2 Vista Modal

- Se llama a través de otro componente.
- Pantalla se crea encima de otras pantallas.
- No poseee redirección a otra pantalla solo salida.

##### 2.1.2 Vista Estatica

- Solo Contiene Vista, y muestra data mas no la controla ni la modifica.

#### 2.2 Estructura de Vista

> Cada nueva vista se debe crear bajo la misma estructura de vista la cual es la siguiente

```
  .
    ├── ...
    ├── v-[name]               # Nombre de la vista
    │   ├── Content            # Aqui irán todos los widgets de la pantalla
    │   ├── Constants          # Si existen constantes especiales solo para esta pantalla
    │   └── Controller         # Clase con static methods de keys de app
    |   │   ├── Model              # Modelos que se utilcen en esta pantalla
    |   │   ├── State              # Estados que se utilicen en esta pantalla
    |   │   └── Repo               # Repositorio que se utilicen en esta pantalla
    │   ├── data               # Contiene data estatica especifica de la pantalla
    │   ├── utils              # Contiene logica especifica de la pantalla
    │   └── [name].dart        # El nombre es el mismo del folder c ontiene la vista de inicio de la pantalla.
    └── ...
```

### 3. Cliente API

#### 3.1. Introducción (Dio)

- Dio es un poderoso dart client que combina muchos metodos para el envio y recepcion de data. Para mas información click [aqui](https://pub.dev/packages/dio)
- Dio Package en este proyecto utiliza la version **^3.0.9**

#### 3.2. Estructura

```
  .
    ├── ...
    ├── Api                        # Nombre de la vista
    │   ├── api_root                    # Core del cliente, metodos y manejo base.
    │   ├── api_client                  # Cliente api, manager de llamadas.
    │   └── apis                        # Lista de Apis
    │   └── model                       # Modelos de api
    |   │   ├── error_model                  # Modelo de error
    |   │   ├── header_response              # Heade response model
    └── ...
```

- Valores del api core a conocer:

> -> **\_baseUri** - https://2020planetoliver2050services.azurewebsites.net/apir
> -> **\_connectTimeoutr** - 10000
> -> **\_receiveTimeout** - 3000
> -> **\_encoder** - application/x-www-form-urlencoded
> -> **basicToken** - Basic amNhbGRlcm9uMjAyMDoxMjM0NTY3ODk=

#### 3.3. Agregar Un Nuevo Endpoint

Para Agregar un nuevo endpoint se realizan los siguientes pasos

> 1- Agregar un nuevo endpoint (apis.dart)

```
.
/// version 1
  static Future<Response> [METHOD-NAME](Map<String, dynamic> body) =>
                RootApi.Post([URL-NAME], body: body);

/// version 2
  static Future<Response> [METHOD-NAME](Map<String, dynamic> body) =>
                RootApi.Post([URL-NAME], body: body, verifyBase: true);

```

> RootApi.(GET,POST,ENCODED,DELETE,PUT) -> contiene los metodos para el tipo de llamada con el endpoint
> VerifyBase -> true/false, si es true entonces validara con auth base

### 4. Componentes Comunes

#### 4.1. Crear un Boton

> Dentro del un Function Widget colocar el siguiente código

```
// Buttons.[color]('name-button');
Buttons.green('Hola soy un boton')
```

> Agregar una funcion al presionar usar parametro onClick

```
// Buttons.[color]('name-button',onClick:<function()>);
Buttons.green('Hola soy un boton', onClick: () => print('presionado'))
```

> Parametros adicionales

- double paddingH, padding horizontal
- double paddingV, padding vertical
- double fontSize, tamaño de texto
- double width, tamaño ancho de boton
- double height,tamaño alto de boton
- String fontFamily, tipo de font family
- Function onClick, Funcion al Presionar
- bool disable = false, Deshabilitar boton

#### 4.2. Crear un Texto

> Dentro del un Function Widget colocar el siguiente código

```
// Texts.[color]{tipo}('name-button');
Texts.green('Hola soy un texto'),
Texts.greenBold('Hola soy un texto'),
Texts.greenLight('Hola soy un texto'),
```

> Parametros adicionales

    num maxLines, maximo numero de lineas
    TextAlign textAlign, alineamiento de texto
    TextOverflow overflow, tipo de overflow
    double textScaleFactor: 1.0, escala de texto (no mover a no ser necesario)
    double size = 14, Tamaño de Texto
    FontStyle fontStyle, Tipo de Font
    double letterSpacing = 0.8, Espacio entre letras
    double wordSpacing, Espacio entre palabras
    TextDecoration decoration, Decorador de Texto
    Color color, Color de Texto

#### 4.4. Crear un nuevo dialogo

> **Simple**
> => Utilizar el servicio de Dialogo (DialogService)
> => Utilzar simpleDialog

```
 /// await DialogService.simpleDialog('TEXTO')
 await DialogService.simpleDialog("Hola soy un dialogo");
```

> **SI y NO**
> => Utilizar el servicio de Dialogo (DialogService)
> => Utilizar metodo yesNoDialog

```
 final do = await DialogService.yesNoDialog('¿Está seguro');
 if(do){
     /// Si es True
 }else{
     /// Si es False
 }
```

### 5. State

#### 5.1 RxDart

- RxDart info [aqui](https://pub.dev/packages/rxdart)
- La version que utiliza el proyecto es la version ^0.24.1
- Obtienes streams y observables

#### 5.1 Singleton

- Encapsular el valor de una clase al momento de inicializar
- Se utiliza para crear una unica instancia de la clase
- Se utiliza dentro de state folder en conjunto con Rxdart para la creacion de Observables

#### 5.2. Crear un nuevo State

> En State

```

class MyState {
  static MyState _instance;
  BehaviorSubject<Object> _myState;

  Stream<Object> get events => _myState.stream;
  Object get value => _myState?.value ?? [BASE VALUE];
  void update(Object data) => _myState.add(data);
  void clear() => update(null);

  MyState._() {
    _myState = BehaviorSubject();
  }

  factory MyState() => _getInstance();
  static MyState _getInstance() => _instance = _instance?? myState._();

}

```

> En Render

```
StreamBuilder( /// utiliza el widget StreamBuilder
    stream: myState().events, /// utiliza eventos
     builder: (c, v) {
      final value = MyState().value;
         return Widget();
     }
```

### 6. Reglas Simples

> Utilizar **final** para valores que no van a cambiar despues de instanciados

```
final packageList = MyClass();
```

> Utilizar **App Padding** para la creacion de una nueva vista

```
 return AppPadding(
      child: Column(
        children: [
          Expanded(
          .
          .
          .
```

> Metodos de logica pueden ir dentro de las clases

```
class MyClass {
    String name;
    String lastName;

    /// si no necesita usar parametros usar GET Method
    String get getFormattedName => name + " " + lastName;
}
```

> Cualquier folder/archivo de mas de una palabra debe ir con '\_'

```
✓ my_login_folder
× myLoginFolder

✓ my_login_file.dart
× myLoginFile.dart
```

### 7. Paquetes

| Paquetes               | Version  | Descripcion                      |
| ---------------------- | -------- | -------------------------------- |
| responsive_screen      | ^1.0.0   | Metodos para screen responsive   |
| connectivity           | ^2.0.2   | Verificador de Conectividad      |
| permission_handler     | ^5.0.1+1 | Manejador de permisos de app     |
| url_launcher           | ^5.4.2   | Launcher Web/Webview             |
| cached_network_image   | ^2.0.0   | Cached de Imagen                 |
| shared_preferences     | ^0.5.6   | Cache de Base de Datos           |
| rxdart                 | ^0.24.1  | Observables y Streams values     |
| geolocator             | ^6.1.14  | Google Package para localizacion |
| geocoder               | ^0.2.1   | Convierte position a direccion   |
| location               | ^3.2.4   | Permisos para localizacion       |
| google_maps_flutter    | ^1.2.0   | Widget para renderizar mapa      |
| dio                    | ^3.0.9   | Dart Client                      |
| sentry                 | ^3.0.1   | Logger de Errores                |
| tuple                  | ^1.0.3   | Mapper package                   |
| flutter_webview_plugin | ^0.3.11  | WebView carga en aplicacion      |
| device_info            | ^0.4.2+6 | Obtiene info del dispositivo     |
| package_info           | ^0.4.3+4 | Obtiene la version de la app     |
| pattern_formatter      | ^1.0.2   | Formateo de inputs               |

### 8. Soporte

Para preguntas mensaje a [EMAIL-AQUI]
