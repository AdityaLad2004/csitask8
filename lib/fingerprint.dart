import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'home.dart';
import 'auth.dart';
import 'main.dart';

class FingerprintPage extends StatelessWidget {
  const FingerprintPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(MyApp.title),
          centerTitle: true,
          automaticallyImplyLeading: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(32),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildHeader(),
                const SizedBox(height: 24),
                buildBiometricAvailability(context),
                const SizedBox(height: 24),
                buildAuthenticateButton(context),
              ],
            ),
          ),
        ),
      );

  Widget buildHeader() => Column(
        children: [
          Icon(Icons.fingerprint, size: 64, color: Colors.blue),
          const SizedBox(height: 16),
          Text(
            'Fingerprint Authentication',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      );

  Widget buildBiometricAvailability(BuildContext context) => buildCard(
        title: 'Check Biometric Availability',
        icon: Icons.event_available,
        onClicked: () async {
          final isAvailable = await LocalAuthApi.hasBiometrics();
          final biometrics = await LocalAuthApi.getBiometrics();
          final hasFingerprint = biometrics.contains(BiometricType.fingerprint);

          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Biometric Availability'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  displayBiometricInfo('Biometrics', isAvailable),
                  displayBiometricInfo('Fingerprint', hasFingerprint),
                ],
              ),
            ),
          );
        },
      );

  Widget buildAuthenticateButton(BuildContext context) => buildCard(
        title: 'Authenticate with Biometrics',
        icon: Icons.lock_open,
        onClicked: () async {
          final isAuthenticated = await LocalAuthApi.authenticate();

          if (isAuthenticated) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          }
        },
      );

  Widget displayBiometricInfo(String text, bool checked) => Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            checked
                ? Icon(Icons.check, color: Colors.green, size: 24)
                : Icon(Icons.close, color: Colors.red, size: 24),
            const SizedBox(width: 12),
            Text(text, style: TextStyle(fontSize: 20)),
          ],
        ),
      );

  Widget buildCard({
    required String title,
    required IconData icon,
    required VoidCallback onClicked,
  }) =>
      Card(
        elevation: 5,
        child: ListTile(
          title: Text(title),
          leading: Icon(icon, size: 36, color: Colors.blue),
          onTap: onClicked,
        ),
      );
}
