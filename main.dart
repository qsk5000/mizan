import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

void main() {
WidgetsFlutterBinding.ensureInitialized();
SystemChrome.setSystemUIOverlayStyle(
const SystemUiOverlayStyle(
statusBarColor: Colors.transparent,
statusBarIconBrightness: Brightness.dark,
),
);
runApp(const MizaniqApp());
}

class MizaniqApp extends StatelessWidget {
const MizaniqApp({super.key});

@override
Widget build(BuildContext context) {
return MaterialApp(
title: ‘ميزانيق’,
debugShowCheckedModeBanner: false,
theme: ThemeData(
colorScheme: ColorScheme.fromSeed(
seedColor: const Color(0xFF1A73E8),
brightness: Brightness.light,
),
useMaterial3: true,
),
home: const SplashScreen(),
);
}
}

// =================== Splash Screen ===================
class SplashScreen extends StatefulWidget {
const SplashScreen({super.key});

@override
State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
with SingleTickerProviderStateMixin {
late AnimationController _controller;
late Animation<double> _fadeAnimation;
late Animation<double> _scaleAnimation;

@override
void initState() {
super.initState();
_controller = AnimationController(
duration: const Duration(milliseconds: 1500),
vsync: this,
);
_fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
CurvedAnimation(parent: _controller, curve: Curves.easeIn),
);
_scaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
);
_controller.forward();

```
Timer(const Duration(seconds: 2), () {
  if (mounted) {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const WebViewScreen(),
        transitionsBuilder: (_, animation, __, child) =>
            FadeTransition(opacity: animation, child: child),
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }
});
```

}

@override
void dispose() {
_controller.dispose();
super.dispose();
}

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: const Color(0xFF1A73E8),
body: Center(
child: FadeTransition(
opacity: _fadeAnimation,
child: ScaleTransition(
scale: _scaleAnimation,
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Container(
width: 120,
height: 120,
decoration: BoxDecoration(
color: Colors.white,
borderRadius: BorderRadius.circular(30),
boxShadow: [
BoxShadow(
color: Colors.black.withOpacity(0.2),
blurRadius: 20,
offset: const Offset(0, 10),
),
],
),
child: const Center(
child: Text(
‘م’,
style: TextStyle(
fontSize: 64,
fontWeight: FontWeight.bold,
color: Color(0xFF1A73E8),
),
),
),
),
const SizedBox(height: 24),
const Text(
‘ميزانيق’,
style: TextStyle(
fontSize: 32,
fontWeight: FontWeight.bold,
color: Colors.white,
letterSpacing: 1.2,
),
),
const SizedBox(height: 8),
Text('mizaniq.online',
style: TextStyle(
fontSize: 14,
color: Colors.white.withOpacity(0.8),
),
),
const SizedBox(height: 48),
const SizedBox(
width: 40,
height: 40,
child: CircularProgressIndicator(
color: Colors.white,
strokeWidth: 3,
),
),
],
),
),
),
),
);
}
}

