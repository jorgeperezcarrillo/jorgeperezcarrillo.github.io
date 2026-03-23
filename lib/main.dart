//    flutter pub get
//    flutter run -d chrome
//    cd C:\Users\jorge\webyo

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Website',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/sphib': (context) => SphibPage(),
        '/rocket': (context) => RocketPage(),
        '/cnc': (context) => CncCustomPage(),
        '/aprendido': (context) => AprendidoPage(),
        '/hibsim': (context) => HibsimPage(),
        '/sphib_details': (context) => SphibDetailsPage(),
        '/sphib_plans': (context) => SphibPlansPage(),
        '/rocket_electronics': (context) => RocketElectronicsPage(),
        '/rocket_engine_plan': (context) => RocketEnginePlanPage(),
      },
    );
  }
}

// Clase auxiliar para funciones globales
class Utils {
  static Future<void> launchURL(BuildContext context, String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: MediaQuery.of(context).platformBrightness == Brightness.light
            ? LaunchMode.platformDefault
            : LaunchMode.inAppWebView,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se pudo abrir $url')),
      );
    }
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  bool _isNavBarVisible = true;
  bool _isMouseAtTop = false;
  double _lastScrollOffset = 0;
  DateTime _lastScrollUpdate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
  }

  void _handleScroll() {
    if (DateTime.now().difference(_lastScrollUpdate).inMilliseconds < 50) return;
    _lastScrollUpdate = DateTime.now();

    setState(() {
      double offset = _scrollController.offset;
      if (offset <= 0) {
        _isNavBarVisible = true;
      } else if (offset < _lastScrollOffset) {
        _isNavBarVisible = true;
      } else {
        _isNavBarVisible = false;
      }
      _lastScrollOffset = offset;
    });
  }

  void _onMouseEnter(PointerEvent details) {
    setState(() {
      _isMouseAtTop = details.position.dy < 100;
      if (_isMouseAtTop) {
        _isNavBarVisible = true;
      }
    });
  }

  void _onMouseExit(PointerEvent details) {
    setState(() {
      _isMouseAtTop = false;
      if (_scrollController.offset > 0) {
        _isNavBarVisible = false;
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey _projectsKey = GlobalKey();
    final bool isMobile = !kIsWeb && (Platform.isAndroid || Platform.isIOS);
    final bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      body: Stack(
        children: [
          MouseRegion(
            onEnter: _onMouseEnter,
            onExit: _onMouseExit,
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: ClampingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/background.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Proyectos',
                            style: TextStyle(
                              fontSize: 32,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  blurRadius: 10.0,
                                  color: Colors.black45,
                                  offset: Offset(2.0, 2.0),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Explora mis proyectos personales en ingeniería de cohetes.'
                            'Baja para ver los Proyectos, o usa el menú de arriba, si estas en movil recomiendo girarlo .'
                            'y poner el "sitio para ordenadores" para que los textos no colapsen y aparezcan todos los botones ;-)  '
                            'jorgeperezcarrillo05@gmail.com',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    key: _projectsKey,
                    padding: EdgeInsets.all(32.0),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Proyectos',
                          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 16),
                        Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 16,
                          runSpacing: 16,
                          children: [
                            ProjectCard(
                              title: 'SPHIB',
                              description: 'Sistema de propulsión híbrida',
                              imagePath: 'assets/sphib.jpg',
                              onTap: () {
                                Navigator.pushNamed(context, '/sphib');
                              },
                            ),
                            ProjectCard(
                              title: 'Cohete Experimental',
                              description: 'Cohete experimental',
                              imagePath: 'assets/rocket.jpg',
                              onTap: () {
                                Navigator.pushNamed(context, '/rocket');
                              },
                            ),
                            ProjectCard(
                              title: 'HIBSIM',
                              description: 'Simulador de motores cohete híbridos',
                              imagePath: 'assets/hibsim.jpg',
                              onTap: () {
                                Navigator.pushNamed(context, '/hibsim', arguments: {'fromSphib': false});
                              },
                            ),
                            ProjectCard(
                              title: 'CNC Custom',
                              description: 'CNC rotativa de 3 ejes',
                              imagePath: 'assets/cnc_custom.jpg',
                              onTap: () {
                                Navigator.pushNamed(context, '/cnc');
                              },
                            ),
                            ProjectCard(
                              title: 'Qué he aprendido construyendo',
                              description: 'Reflexión y resumen sobre lo aprendido en el desarrollo de proyectos',
                              imagePath: 'assets/aprendido_foto.jpg',
                              onTap: () {
                                Navigator.pushNamed(context, '/aprendido');
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            top: _isNavBarVisible ? 0 : -60,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      _scrollController.animateTo(
                        0,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Text('Inicio', style: TextStyle(color: Colors.black, fontSize: 16)),
                  ),
                  SizedBox(width: 16),
                  TextButton(
                    onPressed: () {
                      Utils.launchURL(context, 'https://yourwebsite.com/cv.pdf');
                    },
                    child: Text('CV', style: TextStyle(color: Colors.black, fontSize: 16)),
                  ),
                  SizedBox(width: 16),
                  TextButton(
                    onPressed: () {
                      Utils.launchURL(context, 'https://www.linkedin.com/in/jorge-p%C3%A9rez-carrillo-698b92354/');
                    },
                    child: Text('LinkedIn', style: TextStyle(color: Colors.black, fontSize: 16)),
                  ),
                  SizedBox(width: 16),
                  TextButton(
                    onPressed: () {
                      Scrollable.ensureVisible(
                        _projectsKey.currentContext!,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Text('Proyectos', style: TextStyle(color: Colors.black, fontSize: 16)),
                  ),
                ],
              ),
            ),
          ),
          if (!_isNavBarVisible)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isNavBarVisible = true;
                  });
                },
                child: Container(
                  height: 20,
                  color: Colors.white.withOpacity(0.8),
                  child: Center(
                    child: Text(
                      '^',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
          if (isMobile && isPortrait)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      'Para una mejor experiencia, por favor gira tu dispositivo a modo horizontal.',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  final String title;
  final String description;
  final String? imagePath;
  final VoidCallback? onTap;

  const ProjectCard({
    Key? key,
    required this.title,
    required this.description,
    this.imagePath,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool hasImage = imagePath != null && imagePath!.isNotEmpty;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Card(
        elevation: 4,
        child: SizedBox(
          width: 200,
          height: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: hasImage
                    ? Image.asset(
                        imagePath!,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF323B4A),
                              Color(0xFF4E5A6B),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.menu_book_rounded,
                                  size: 56,
                                  color: Colors.white,
                                ),
                                SizedBox(height: 12),
                                Text(
                                  'Texto y reflexión',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class SphibPage extends StatefulWidget {
  @override
  _SphibPageState createState() => _SphibPageState();
}


class _SphibPageState extends State<SphibPage> {
  late VideoPlayerController _controllerSection0;
  late VideoPlayerController _controllerSection1;

  @override
  void initState() {
    super.initState();
    _controllerSection0 = VideoPlayerController.asset('assets/sphib_video.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controllerSection0.play();
        _controllerSection0.setLooping(false);
      });
    _controllerSection1 = VideoPlayerController.asset('assets/sphib_video2.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controllerSection1.play();
        _controllerSection1.setLooping(true);
      });
  }

  @override
  void dispose() {
    _controllerSection0.dispose();
    _controllerSection1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final bool isMobile = !kIsWeb && (Platform.isAndroid || Platform.isIOS);
    final bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      backgroundColor: Color(0xFF323B4A),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              child: Text('Inicio', style: TextStyle(color: Colors.black, fontSize: 16)),
            ),
            SizedBox(width: 16),
            TextButton(
              onPressed: () {
                Utils.launchURL(context, 'https://yourwebsite.com/cv.pdf');
              },
              child: Text('CV', style: TextStyle(color: Colors.black, fontSize: 16)),
            ),
            SizedBox(width: 16),
            TextButton(
              onPressed: () {
                Utils.launchURL(context, 'https://www.linkedin.com/in/jorge-p%C3%A9rez-carrillo-698b92354/');
              },
              child: Text('LinkedIn', style: TextStyle(color: Colors.black, fontSize: 16)),
            ),
            SizedBox(width: 16),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              child: Text('Proyectos', style: TextStyle(color: Colors.black, fontSize: 16)),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              children: [
                // Sección 0: Video y descripción inicial
                Container(
                  height: screenHeight,
                  color: Color(0xFF323B4A),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: _controllerSection0.value.isInitialized
                            ? VideoPlayer(_controllerSection0)
                            : Center(child: CircularProgressIndicator()),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Sistema de Propulsión Híbrida - SPHIB',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Proyecto personal de desarrollo de un sistema de propulsión híbrido, utilizando parafina como combustible y óxido nitroso (N₂O) como oxidante.',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white70,
                                ),
                              ),
                              SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                  minimumSize: Size(300, 50),
                                ),
                                child: Text(
                                  'Proyecto aún en desarrollo, baja para ver más sobre él',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Sección 1: Segundo video centrado con texto arriba
                Container(
                  height: screenHeight,
                  color: Color(0xFF323B4A),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(32.0),
                        child: Container(
                          padding: EdgeInsets.all(24.0),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.7,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'SPHIB - Ingeniería del sistema',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'El sistema se divide en 2 secciones, Bloque de Combustión: Inyector, Cámara y Tobera y Sistema de Alimentación de Oxidante: Tanque, Servoválvulas y Sensores, utilizando un ESP32 que controla las servoválvulas de diseño propio, lee los sensores y retransmite los datos en tiempo real, además de almacenarlos localmente para su posterior análisis.',
                                  style: TextStyle(fontSize: 16, color: Colors.black),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: _controllerSection1.value.isInitialized
                                ? VideoPlayer(_controllerSection1)
                                : CircularProgressIndicator(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Sección 2 (con botón a HIBSIM)
                Container(
                  height: screenHeight,
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/section2.jpg',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Container(
                            padding: EdgeInsets.all(24.0),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width * 0.7,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'SPHIB - Simulación',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    'En paralelo con el desarrollo del sistema, estoy creando un programa de simulación en MATLAB Simulink inspirado en HRAP, que modela el vaciado del tanque, el flujo del oxidante y el rendimiento del motor en distintas condiciones.',
                                    style: TextStyle(fontSize: 16, color: Colors.black),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 16),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/hibsim', arguments: {'fromSphib': true});
                                    },
                                    child: Text('Ver HIBSIM'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Sección 3 (con botón a detalles)
                Container(
                  height: screenHeight,
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/section3.jpg',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Container(
                            padding: EdgeInsets.all(24.0),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width * 0.7,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'SPHIB - CFD',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    'Estoy utilizando herramientas de (CFD) para el diseño de los inyectores. El objetivo es validar el funcionamiento de los inyectores en diseño (antes de obtenerlos) para asegurar, en mi programa de simulación de MATLAB, una representación fiel al comportamiento del inyector en la realidad, garantizando que los resultados obtenidos en mi programa sean correctos. Posteriormente, el objetivo es realizar diversas pruebas en un banco para la validación final de los inyectores antes de proceder con los encendidos estáticos del motor.',
                                    style: TextStyle(fontSize: 16, color: Colors.black),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 16),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/sphib_details');
                                    },
                                    child: Text('Más Detalles'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Nueva Sección: Diseño del Tanque
                Container(
                  height: screenHeight,
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/sphib_tank_design.jpg',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Container(
                            padding: EdgeInsets.all(24.0),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width * 0.7,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'SPHIB - Diseño del Tanque',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    'El diseño inicial del tanque contemplaba aluminio 6061-T6 o 7070, pero ante la imposibilidad de conseguirlos finalmente se fabricó en 6063-T5. Está diseñado con un Excel propio que creé inicialmente para motores sólidos, pensado para prevenir nuevos fallos estructurales por sobrepresión o “desmontajes no planificados”. Con el tiempo lo fui mejorando, y su última versión me permite calcular tanques como este, incorporando un segundo anillo de pernos radiales en lugar de uno solo por lado. El diseño está preparado para soportar 60 bar y ha sido validado mediante pruebas hidrostáticas.',
                                    style: TextStyle(fontSize: 16, color: Colors.black),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Sección 4 (con botón a planos)
                Container(
                  height: screenHeight,
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/section4.jpg',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Container(
                            padding: EdgeInsets.all(24.0),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width * 0.7,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'SPHIB - Diseño y planos',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    'Aquí se encuentran los planos técnicos y modelos 3D de la cámara de combustión, tobera e inyector de mi motor híbrido, diseñados en Siemens NX y Fusion 360. Estos diseños han sido desarrollados y optimizados a partir del programa de simulación en MATLAB presentado anteriormente, junto con pruebas en CFD que han permitido validar el desempeño del diseño del inyector antes de su fabricación. Aquí podrás ver tanto la documentación técnica como una representación detallada del motor en su conjunto. (Aún faltan algunos planos y modelos, además de que algunos son versiones antiguas y desactualizadas)',
                                    style: TextStyle(fontSize: 16, color: Colors.black),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 16),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/sphib_plans');
                                    },
                                    child: Text('Ver planos'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Nueva Sección: Experimentación
Container(
  height: screenHeight,
  child: Stack(
    children: [
      Image.asset(
        'assets/fondo_HEM.jpg', // Asegúrate de tener esta imagen en tus assets
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
      Align(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Container(
            padding: EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'SPHIB - Tests Trasvase e Inyector',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'El objetivo de los primeros tests del sistema era probar el trasvase de N2O y caracterizar el inyector para flujo bifasico y para flujo monofasico incompresible. Para ello, el primer test consistió en el llenado completo del tanque y de su vaciado simulando el flujo de operaciones que correspondería con el de un encendido estático. Este vaciado se realizó desde una diferencia de presiones entre el inyector y el exterior de 51 bar, ya que el objetivo era medir el flujo crítico debido al flujo bifásico. Posterior a este test se realizará en un futuro la prueba para flujo monofascio compresible para obtener el coeficiente de descarga del inyector a lo largo de todas las diferencias de presiones en las que no hay flujo bifasico. Estas tres pruebas son primordiales apra obtener unos resultados mas fieles a la realidad en el simulador, ademas de que permiten realizar ajustes en el diseño del sistema.',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ],
  ),
),

              ],
            ),
          ),
          if (isMobile && isPortrait)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      'Para una mejor experiencia, por favor gira tu dispositivo a modo horizontal.',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class SphibDetailsPage extends StatefulWidget {
  @override
  _SphibDetailsPageState createState() => _SphibDetailsPageState();
}

class _SphibDetailsPageState extends State<SphibDetailsPage> {
  bool _isGlowing = false;
  late Timer _glowTimer;

  @override
  void initState() {
    super.initState();
    _glowTimer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      setState(() {
        _isGlowing = !_isGlowing;
      });
    });
  }

  @override
  void dispose() {
    _glowTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final bool isMobile = !kIsWeb && (Platform.isAndroid || Platform.isIOS);
    final bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      backgroundColor: Color(0xFF323B4A),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              child: Text('Inicio', style: TextStyle(color: Colors.black, fontSize: 16)),
            ),
            SizedBox(width: 16),
            TextButton(
              onPressed: () {
                Utils.launchURL(context, 'https://yourwebsite.com/cv.pdf');
              },
              child: Text('CV', style: TextStyle(color: Colors.black, fontSize: 16)),
            ),
            SizedBox(width: 16),
            TextButton(
              onPressed: () {
                Utils.launchURL(context, 'https://www.linkedin.com/in/jorge-p%C3%A9rez-carrillo-698b92354/');
              },
              child: Text('LinkedIn', style: TextStyle(color: Colors.black, fontSize: 16)),
            ),
            SizedBox(width: 16),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              child: Text('Proyectos', style: TextStyle(color: Colors.black, fontSize: 16)),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              children: [
                // Sección 1
                Container(
                  height: screenHeight,
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/sphib_details1.jpg',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Container(
                            padding: EdgeInsets.all(24.0),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width * 0.7,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Introducción al CFD',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    'Mediante simulaciones en ANSYS CFX y ANSYS Fluent, analizo el flujo de oxidante, la pérdida de presión tras el inyector y las líneas de corriente del flujo.',
                                    style: TextStyle(fontSize: 16, color: Colors.black),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Sección 2
                Container(
                  height: screenHeight,
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/sphib_details2.jpg',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Container(
                            padding: EdgeInsets.all(24.0),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width * 0.7,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Diferentes diseños',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    'Antes de obtener el inyector final, he realizado pruebas con diferentes tipos de orificios para los inyectores, variando sus características y dimensiones para analizar su comportamiento. Este proceso me ha permitido comparar el comportamiento de cada diseño y seleccionar el más adecuado para mi motor.',
                                    style: TextStyle(fontSize: 16, color: Colors.black),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Sección 3
                Container(
                  height: screenHeight,
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/sphib_details3.jpg',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Container(
                            padding: EdgeInsets.all(24.0),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width * 0.7,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Optimización del Diseño',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    'Utilizando los resultados de las simulaciones de CFD, se pueden realizar iteraciones en el diseño de los inyectores para optimizar su geometría. Esto incluye ajustar el ángulo de inyección, el diámetro de los orificios y la distribución del flujo para asegurar que el oxidante se desplaza y distribuye correctamente por el puerto de combustión del grano.',
                                    style: TextStyle(fontSize: 16, color: Colors.black),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 32,
            left: 32,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.red.withOpacity(_isGlowing ? 0.6 : 0.3),
                    blurRadius: _isGlowing ? 20 : 10,
                    spreadRadius: _isGlowing ? 5 : 2,
                  ),
                ],
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/sphib');
                },
                child: Text(
                  'Volver a SPHIB',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ),
          ),
          if (isMobile && isPortrait)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      'Para una mejor experiencia, por favor gira tu dispositivo a modo horizontal.',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class SphibPlansPage extends StatefulWidget {
  @override
  _SphibPlansPageState createState() => _SphibPlansPageState();
}

class _SphibPlansPageState extends State<SphibPlansPage> {
  bool _isGlowing = false;
  late Timer _glowTimer;

  @override
  void initState() {
    super.initState();
    _glowTimer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      setState(() {
        _isGlowing = !_isGlowing;
      });
    });
  }

  @override
  void dispose() {
    _glowTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final bool isMobile = !kIsWeb && (Platform.isAndroid || Platform.isIOS);
    final bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      backgroundColor: Color(0xFF323B4A),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              child: Text('Inicio', style: TextStyle(color: Colors.black, fontSize: 16)),
            ),
            SizedBox(width: 16),
            TextButton(
              onPressed: () {
                Utils.launchURL(context, 'https://yourwebsite.com/cv.pdf');
              },
              child: Text('CV', style: TextStyle(color: Colors.black, fontSize: 16)),
            ),
            SizedBox(width: 16),
            TextButton(
              onPressed: () {
                Utils.launchURL(context, 'https://www.linkedin.com/in/jorge-p%C3%A9rez-carrillo-698b92354/');
              },
              child: Text('LinkedIn', style: TextStyle(color: Colors.black, fontSize: 16)),
            ),
            SizedBox(width: 16),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              child: Text('Proyectos', style: TextStyle(color: Colors.black, fontSize: 16)),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  height: screenHeight,
                  child: Image.asset(
                    'assets/sphib_plans1.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                Container(
                  height: screenHeight,
                  child: Image.asset(
                    'assets/sphib_plans2.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                Container(
                  height: screenHeight,
                  child: Image.asset(
                    'assets/sphib_plans3.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                Container(
                  height: screenHeight,
                  child: Image.asset(
                    'assets/sphib_plans4.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                Container(
                  height: screenHeight,
                  child: Image.asset(
                    'assets/sphib_plans5.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 32,
            left: 32,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.red.withOpacity(_isGlowing ? 0.6 : 0.3),
                    blurRadius: _isGlowing ? 20 : 10,
                    spreadRadius: _isGlowing ? 5 : 2,
                  ),
                ],
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/sphib');
                },
                child: Text(
                  'Volver a SPHIB',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ),
          ),
          if (isMobile && isPortrait)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      'Para una mejor experiencia, por favor gira tu dispositivo a modo horizontal.',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class HibsimPage extends StatefulWidget {
  @override
  _HibsimPageState createState() => _HibsimPageState();
}

class _HibsimPageState extends State<HibsimPage> {
  bool _isGlowing = false;
  late Timer _glowTimer;

  @override
  void initState() {
    super.initState();
    _glowTimer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      setState(() {
        _isGlowing = !_isGlowing;
      });
    });
  }

  @override
  void dispose() {
    _glowTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final bool isMobile = !kIsWeb && (Platform.isAndroid || Platform.isIOS);
    final bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    final Map<String, dynamic>? args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final bool fromSphib = args != null && args['fromSphib'] == true;

    return Scaffold(
      backgroundColor: Color(0xFF323B4A),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              child: Text('Inicio', style: TextStyle(color: Colors.black, fontSize: 16)),
            ),
            SizedBox(width: 16),
            TextButton(
              onPressed: () {
                Utils.launchURL(context, 'https://yourwebsite.com/cv.pdf');
              },
              child: Text('CV', style: TextStyle(color: Colors.black, fontSize: 16)),
            ),
            SizedBox(width: 16),
            TextButton(
              onPressed: () {
                Utils.launchURL(context, 'https://www.linkedin.com/in/jorge-p%C3%A9rez-carrillo-698b92354/');
              },
              child: Text('LinkedIn', style: TextStyle(color: Colors.black, fontSize: 16)),
            ),
            SizedBox(width: 16),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              child: Text('Proyectos', style: TextStyle(color: Colors.black, fontSize: 16)),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              children: [
                // Sección 1
                Container(
                  height: screenHeight,
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/hibsim_section1.jpg',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Container(
                            padding: EdgeInsets.all(24.0),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width * 0.7,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'HIBSIM - Introducción al Simulador',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    'El simulador en Simulink modela el comportamiento de un motor cohete híbrido, incluyendo la dinámica del tanque de N₂O, la cámara de combustión y la tobera. Utiliza dos bloques de MATLAB Function: uno para la bombona y otro para la cámara de combustión, los cuales se retroalimentan en cada iteración. La presión de la cámara influye en el flujo de oxidante, y este flujo determina la siguiente presión de combustión, permitiendo una simulación realista basada en datos termodinámicos del NIST. No obstante, el modelo de la bombona aún se encuentra en desarrollo, ya que requiere una mayor precisión en la representación del comportamiento termodinámico del N₂O durante su fase de vaciado y cambios de estado.',
                                    style: TextStyle(fontSize: 16, color: Colors.black),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Sección 2
                Container(
                  height: screenHeight,
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/hibsim_section2.jpg',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Container(
                            padding: EdgeInsets.all(24.0),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width * 0.7,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'HIBSIM - Panel Principal y Gráficas',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    'El panel principal muestra las variables clave del sistema en tiempo real. Incluye gráficos sobre el estado del fluido dentro de la bombona (gas, líquido y total), la evolución de la presión en la bombona y la cámara de combustión, el flujo de oxidante y la regresión del combustible. También se representa el flujo total a través de la tobera, permitiendo visualizar el comportamiento global del motor híbrido a lo largo de la simulación.',
                                    style: TextStyle(fontSize: 16, color: Colors.black),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Sección 3
                Container(
                  height: screenHeight,
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/hibsim_section3.jpg',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Container(
                            padding: EdgeInsets.all(24.0),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width * 0.7,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'HIBSIM - Cálculo Automático del Área de Salida de la Tobera',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    'El simulador incluye un recuadro que calcula automáticamente los parámetros óptimos para la tobera siguiendo el modelo de tobera RAO. El programa utiliza la información obtenida de la simulación y el diámetro de la garganta introducido por el usuario para generar los datos del contorno de la tobera.',
                                    style: TextStyle(fontSize: 16, color: Colors.black),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Sección 4
                Container(
                  height: screenHeight,
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/hibsim_section4.jpg',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Container(
                            padding: EdgeInsets.all(24.0),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width * 0.7,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'HIBSIM - Indicadores Clave y Parámetros de Desempeño',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    'Para facilitar el análisis del motor, se han implementado marcadores con valores importantes como la presión final de la bombona, la cantidad restante de oxidante, la presión media en la cámara de combustión y la presión máxima alcanzada. Además, se muestran en tiempo real datos como la tasa de regresión del combustible, el impulso total, el impulso específico y la relación O/F (Oxidizer/Fuel), permitiendo evaluar el desempeño en cada iteración.',
                                    style: TextStyle(fontSize: 16, color: Colors.black),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Sección 5
                Container(
                  height: screenHeight,
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/hibsim_section5.jpg',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Container(
                            padding: EdgeInsets.all(24.0),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width * 0.7,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'HIBSIM - Evolución del Combustible y Representación Gráfica',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    'Tras ejecutar la simulación, se genera automáticamente un gráfico que representa la evolución del grano de combustible. Se muestra el perfil inicial y cómo se ha ido consumiendo con el tiempo, visualizando la regresión del combustible a lo largo de las iteraciones. Este gráfico permite analizar de manera clara el proceso de combustión y la eficiencia del motor en función del flujo de oxidante y la presión en la cámara.',
                                    style: TextStyle(fontSize: 16, color: Colors.black),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (fromSphib)
            Positioned(
              bottom: 32,
              left: 32,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red.withOpacity(_isGlowing ? 0.6 : 0.3),
                      blurRadius: _isGlowing ? 20 : 10,
                      spreadRadius: _isGlowing ? 5 : 2,
                    ),
                  ],
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/sphib');
                  },
                  child: Text(
                    'Volver a SPHIB',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
              ),
            ),
          if (isMobile && isPortrait)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      'Para una mejor experiencia, por favor gira tu dispositivo a modo horizontal.',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class RocketElectronicsPage extends StatefulWidget {
  @override
  _RocketElectronicsPageState createState() => _RocketElectronicsPageState();
}

class _RocketElectronicsPageState extends State<RocketElectronicsPage> {
  bool _isGlowing = false;
  late Timer _glowTimer;

  @override
  void initState() {
    super.initState();
    _glowTimer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      setState(() {
        _isGlowing = !_isGlowing;
      });
    });
  }

  @override
  void dispose() {
    _glowTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final bool isMobile = !kIsWeb && (Platform.isAndroid || Platform.isIOS);
    final bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      backgroundColor: Color(0xFF323B4A),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              child: Text('Inicio', style: TextStyle(color: Colors.black, fontSize: 16)),
            ),
            SizedBox(width: 16),
            TextButton(
              onPressed: () {
                Utils.launchURL(context, 'https://yourwebsite.com/cv.pdf');
              },
              child: Text('CV', style: TextStyle(color: Colors.black, fontSize: 16)),
            ),
            SizedBox(width: 16),
            TextButton(
              onPressed: () {
                Utils.launchURL(context, 'https://www.linkedin.com/in/jorge-p%C3%A9rez-carrillo-698b92354/');
              },
              child: Text('LinkedIn', style: TextStyle(color: Colors.black, fontSize: 16)),
            ),
            SizedBox(width: 16),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              child: Text('Proyectos', style: TextStyle(color: Colors.black, fontSize: 16)),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  height: screenHeight,
                  padding: EdgeInsets.all(32.0),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(24.0),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.7,
                          ),
                          child: Text(
                            'Este es mi primer prototipo de electrónica desarrollado en KICAD, está basado en un STM32 e incluye los mismos sensores que la anterior electrónica. Finalmente, la electrónica utilizada en el cohete es la anteriormente mostrada, dada su mayor simplicidad y mi mayor dominio en su lenguaje de programación.',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(height: 32),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: Image.asset(
                                  'assets/rocket_electronics1.jpg',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: Image.asset(
                                  'assets/rocket_electronics2.jpg',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 32,
            left: 32,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.red.withOpacity(_isGlowing ? 0.6 : 0.3),
                    blurRadius: _isGlowing ? 20 : 10,
                    spreadRadius: _isGlowing ? 5 : 2,
                  ),
                ],
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/rocket');
                },
                child: Text(
                  'Volver a Cohete Experimental',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ),
          ),
          if (isMobile && isPortrait)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      'Para una mejor experiencia, por favor gira tu dispositivo a modo horizontal.',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class RocketEnginePlanPage extends StatefulWidget {
  @override
  _RocketEnginePlanPageState createState() => _RocketEnginePlanPageState();
}

class _RocketEnginePlanPageState extends State<RocketEnginePlanPage> {
  bool _isGlowing = false;
  late Timer _glowTimer;

  @override
  void initState() {
    super.initState();
    _glowTimer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      setState(() {
        _isGlowing = !_isGlowing;
      });
    });
  }

  @override
  void dispose() {
    _glowTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final bool isMobile = !kIsWeb && (Platform.isAndroid || Platform.isIOS);
    final bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      backgroundColor: Color(0xFF323B4A),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              child: Text('Inicio', style: TextStyle(color: Colors.black, fontSize: 16)),
            ),
            SizedBox(width: 16),
            TextButton(
              onPressed: () {
                Utils.launchURL(context, 'https://yourwebsite.com/cv.pdf');
              },
              child: Text('CV', style: TextStyle(color: Colors.black, fontSize: 16)),
            ),
            SizedBox(width: 16),
            TextButton(
              onPressed: () {
                Utils.launchURL(context, 'https://www.linkedin.com/in/jorge-p%C3%A9rez-carrillo-698b92354/');
              },
              child: Text('LinkedIn', style: TextStyle(color: Colors.black, fontSize: 16)),
            ),
            SizedBox(width: 16),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              child: Text('Proyectos', style: TextStyle(color: Colors.black, fontSize: 16)),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  height: screenHeight,
                  child: Image.asset(
                    'assets/rocket_engine_plan.jpg',
                    fit: BoxFit.contain,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 32,
            left: 32,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.red.withOpacity(_isGlowing ? 0.6 : 0.3),
                    blurRadius: _isGlowing ? 20 : 10,
                    spreadRadius: _isGlowing ? 5 : 2,
                  ),
                ],
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/rocket');
                },
                child: Text(
                  'Volver a Cohete Experimental',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ),
          ),
          if (isMobile && isPortrait)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      'Para una mejor experiencia, por favor gira tu dispositivo a modo horizontal.',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
class CncCustomPage extends StatelessWidget {
  const CncCustomPage({Key? key}) : super(key: key);

  Widget _buildSection(
    BuildContext context, {
    required String imagePath,
    required String title,
    required String text,
  }) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight,
      child: Stack(
        children: [
          Image.asset(
            imagePath,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: Container(
                padding: EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16),
                      Text(
                        text,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 900;
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      backgroundColor: Color(0xFF323B4A),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              child: Text(
                'Inicio',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
            SizedBox(width: 16),
            TextButton(
              onPressed: () {
                Utils.launchURL(context, 'https://yourwebsite.com/cv.pdf');
              },
              child: Text(
                'CV',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
            SizedBox(width: 16),
            TextButton(
              onPressed: () {
                Utils.launchURL(
                  context,
                  'https://www.linkedin.com/in/jorge-p%C3%A9rez-carrillo-698b92354/',
                );
              },
              child: Text(
                'LinkedIn',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
            SizedBox(width: 16),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              child: Text(
                'Proyectos',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              children: [
                _buildSection(
                  context,
                  imagePath: 'assets/cnc_section1.jpg',
                  title: 'CNC rotativa 3 ejes',
                  text: 'Esta máquina surgió de la necesidad de mecanizar insertos de grafito para la tobera de la V2 del SPHIB. Es una cnc de 3 ejes que ahce uso de un dremel, sus ejes son: plato giratorio, carro, y tornillo sin fin, este ultimo es el que impulsa el dremel.',
                ),
                _buildSection(
                  context,
                  imagePath: 'assets/cnc_section2.jpg',
                  title: 'Hardware y Electrónica "Custom"',
                  text: 'En cuanto a la unidad de control, utilizo un ESP32 ejecutando FluidNC, la electrónica está ensamblada en una placa perforada que integra los tres drivers TMC2209. En cuanto al resto del hardware, está compuesta en su mayoría por piezas de una Ender3V2Neo que iba a deshechar, reutilzando así, su fuente, los steppers y los ejes.',
                ),
                _buildSection(
                  context,
                  imagePath: 'assets/cnc_section3.jpg',
                  title: 'Scripts de automatizacion',
                  text: 'Dado que FluidNC no soporta comandos de desbastado ni muchos otros, he recurrido al desarrollo y perfeccionamiento de un script de matlab con ayuda de inteligencia artifical para generar automaticamente el Gcode de la maquina según el perfil deseado en la pieza, ademas de las especificaciones del desbastado y acabado.',
                ),
                _buildSection(
                  context,
                  imagePath: 'assets/cnc_section4.jpg',
                  title: 'Resultados y aplicaciones',
                  text: 'La primera pieza hecha con esta CNC custom ha sido una sección convergente de una tobera(diseñada a ojo), para comprobar la estabilidad de la maquina y sus ejes, y la fiabilidad del gcode generado por el script de Matlab. Lastimosamente para la primera prueba de la máquina los comandos G02 y G03 fueron intercambiados en el script de ploteo de gcode (el cual uso para comprobar el gcode antes de enchufarlo a la maquina), y finalmente las trayectorias curvas quedaron en el sentido contrario :( , para las proximas piezas lo solucionaré ',
                ),
              ],
            ),
          ),
          if (isMobile && isPortrait)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      'Para una mejor experiencia, por favor gira tu dispositivo a modo horizontal.',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
class AprendidoPage extends StatelessWidget {
  const AprendidoPage({Key? key}) : super(key: key);

  Widget _buildTextSection({
    required BuildContext context,
    required String title,
    required String text,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.85),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.75,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = !kIsWeb && (Platform.isAndroid || Platform.isIOS);
    final bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      backgroundColor: Color(0xFF323B4A),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              child: Text('Inicio', style: TextStyle(color: Colors.black, fontSize: 16)),
            ),
            SizedBox(width: 16),
            TextButton(
              onPressed: () {
                Utils.launchURL(context, 'https://yourwebsite.com/cv.pdf');
              },
              child: Text('CV', style: TextStyle(color: Colors.black, fontSize: 16)),
            ),
            SizedBox(width: 16),
            TextButton(
              onPressed: () {
                Utils.launchURL(context, 'https://www.linkedin.com/in/jorge-p%C3%A9rez-carrillo-698b92354/');
              },
              child: Text('LinkedIn', style: TextStyle(color: Colors.black, fontSize: 16)),
            ),
            SizedBox(width: 16),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              child: Text('Proyectos', style: TextStyle(color: Colors.black, fontSize: 16)),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 1100),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(32.0),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.85),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Un resumen de que he aprendido desarrollando estos proyectos.',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 16),
                            Text(
                              '',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black87,
                                height: 1.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24),

                      _buildTextSection(
                        context: context,
                        title: '',
                        text: 'Sacando adelante proyectos como el SPHIB por mi cuenta he podido darme cuenta de que el grueso de trabajo no está solamente en la parte motor ,de lo que se supone que iba el proyecto. Sino que hay muchas otras partes esenciales del proyecto que requieren de mucho tiempo y recursos. Al tener que tocar tantas áreas muy distintas no siempre he podido centrarme tanto como me habría gustado en las partes críticas o las que mas me gustaban , como el motor. Además, cuando decisiones como el diseño de piezas, o cualquier otra cosa, dependen de una sola persona, algunos errores tardan demasiado en ser detectados, por lo que se arrastran durante demasiado tiempo, lo cual conlleva mayores costes y tiempo necesario para arreglarlo. Finalmente, tras todos los proyectos, y sobretodo el SPHIB, he llegado a la conclusión de que este tipo de proyectos saldrían mejor hechos en equipo, ya no solo por la división de trabajo, que también, si no porque seguramente muchos de los errores tontos que he cometido podrían haber sido detectados antes bajo el criterio de mas personas, no sólo mi criterio, que en un inicio puede ser erroneo. Además que podrían haber llegado mucho mas lejos, y en menos tiempo. Dicho esto, y dado que sigo a varios y puedo observar cómo son, si en mi universidad hubiera un club de cohetería, probablemente me habría unido desde el principio, quitándome muchos de estos problemas problemas. \n\n\n Aún así, creo que desarrollar estos proyectos por mi cuenta me ha hecho aprender mucho como es el desarrollo de un proyecto así partiendo desde 0, desde la investigación inicial, cálculos, diseños, y sobretodo testeo e iteración hasta obtener los resultados deseados. He aprendido también a analizar mejor los problemas para saber de donde parten y como solucionarlos de la forma que considero más óptima. Además, he aprendido perseverancia, aunque el proyecto no avance o arrastre un error desde el inicio y tenga que rediseñar y rehacer gran parte del trabajo. Todo ello mientras los intento llevar a cabo a la vez que la universidad, y gestiono los recursos de los que dispongo. \n\n\n En general, aunque evidentemente no son proyectos al nivel de la NASA :v, dadas las circunstancias, me han servido para entender mejor cómo se desarrolla un proyecto desde cero, aunque quiza existan formas mas óptimas por descubrir.',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (isMobile && isPortrait)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      'Para una mejor experiencia, por favor gira tu dispositivo a modo horizontal.',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
class RocketPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final bool isMobile = !kIsWeb && (Platform.isAndroid || Platform.isIOS);
    final bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      backgroundColor: Color(0xFF323B4A),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              child: Text('Inicio', style: TextStyle(color: Colors.black, fontSize: 16)),
            ),
            SizedBox(width: 16),
            TextButton(
              onPressed: () {
                Utils.launchURL(context, 'https://yourwebsite.com/cv.pdf');
              },
              child: Text('CV', style: TextStyle(color: Colors.black, fontSize: 16)),
            ),
            SizedBox(width: 16),
            TextButton(
              onPressed: () {
                Utils.launchURL(context, 'https://www.linkedin.com/in/jorge-p%C3%A9rez-carrillo-698b92354/');
              },
              child: Text('LinkedIn', style: TextStyle(color: Colors.black, fontSize: 16)),
            ),
            SizedBox(width: 16),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              child: Text('Proyectos', style: TextStyle(color: Colors.black, fontSize: 16)),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              children: [
                // Sección 1: Imagen izquierda, texto derecha
                Container(
                  height: screenHeight,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Image.asset(
                            'assets/rocket_section1.jpg',
                            fit: BoxFit.contain,
                            height: screenHeight * 0.8,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Container(
                            padding: EdgeInsets.all(24.0),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width * 0.7,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Cohete',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    'Proyecto personal de desarrollo de un cohete experimental diseñado completamente desde cero. Desde la estructura hasta el sistema de eyección, cada componente ha sido fabricado y probado para garantizar un funcionamiento eficiente y seguro.',
                                    style: TextStyle(fontSize: 16, color: Colors.black),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    'El cohete incorpora un sistema de recuperación con paracaídas, una electrónica personalizada y un motor desarrollado a medida. Los datos de vuelo se almacenan y posteriormente se procesan en MATLAB para analizar el rendimiento del lanzamiento.',
                                    style: TextStyle(fontSize: 16, color: Colors.black),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Sección 2: Imagen izquierda, texto centro, imagen derecha
                Container(
                  height: screenHeight,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Image.asset(
                            'assets/rocket_section2_left.jpg',
                            fit: BoxFit.contain,
                            height: screenHeight * 0.8,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Container(
                            padding: EdgeInsets.all(24.0),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width * 0.7,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Cohete - Propulsión',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    'Desarrollo y prueba de motores de combustible sólido. El diseño principal corresponde a un motor de clase G130 para el cohete, con posibilidad de adaptación a motores de clase H.',
                                    style: TextStyle(fontSize: 16, color: Colors.black),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    'Ayudándome de las simulaciones del software de OpenMotor, y de una hoja de Excel de elaboración propia para la comprobación de la integridad estructural del motor, asegurando que los materiales y dimensiones seleccionados soporten las cargas y esfuerzos durante su funcionamiento.',
                                    style: TextStyle(fontSize: 16, color: Colors.black),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 16),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/rocket_engine_plan');
                                    },
                                    child: Text('Click aquí para ver Plano del Motor'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Image.asset(
                            'assets/rocket_section2_right.jpg',
                            fit: BoxFit.contain,
                            height: screenHeight * 0.8,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Sección 3: Imagen izquierda, texto centro, imagen derecha
                Container(
                  height: screenHeight,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Image.asset(
                            'assets/rocket_section3_left.jpg',
                            fit: BoxFit.contain,
                            height: screenHeight * 0.8,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Container(
                            padding: EdgeInsets.all(24.0),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width * 0.7,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Cohete - Electrónica',
                                    style: TextStyle(
                                     fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    'La electrónica incorporada al cohete está basada en un ESP32, acompañado de módulos de barómetro y giroscopio para la adquisición de datos en vuelo. El sistema de eyección de paracaídas por carga pirotécnica es un diseño propio, probado para la recuperación del cohete. Además, cuenta con un módulo de almacenamiento de datos para el análisis post-lanzamiento.',
                                    style: TextStyle(fontSize: 16, color: Colors.black),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 16),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/rocket_electronics');
                                    },
                                    child: Text('Click aquí para ver Electrónica Prototipo'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Image.asset(
                            'assets/rocket_section3_right.jpg',
                            fit: BoxFit.contain,
                            height: screenHeight * 0.8,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Sección 4: Imagen izquierda, texto centro, imagen derecha
                Container(
                  height: screenHeight,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Image.asset(
                            'assets/rocket_section4_left.jpg',
                            fit: BoxFit.contain,
                            height: screenHeight * 0.8,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Container(
                            padding: EdgeInsets.all(24.0),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width * 0.7,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Cohete - Estructura',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    'La estructura del cohete no requiere una resistencia extrema, ya que las cargas mecánicas, la aceleración y las fuerzas aerodinámicas a las que está sometido no son particularmente elevadas, dado que el motor está diseñado para alcanzar una baja altitud (100m) y velocidades.',
                                    style: TextStyle(fontSize: 16, color: Colors.black),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    'Los materiales utilizados son PVC para el fuselaje, PLA para las aletas, cono y estructuras interiores (como bahía de la electrónica), y madera para los anillos de separación de cada sección.',
                                    style: TextStyle(fontSize: 16, color: Colors.black),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Image.asset(
                            'assets/rocket_section4_right.jpg',
                            fit: BoxFit.contain,
                            height: screenHeight * 0.8,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Sección 5: Imagen izquierda, texto centro, imagen derecha
                Container(
                  height: screenHeight,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Image.asset(
                            'assets/rocket_section5_left.jpg',
                            fit: BoxFit.contain,
                            height: screenHeight * 0.8,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Container(
                            padding: EdgeInsets.all(24.0),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width * 0.7,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Cohete - Sistema de Recuperación',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    'El sistema de recuperación está compuesto por el paracaídas y el sistema de eyección, y está diseñado para desplegar el paracaídas en el momento exacto del apogeo (~100m) para asegurar la recuperación y posible reutilización del cohete. Utiliza una carga pirotécnica controlada por la electrónica para eyectar el cono y liberar el paracaídas. Tanto el cono, como el cohete están asegurados al paracaídas.',
                                    style: TextStyle(fontSize: 16, color: Colors.black),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    'Inicialmente el paracaídas estaba diseñado para una velocidad de descenso de 5 m/s, finalmente, tras cambios no previstos en la masa del cohete, esta velocidad aumenta a un valor entre 7 y 8 m/s. El material utilizado ha sido el poliéster, dado que era más accesible y económico que el nylon o el kevlar.',
                                    style: TextStyle(fontSize: 16, color: Colors.black),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    'El sistema de eyección es una carga pirotécnica controlada desde la electrónica del cohete, la cual genera una rápida expansión de los gases que aumenta la presión e impulsa el paracaídas y el cono.',
                                    style: TextStyle(fontSize: 16, color: Colors.black),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Image.asset(
                            'assets/rocket_section5_right.jpg',
                            fit: BoxFit.contain,
                            height: screenHeight * 0.8,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (isMobile && isPortrait)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      'Para una mejor experiencia, por favor gira tu dispositivo a modo horizontal.',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}