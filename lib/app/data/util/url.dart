import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenUrl {
  Future<void> openGoogleMaps(String url) async {
    String? googleMapsUrl = url; // Obtenha o link do TextEditingController

    if (googleMapsUrl.isNotEmpty) {
      // Verifica se o link não está vazio
      if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
        await launchUrl(Uri.parse(googleMapsUrl)); // Abre o link no Google Maps
      } else {
        throw 'Não foi possível abrir o Google Maps.';
      }
    } else {
      print('URL do Google Maps não está disponível.');
    }
  }

}