// =================== WebView Screen ===================
class WebViewScreen extends StatefulWidget {
const WebViewScreen({super.key});

@override
State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
late final WebViewController _controller;
bool _isLoading = true;
bool _hasError = false;
bool _isConnected = true;
double _loadingProgress = 0;
final String _url = ‘https://www.mizaniq.online’;
late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

@override
void initState() {
super.initState();
_checkConnectivity();
_connectivitySubscription = Connectivity()
.onConnectivityChanged
.listen((List<ConnectivityResult> results) {
final connected = !results.contains(ConnectivityResult.none);
setState(() => _isConnected = connected);
if (connected && _hasError) _loadPage();
});
_initWebView();
}

Future<void> _checkConnectivity() async {
final results = await Connectivity().checkConnectivity();
setState(() {
_isConnected = !results.contains(ConnectivityResult.none);
});
}

void _initWebView() {
_controller = WebViewController()
..setJavaScriptMode(JavaScriptMode.unrestricted)
..setBackgroundColor(Colors.white)
..setNavigationDelegate(
NavigationDelegate(
onPageStarted: (url) {
setState(() {
_isLoading = true;
_hasError = false;
_loadingProgress = 0;
});
},
onProgress: (progress) {
setState(() => _loadingProgress = progress / 100);
},
onPageFinished: (url) {
setState(() {
_isLoading = false;
_loadingProgress = 1;
});
},
onWebResourceError: (error) {
setState(() {
_isLoading = false;
_hasError = true;
});
},
onNavigationRequest: (request) {
return NavigationDecision.navigate;
},
),
)
..loadRequest(Uri.parse(_url));
}

void _loadPage() {
setState(() {
_isLoading = true;
_hasError = false;
});
_controller.loadRequest(Uri.parse(_url));
}

Future<bool> _onWillPop() async {
if (await _controller.canGoBack()) {
_controller.goBack();
return false;
}
return true;
}

@override
void dispose() {
_connectivitySubscription.cancel();
super.dispose();
}

@override
Widget build(BuildContext context) {
return PopScope(
canPop: false,
onPopInvoked: (didPop) async {
if (!didPop) {
final canGoBack = await _controller.canGoBack();
if (canGoBack) {
_controller.goBack();
} else {
if (context.mounted) {
showDialog(
context: context,
builder: (ctx) => AlertDialog(
title: const Text(‘خروج’),
content: const Text(‘هل تريد الخروج من التطبيق؟’),
actions: [
TextButton(
onPressed: () => Navigator.of(ctx).pop(),
child: const Text(‘لا’),
),
TextButton(
onPressed: () => SystemNavigator.pop(),
child: const Text(‘نعم’),
),
],
),
);
}
}
}
},
child: Scaffold(
body: SafeArea(
child: Stack(
children: [
// No internet screen
if (!_isConnected)
_buildNoInternetWidget()
// Error screen
else if (_hasError)
_buildErrorWidget()
// WebView
else
WebViewWidget(controller: _controller),

```
          // Loading progress bar
          if (_isLoading && _isConnected && !_hasError)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: LinearProgressIndicator(
                value: _loadingProgress,
                minHeight: 3,
                backgroundColor: Colors.transparent,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFF1A73E8),
                ),
              ),
            ),
        ],
      ),
    ),
  ),
);
```

}

Widget _buildNoInternetWidget() {
return Center(
child: Padding(
padding: const EdgeInsets.all(32),
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Icon(Icons.wifi_off_rounded, size: 80, color: Colors.grey[400]),
const SizedBox(height: 24),
const Text(
‘لا يوجد اتصال بالإنترنت’,
style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
textAlign: TextAlign.center,
),
const SizedBox(height: 12),
Text(
‘يرجى التحقق من اتصالك بالإنترنت والمحاولة مرة أخرى’,
style: TextStyle(fontSize: 14, color: Colors.grey[600]),
textAlign: TextAlign.center,
),
const SizedBox(height: 32),
ElevatedButton.icon(
onPressed: () async {
await _checkConnectivity();
if (_isConnected) _loadPage();
},
icon: const Icon(Icons.refresh),
label: const Text(‘إعادة المحاولة’),
style: ElevatedButton.styleFrom(
backgroundColor: const Color(0xFF1A73E8),
foregroundColor: Colors.white,
padding:
const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(12),
),
),
),
],
),
),
);
}

Widget _buildErrorWidget() {
return Center(
child: Padding(
padding: const EdgeInsets.all(32),
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Icon(Icons.error_outline_rounded, size: 80, color: Colors.red[300]),
const SizedBox(height: 24),
const Text(
‘تعذّر تحميل الصفحة’,
style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
textAlign: TextAlign.center,
),
const SizedBox(height: 12),
Text(
‘حدث خطأ أثناء تحميل الموقع. يرجى المحاولة مرة أخرى.’,
style: TextStyle(fontSize: 14, color: Colors.grey[600]),
textAlign: TextAlign.center,
),
const SizedBox(height: 32),
ElevatedButton.icon(
onPressed: _loadPage,
icon: const Icon(Icons.refresh),
label: const Text(‘إعادة التحميل’),
style: ElevatedButton.styleFrom(
backgroundColor: const Color(0xFF1A73E8),
foregroundColor: Colors.white,
padding:
const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(12),
),
),
),
],
),
),
);
}
}
