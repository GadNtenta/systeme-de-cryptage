import 'package:flutter/material.dart';

void main() {
  runApp(const MyAppGad());
}

class MyAppGad extends StatelessWidget {
  const MyAppGad({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cryptage et Décryptage',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CryptoDecryptScreen(),
    );
  }
}

class CryptoDecryptScreen extends StatefulWidget {
  const CryptoDecryptScreen({super.key});

  @override
  _CryptoDecryptScreenState createState() => _CryptoDecryptScreenState();
}

class _CryptoDecryptScreenState extends State<CryptoDecryptScreen> {
  // Contrôleurs pour les champs de saisie
  TextEditingController messageController = TextEditingController();
  TextEditingController keyController = TextEditingController();
  // Variables pour stocker les messages cryptés et décryptés
  String messageCrypte = '';
  String messageDecrypte = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cryptage et Décryptage'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Champ de saisie pour le message
            TextField(
              controller: messageController,
              decoration: const InputDecoration(labelText: 'Message'),
            ),
            // Champ de saisie pour la clé de cryptage/décryptage
            TextField(
              controller: keyController,
              decoration: const InputDecoration(labelText: 'Clé de cryptage/décryptage'),
            ),
            const SizedBox(height: 20),
            // Bouton pour crypter ou décrypter le message
            ElevatedButton(
              onPressed: () {
                setState(() {
                  // Appeler les fonctions de cryptage et de décryptage avec les données saisies
                  messageCrypte = crypterMessage(messageController.text, int.tryParse(keyController.text) ?? 0);
                  messageDecrypte = dechiffrerMessage(messageCrypte, int.tryParse(keyController.text) ?? 0);
                });
              },
              child: const Text('Crypter / Décrypter'),
            ),
            const SizedBox(height: 20),
            // Affichage du message crypté et du message décrypté
            Text('Message Crypté : $messageCrypte'),
            Text('Message Décrypté : $messageDecrypte'),
          ],
        ),
      ),
    );
  }

  // Fonction pour crypter le message
  String crypterMessage(String message, int key) {
    String messageCrypte = '';
    for (int i = 0; i < message.length; i++) {
      // Décalage de chaque caractère du message selon la clé de cryptage
      int charCode = message.codeUnitAt(i) + key;
      messageCrypte += String.fromCharCode(charCode);
    }
    return messageCrypte;
  }

  // Fonction pour décrypter le message
  String dechiffrerMessage(String messageCrypte, int key) {
    String messageDecrypte = '';
    for (int i = 0; i < messageCrypte.length; i++) {
      // Décalage inverse de chaque caractère du message crypté
      int charCode = messageCrypte.codeUnitAt(i) - key;
      messageDecrypte += String.fromCharCode(charCode);
    }
    return messageDecrypte;
  }
}
